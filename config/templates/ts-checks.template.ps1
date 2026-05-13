$ErrorActionPreference = "Stop"

$root = Resolve-Path (Join-Path $PSScriptRoot "..")
Push-Location $root

try {
    $failures = New-Object System.Collections.Generic.List[string]

    function Run-Check {
        param(
            [string]$Name,
            [scriptblock]$Command
        )

        Write-Host "==> $Name"
        try {
            & $Command
            if ($LASTEXITCODE -ne $null -and $LASTEXITCODE -ne 0) {
                $failures.Add("$Name exited with $LASTEXITCODE")
            }
        }
        catch {
            $failures.Add("$Name failed: $($_.Exception.Message)")
        }
    }

    # Replace these placeholders with real project commands.
    # Run-Check "format check" { npm run format:check }
    # Run-Check "lint" { npm run lint }
    # Run-Check "typecheck" { npm run typecheck }
    # Run-Check "tests" { npm test }
    # Run-Check "build" { npm run build }

    if ($failures.Count -gt 0) {
        Write-Host "FAILED checks:"
        $failures | ForEach-Object { Write-Host "- $_" }
        exit 1
    }

    Write-Host "All configured checks passed."
}
finally {
    Pop-Location
}