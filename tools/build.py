"""Сборка v1.4+ поверх собранной v1.3.

python tools/build.py            — build/data.win (релиз) + data_pN.win, копии в instances/pN
python tools/build.py --release  — то же и копия data.win в RELEASE

База: work/base/data_v13.win (data.win релиза 1.3, sha256 b8aed04330a5...).
"""
import hashlib
import shutil
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
WORK = REPO.parent
BASE = WORK / "base" / "data_v13.win"
BASE_SHA = "b8aed04330a5"
OUT = WORK / "build"
TOOL_DIR = WORK / "coopbuild2bin"
TOOL = TOOL_DIR / "coopbuild2.exe"


def sha12(p):
    h = hashlib.sha256()
    with open(p, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()[:12]


def run(args):
    print(">", " ".join(str(a) for a in args[1:]))
    r = subprocess.run([str(a) for a in args], text=True, encoding="utf-8", errors="replace")
    if r.returncode:
        sys.exit(r.returncode)


def main():
    if not BASE.exists():
        sys.exit(f"нет базы {BASE}")
    if sha12(BASE) != BASE_SHA:
        sys.exit("база не та: " + sha12(BASE))
    run(["dotnet", "build", REPO / "tools" / "coopbuild2", "-c", "Release", "-nologo", "-v", "q", "-o", TOOL_DIR])
    OUT.mkdir(exist_ok=True)
    src = REPO / "src" / "gml"
    run([TOOL, BASE, OUT / "data.win", src])
    for n in range(1, 5):
        out = OUT / f"data_p{n}.win"
        run([TOOL, BASE, out, src, "--name", f"HLMR_R_Coop_p{n}"])
        inst = WORK / "instances" / f"p{n}"
        if inst.exists():
            shutil.copyfile(out, inst / "data.win")
    print("data.win", sha12(OUT / "data.win"))
    if "--release" in sys.argv:
        shutil.copyfile(OUT / "data.win", WORK / "RELEASE" / "data.win")
        print("RELEASE/data.win обновлён")


if __name__ == "__main__":
    main()
