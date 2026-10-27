@echo off
rem HLMR-R co-op launcher: starts the game and, after a crash, writes coop_crash_log.txt
cd /d "%~dp0"
start "" powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0coop-launch.ps1" %*
