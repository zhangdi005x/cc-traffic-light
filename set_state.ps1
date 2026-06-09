# set_state.ps1 - Set traffic light state (auto-start Electron if needed)
param([string]$Color = "yellow")

$stateFile = Join-Path $env:TEMP "claude-traffic-light"

# Write state FIRST (so hooks return quickly)
$Color | Out-File -FilePath $stateFile -Encoding ascii -NoNewline

# Then check if Electron needs to be started (non-blocking)
$electronRunning = Get-Process electron -ErrorAction SilentlyContinue
if (-not $electronRunning) {
    Remove-Item (Join-Path $env:TEMP "cc-traffic-light.lock") -ErrorAction SilentlyContinue
    Start-Process -FilePath "cmd" -ArgumentList "/c npx electron ." -WorkingDirectory "E:\Claude\fristcc\cc-traffic-light-pro" -WindowStyle Hidden
}
