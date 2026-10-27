# Установка кооператива Hotline Miami Redux-Redux Co-op поверх оригинальной игры.
# Install Hotline Miami Redux-Redux Co-op on top of the original game.
# Запуск / run: install-coop.bat (в папке с игрой / in the game folder).
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
$game = Join-Path $dir 'data.win'
$orig = Join-Path $dir 'data.win.original'
$patch = Join-Path $dir 'coop.hlcd'

function Sha256([byte[]]$b) { $s = [System.Security.Cryptography.SHA256]::Create(); return $s.ComputeHash($b) }
function Same([byte[]]$a, [byte[]]$b) { if ($a.Length -ne $b.Length) { return $false }; for ($i = 0; $i -lt $a.Length; $i++) { if ($a[$i] -ne $b[$i]) { return $false } }; return $true }

if (-not (Test-Path $patch)) { throw "Нет файла coop.hlcd рядом со скриптом / coop.hlcd not found next to the script" }
if (-not (Test-Path $game)) { throw "Нет data.win: распакуйте архив в папку с игрой / data.win not found: extract the archive into the game folder" }

$fs = [System.IO.File]::OpenRead($patch)
$br = New-Object System.IO.BinaryReader($fs)
$magic = [System.Text.Encoding]::ASCII.GetString($br.ReadBytes(5))
if ($magic -ne 'HLCD1') { throw "Повреждённый патч / corrupted patch" }
$oldSize = $br.ReadUInt64(); $oldSha = $br.ReadBytes(32)
$newSize = $br.ReadUInt64(); $newSha = $br.ReadBytes(32)

# источник — оригинал: data.win.original (если уже ставили) или текущий data.win
$src = $game
if (Test-Path $orig) { $src = $orig }
$old = [System.IO.File]::ReadAllBytes($src)
$cur = [System.IO.File]::ReadAllBytes($game)
if (Same (Sha256 $cur) $newSha) { Write-Host "Кооператив этой версии уже установлен. / This co-op version is already installed." -ForegroundColor Green; $fs.Close(); exit 0 }
if (-not (Same (Sha256 $old) $oldSha)) {
    $fs.Close()
    throw "Это не та версия Redux-Redux (data.win отличается от ожидаемого). Нужна оригинальная версия мода. / Wrong Redux-Redux version: data.win differs from the expected original."
}

Write-Host "Установка... / Installing..."
$z = New-Object System.IO.Compression.DeflateStream($fs, [System.IO.Compression.CompressionMode]::Decompress)
$r = New-Object System.IO.BinaryReader($z)
$out = New-Object byte[] ([int64]$newSize)
$pos = 0
while ($true) {
    $op = $r.ReadByte()
    if ($op -eq 0) { break }
    if ($op -eq 1) {
        $off = $r.ReadInt64(); $len = $r.ReadInt32()
        [Array]::Copy($old, $off, $out, $pos, $len); $pos += $len
    } elseif ($op -eq 2) {
        $len = $r.ReadInt32()
        $buf = $r.ReadBytes($len)
        [Array]::Copy($buf, 0, $out, $pos, $len); $pos += $len
    } else { throw "Повреждённый патч / corrupted patch" }
}
$fs.Close()
if (-not (Same (Sha256 $out) $newSha)) { throw "Проверка не прошла, игра не изменена. / Verification failed, the game was not changed." }

if (-not (Test-Path $orig)) { Copy-Item $game $orig }
[System.IO.File]::WriteAllBytes($game, $out)
Write-Host "Готово! Запускайте игру, лобби — F8 в главном меню. / Done! Launch the game, press F8 in the main menu for the lobby." -ForegroundColor Green
Write-Host "Оригинал сохранён как data.win.original. / The original is saved as data.win.original."
