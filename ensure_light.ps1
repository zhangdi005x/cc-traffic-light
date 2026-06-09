# ensure_light.ps1 - Claude Code traffic light auto-start script
param([string]$Color = "yellow")

$lockFile = "$env:TEMP\cc-traffic-light.lock"
$stateFile = "$env:TEMP\claude-traffic-light"

# Start Electron if not running
if (-not (Test-Path $lockFile)) {
    Start-Process -FilePath "cmd" -ArgumentList "/c npx electron ." -WorkingDirectory "E:\Claude\fristcc\cc-traffic-light-pro" -WindowStyle Hidden
    "started" | Out-File -FilePath $lockFile -Encoding ascii
    Start-Sleep -Seconds 4
}

# Write state
$Color | Out-File -FilePath $stateFile -Encoding ascii
