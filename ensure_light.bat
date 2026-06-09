@echo off
set LOCK_FILE=%TEMP%\cc-traffic-light.lock

if not exist "%LOCK_FILE%" (
    start "" /D "E:\Claude\fristcc\cc-traffic-light-pro" cmd /c "npx electron ."
    echo started > "%LOCK_FILE%"
    ping -n 5 127.0.0.1 >nul
)

echo %1 > "%TEMP%\claude-traffic-light"
