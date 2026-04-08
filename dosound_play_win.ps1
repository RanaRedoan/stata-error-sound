param(
    [Parameter(Mandatory = $true)]
    [string]$SoundPath
)

function Invoke-FallbackBeep {
    try {
        [Console]::Beep(1000, 700)
    } catch {
        exit 0
    }
}

if (-not (Test-Path -LiteralPath $SoundPath)) {
    Invoke-FallbackBeep
    exit 0
}

try {
    Add-Type -AssemblyName PresentationCore
    $resolved = (Resolve-Path -LiteralPath $SoundPath).Path
    $player = New-Object System.Windows.Media.MediaPlayer
    $player.Open([System.Uri]::new($resolved))
    Start-Sleep -Milliseconds 250
    $player.Volume = 1.0
    $player.Play()
    Start-Sleep -Milliseconds 1800
    $player.Stop()
} catch {
    Invoke-FallbackBeep
}
