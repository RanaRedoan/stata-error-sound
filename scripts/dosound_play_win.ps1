param(
    [Parameter(Mandatory = $true)]
    [string]$SoundPath
)

if (-not (Test-Path -LiteralPath $SoundPath)) {
    exit 0
}

try {
    $resolved = (Resolve-Path -LiteralPath $SoundPath).Path
    $player = New-Object -ComObject WMPlayer.OCX.7
    $player.URL = $resolved
    $player.controls.play()
    Start-Sleep -Milliseconds 1600
    $player.controls.stop()
} catch {
    exit 0
}
