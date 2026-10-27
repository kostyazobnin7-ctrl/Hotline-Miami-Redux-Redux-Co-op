using System.IO.Compression;
using System.Security.Cryptography;

// coopdelta <old data.win> <new data.win> <out.hlcd>
// Бинарная разница для релиза без файлов игры. Формат HLCD1:
//   "HLCD1", u64 размер старого, 32 байта SHA-256 старого, u64 размер нового, 32 байта SHA-256 нового,
//   затем Deflate-поток команд: 1 = COPY (i64 смещение в старом, i32 длина), 2 = ADD (i32 длина, байты),
//   0 = конец. Применяет tools/release/install-coop.ps1 (PowerShell, без сторонних программ).
if (args.Length < 3) { Console.Error.WriteLine("usage: coopdelta <old> <new> <out.hlcd>"); return 2; }
var oldB = File.ReadAllBytes(args[0]);
var newB = File.ReadAllBytes(args[1]);
const int W = 32;      // окно сравнения
const int STEP = 16;   // шаг индекса старого файла
const ulong B = 1099511628211UL;
ulong bw = 1; for (int i = 0; i < W - 1; i++) bw *= B; // B^(W-1): вес первого байта окна

ulong H(byte[] a, int p) { ulong h = 0; for (int i = 0; i < W; i++) h = h * B + a[p + i]; return h; }

var index = new Dictionary<ulong, int>(oldB.Length / STEP + 16);
for (int p = 0; p + W <= oldB.Length; p += STEP)
{
    var h = H(oldB, p);
    index.TryAdd(h, p);
}

using var outF = File.Create(args[2]);
var hdr = new BinaryWriter(outF);
hdr.Write(System.Text.Encoding.ASCII.GetBytes("HLCD1"));
hdr.Write((ulong)oldB.Length); hdr.Write(SHA256.HashData(oldB));
hdr.Write((ulong)newB.Length); hdr.Write(SHA256.HashData(newB));
hdr.Flush();
using (var z = new DeflateStream(outF, CompressionLevel.SmallestSize, true))
{
    var bwz = new BinaryWriter(z);
    var add = new MemoryStream();
    long copies = 0, copied = 0;
    void FlushAdd()
    {
        if (add.Length == 0) return;
        bwz.Write((byte)2); bwz.Write((int)add.Length); bwz.Write(add.GetBuffer(), 0, (int)add.Length);
        add.SetLength(0);
    }
    int n = 0;
    ulong rh = newB.Length >= W ? H(newB, 0) : 0;
    while (n < newB.Length)
    {
        bool matched = false;
        if (n + W <= newB.Length && index.TryGetValue(rh, out var op))
        {
            // проверка и расширение совпадения
            int len = 0;
            while (op + len < oldB.Length && n + len < newB.Length && oldB[op + len] == newB[n + len]) len++;
            if (len >= W)
            {
                FlushAdd();
                bwz.Write((byte)1); bwz.Write((long)op); bwz.Write(len);
                copies++; copied += len;
                n += len;
                if (n + W <= newB.Length) rh = H(newB, n);
                matched = true;
            }
        }
        if (matched) continue;
        add.WriteByte(newB[n]);
        if (n + W < newB.Length) rh = (rh - newB[n] * bw) * B + newB[n + W];
        n++;
    }
    FlushAdd();
    bwz.Write((byte)0);
    bwz.Flush();
    Console.WriteLine($"copy-команд {copies}, скопировано {copied} из {newB.Length} байт");
}
Console.WriteLine($"патч {new FileInfo(args[2]).Length / 1024} КБ");
return 0;
