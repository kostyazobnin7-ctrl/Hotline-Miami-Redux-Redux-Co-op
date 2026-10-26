"""Стенд: запуск копий игры из work/instances/pN.

python tools/stand.py run [--clients 1] [--lag 0] [--jitter 0] [--debug]
python tools/stand.py stop
"""
import argparse
import json
import subprocess
import sys
import time
from pathlib import Path

WORK = Path(__file__).resolve().parent.parent.parent
EXE_NAME = "Hotline Miami Redux Redux.exe"
PIDS = WORK / "run" / "pids.json"


def kill_strays():
    # копии игры из work/instances, оставшиеся от прошлых запусков (иначе порт 47800 занят)
    inst = str(WORK / "instances")
    subprocess.call(["powershell", "-NoProfile", "-Command",
                     "Get-Process 'Hotline Miami Redux Redux' -ErrorAction SilentlyContinue | "
                     "Where-Object { $_.Path -like '" + inst + "\*' } | Stop-Process -Force"])


def run(clients, lag, jitter, debug):
    kill_strays()
    time.sleep(1.0)
    flags = subprocess.DETACHED_PROCESS | subprocess.CREATE_NEW_PROCESS_GROUP
    procs = []
    for i in range(1, clients + 2):
        inst = WORK / "instances" / f"p{i}"
        exe = inst / EXE_NAME
        if not exe.exists():
            sys.exit(f"нет копии {inst}")
        role = ["-coop_host"] if i == 1 else ["-coop_join", "127.0.0.1"]
        args = [str(exe)] + role + ["-coop_port", "47800", "-coop_lag", str(lag), "-coop_jitter", str(jitter)]
        if debug:
            args.append("-coop_debug")
        p = subprocess.Popen(args, cwd=inst, creationflags=flags)
        procs.append({"pid": p.pid, "inst": str(inst), "started": time.time()})
        print(f"p{i}: pid {p.pid} {' '.join(role)}")
        time.sleep(2.0)  # хост должен открыть порт раньше клиентов
    PIDS.parent.mkdir(exist_ok=True)
    PIDS.write_text(json.dumps(procs, indent=1), encoding="utf-8")


def stop():
    if not PIDS.exists():
        print("нечего закрывать")
        return
    for p in json.loads(PIDS.read_text(encoding="utf-8")):
        # закрываем только свои pid и только если это exe игры
        out = subprocess.run(["tasklist", "/FI", f"PID eq {p['pid']}", "/FO", "CSV", "/NH"],
                             capture_output=True, text=True).stdout
        if EXE_NAME in out:
            subprocess.call(["taskkill", "/PID", str(p["pid"]), "/F"])
    PIDS.unlink()
    kill_strays()


def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="cmd", required=True)
    rn = sub.add_parser("run")
    rn.add_argument("--clients", type=int, default=1, choices=[1, 2, 3])
    rn.add_argument("--lag", type=int, default=0)
    rn.add_argument("--jitter", type=int, default=0)
    rn.add_argument("--debug", action="store_true")
    sub.add_parser("stop")
    a = ap.parse_args()
    if a.cmd == "run":
        run(a.clients, a.lag, a.jitter, a.debug)
    else:
        stop()


if __name__ == "__main__":
    main()
