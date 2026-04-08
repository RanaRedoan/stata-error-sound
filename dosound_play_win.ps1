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
    $resolved = (Resolve-Path -LiteralPath $SoundPath).Path
    Start-Process -FilePath $resolved | Out-Null
} catch {
    Invoke-FallbackBeep
}
