# set_state.ps1 - Set traffic light state (auto-start Electron if needed)
param([string]$Color = "yellow")

$stateFile = Join-Path $env:TEMP "claude-traffic-light"
$pidFile = Join-Path $env:TEMP "cc_traffic_light_electron.pid"
$lockFile = Join-Path $env:TEMP "cc_traffic_light_starting.lock"

# Write state FIRST (so hooks return quickly)
$Color | Out-File -FilePath $stateFile -Encoding ascii -NoNewline

# Check if Electron is already running by PID file
$shouldStart = $false
if (Test-Path $pidFile) {
    $savedPid = Get-Content $pidFile -ErrorAction SilentlyContinue
    $process = Get-Process -Id $savedPid -ErrorAction SilentlyContinue
    if (-not $process) {
        # Process is dead, check lock file to prevent multiple starts
        if (-not (Test-Path $lockFile)) {
            # Create lock file
            Get-Date | Out-File -FilePath $lockFile -Encoding ascii
            $shouldStart = $true
        }
    }
} else {
    # No PID file, check lock file
    if (-not (Test-Path $lockFile)) {
        # Create lock file
        Get-Date | Out-File -FilePath $lockFile -Encoding ascii
        $shouldStart = $true
    }
}

if ($shouldStart) {
    Start-Process -FilePath "cmd" -ArgumentList "/c npx electron ." -WorkingDirectory "E:\Claude\fristcc\cc-traffic-light-pro-v2" -WindowStyle Hidden
    # Remove lock file after 5 seconds
    Start-Sleep -Seconds 5
    Remove-Item $lockFile -ErrorAction SilentlyContinue
}
