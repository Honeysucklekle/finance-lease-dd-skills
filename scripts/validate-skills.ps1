param(
    [string]$Root = (Resolve-Path "$PSScriptRoot\..").Path
)

$ErrorActionPreference = "Stop"

$skillsRoot = Join-Path $Root "skills"
if (-not (Test-Path -LiteralPath $skillsRoot)) {
    throw "skills directory not found: $skillsRoot"
}

$errors = New-Object System.Collections.Generic.List[string]

foreach ($dir in Get-ChildItem -LiteralPath $skillsRoot -Directory) {
    $skill = Join-Path $dir.FullName "SKILL.md"
    if (-not (Test-Path -LiteralPath $skill)) {
        $errors.Add("Missing SKILL.md: $($dir.FullName)")
        continue
    }

    $text = Get-Content -Raw -Encoding UTF8 -LiteralPath $skill
    if (-not $text.StartsWith("---")) {
        $errors.Add("Missing YAML frontmatter start: $skill")
        continue
    }

    $second = $text.IndexOf("---", 3)
    if ($second -lt 0) {
        $errors.Add("Missing YAML frontmatter end: $skill")
        continue
    }

    $frontmatter = $text.Substring(3, $second - 3)
    if ($frontmatter -notmatch "(?m)^name:\s*(\S+)\s*$") {
        $errors.Add("Missing name in frontmatter: $skill")
    } else {
        $name = $Matches[1].Trim()
        if ($name -ne $dir.Name) {
            $errors.Add("Skill name '$name' does not match folder '$($dir.Name)': $skill")
        }
        if ($name -notmatch "^[a-z0-9-]{1,63}$") {
            $errors.Add("Invalid skill name '$name': $skill")
        }
    }

    if ($frontmatter -notmatch "(?m)^description:\s*.+") {
        $errors.Add("Missing description in frontmatter: $skill")
    }

    $openaiYaml = Join-Path $dir.FullName "agents\openai.yaml"
    if (-not (Test-Path -LiteralPath $openaiYaml)) {
        $errors.Add("Missing agents/openai.yaml: $($dir.FullName)")
    }
}

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Error $_ }
    throw "Skill validation failed with $($errors.Count) issue(s)."
}

Write-Host "Skill validation passed."
