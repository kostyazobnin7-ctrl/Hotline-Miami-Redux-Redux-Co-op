@echo off
chcp 65001 >nul
rem Вернуть оригинальную игру / Restore the original game
if not exist "%~dp0data.win.original" (
  echo Нет data.win.original - кооператив не устанавливался. / data.win.original not found - co-op was not installed.
  pause
  exit /b 1
)
copy /y "%~dp0data.win.original" "%~dp0data.win" >nul
echo Оригинальная игра восстановлена. / The original game is restored.
pause
