# Запуск кооператива с журналом вылетов. / Co-op launcher with crash log.
# Запуск / run: «Играть в кооп.bat» в папке с игрой / in the game folder.
# GameMaker 1.4 не умеет перехватывать ошибки из кода игры, но с ключом -output движок пишет
# текст фатальной ошибки со стеком в файл. Лаунчер ждёт закрытия игры; если осталась метка
# coop_running.flag (игра её снимает только при нормальном выходе) — это вылет: собираем
# coop_crash_log.txt (версия, время, текст ошибки, снимок состояния и последние события из
# coop_context.txt) и показываем окно с просьбой прислать файл.
param([string]$SaveName = 'Hotline_Miami_Redux_Redux', [Parameter(ValueFromRemainingArguments = $true)] $GameArgs)
$ErrorActionPreference = 'SilentlyContinue'
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
$exe = Join-Path $dir 'Hotline Miami Redux Redux.exe'
$save = Join-Path $env:APPDATA $SaveName
New-Item -ItemType Directory -Force $save | Out-Null
$out = Join-Path $save 'coop_error.txt'
if (Test-Path $out) { Move-Item -Force $out (Join-Path $save 'coop_error_prev.txt') }
$a = @('-output', ('"' + $out + '"'))
if ($GameArgs) { $a += $GameArgs }
$started = Get-Date
Start-Process -FilePath $exe -ArgumentList $a -WorkingDirectory $dir -Wait
$flag = Join-Path $save 'coop_running.flag'
if (-not (Test-Path $flag)) { exit 0 }

# --- вылет / crash ---
$log = Join-Path $save 'coop_crash_log.txt'
$sb = New-Object System.Text.StringBuilder
$ver = '?'
$ctx = Join-Path $save 'coop_context.txt'
$ctxLines = @()
if (Test-Path $ctx) { $ctxLines = Get-Content -Encoding UTF8 $ctx }
if ($ctxLines.Count -gt 0 -and $ctxLines[0] -match 'мод (\S+), протокол (\d+)') { $ver = $Matches[1] + ', протокол ' + $Matches[2] }
[void]$sb.AppendLine('HLMR-R CO-OP — журнал вылета / crash log')
[void]$sb.AppendLine('мод ' + $ver)
[void]$sb.AppendLine('запуск ' + $started.ToString('yyyy-MM-dd HH:mm:ss') + ', вылет ' + (Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))
[void]$sb.AppendLine('Windows ' + [Environment]::OSVersion.Version)
[void]$sb.AppendLine('')
[void]$sb.AppendLine('=== текст ошибки / error ===')
$err = @()
if (Test-Path $out) { $err = Get-Content -Encoding UTF8 $out }
$k = -1
for ($i = $err.Count - 1; $i -ge 0; $i--) { if ($err[$i] -match 'FATAL ERROR|ERROR!!!') { $k = $i; break } }
if ($k -ge 0) {
    $from = [Math]::Max(0, $k - 1)
    $to = [Math]::Min($err.Count - 1, $from + 60)
    foreach ($l in $err[$from..$to]) { [void]$sb.AppendLine($l) }
} else {
    [void]$sb.AppendLine('(движок не записал текст ошибки — игра закрылась без окна ошибки)')
}
[void]$sb.AppendLine('')
[void]$sb.AppendLine('=== последние сообщения мода / last mod messages ===')
$mod = @($err | Where-Object { $_ -like '`[COOP`]*' })
if ($mod.Count -gt 25) { $mod = $mod[($mod.Count - 25)..($mod.Count - 1)] }
foreach ($l in $mod) { [void]$sb.AppendLine($l) }
[void]$sb.AppendLine('')
[void]$sb.AppendLine('=== состояние перед вылетом / state before crash ===')
foreach ($l in $ctxLines) { [void]$sb.AppendLine($l) }
[System.IO.File]::WriteAllText($log, $sb.ToString(), (New-Object System.Text.UTF8Encoding $true))
# журнал собран — игре при следующем запуске собирать его заново не нужно
Remove-Item -Force $flag

Add-Type -AssemblyName System.Windows.Forms
$msg = "Произошла ошибка. Пожалуйста, отправьте файл coop_crash_log.txt разработчику.`n`n" +
       "An error occurred. Please send coop_crash_log.txt to the developer.`n`n" +
       $log + "`n`nОткрыть папку с файлом? / Open the folder?"
$r = [System.Windows.Forms.MessageBox]::Show($msg, 'HLMR-R Co-op — ошибка / crash', 'YesNo', 'Error')
if ($r -eq 'Yes') { Start-Process explorer.exe ('/select,"' + $log + '"') }
