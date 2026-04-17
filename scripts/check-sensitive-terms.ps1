param(
    [string]$Root = (Resolve-Path "$PSScriptRoot\..").Path,
    [string]$TermsFile = (Join-Path (Resolve-Path "$PSScriptRoot\..").Path "tests\sensitive-terms.local.txt")
)

$ErrorActionPreference = "Stop"

function Join-CodePoints {
    param(
        [int[]]$Points
    )

    return -join ($Points | ForEach-Object { [char]$_ })
}

$errors = New-Object System.Collections.Generic.List[string]

$riskyFileNamePatterns = @(
    (Join-CodePoints @(0x5BA1, 0x8BA1, 0x62A5, 0x544A)),
    (Join-CodePoints @(0x79D1, 0x76EE, 0x4F59, 0x989D, 0x8868)),
    (Join-CodePoints @(0x8D22, 0x52A1, 0x5C3D, 0x8C03)),
    (Join-CodePoints @(0x5C3D, 0x8C03, 0x62A5, 0x544A)),
    (Join-CodePoints @(0x94F6, 0x884C, 0x6D41, 0x6C34)),
    (Join-CodePoints @(0x5F81, 0x4FE1)),
    (Join-CodePoints @(0x5408, 0x540C)),
    (Join-CodePoints @(0x5BA2, 0x6237, 0x8D44, 0x6599))
)

foreach ($file in Get-ChildItem -LiteralPath $Root -Recurse -File -Force) {
    $relative = Resolve-Path -LiteralPath $file.FullName -Relative

    foreach ($pattern in $riskyFileNamePatterns) {
        if ($file.Name -like "*$pattern*") {
            $errors.Add("Risky filename: $relative")
        }
    }

    if ($file.Extension -eq ".pdf") {
        $errors.Add("PDF files are not allowed by default: $relative")
    }
}

if (Test-Path -LiteralPath $TermsFile) {
    $terms = Get-Content -Encoding UTF8 -LiteralPath $TermsFile |
        Where-Object { $_.Trim().Length -gt 0 -and -not $_.Trim().StartsWith("#") }

    $textExtensions = @(".md", ".txt", ".yaml", ".yml", ".ps1", ".json")
    foreach ($file in Get-ChildItem -LiteralPath $Root -Recurse -File -Force) {
        if ($file.Extension -notin $textExtensions) { continue }
        $content = Get-Content -Raw -Encoding UTF8 -LiteralPath $file.FullName
        foreach ($term in $terms) {
            if ($content.Contains($term)) {
                $relative = Resolve-Path -LiteralPath $file.FullName -Relative
                $errors.Add("Sensitive term '$term' found in $relative")
            }
        }
    }
} else {
    Write-Host "No local sensitive terms file found: $TermsFile"
    Write-Host "Create tests/sensitive-terms.local.txt for project-specific checks."
}

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Error $_ }
    throw "Sensitive file/term check failed with $($errors.Count) issue(s)."
}

Write-Host "Sensitive file/term check passed."
