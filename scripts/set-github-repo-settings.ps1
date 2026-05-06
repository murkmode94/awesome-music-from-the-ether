param(
  [Parameter(Mandatory = $false)]
  [string]$Owner = "murkmode94",
  [Parameter(Mandatory = $false)]
  [string]$Repo = "awesome-music-from-the-ether",
  [Parameter(Mandatory = $false)]
  [string]$Token = $env:GITHUB_TOKEN
)

if ([string]::IsNullOrWhiteSpace($Token)) {
  throw "GITHUB_TOKEN is not set. Export a token with repo scope and run again."
}

$headers = @{
  Authorization = "Bearer $Token"
  "X-GitHub-Api-Version" = "2022-11-28"
  Accept = "application/vnd.github+json"
}

$repoBody = @{
  description = "Trusted producer curation hub for plugins, sample resources, and music-tech learning."
  homepage = "https://github.com/GareBear99/awesome-audio-plugins-dev"
  has_issues = $true
  has_projects = $false
  has_wiki = $false
  has_discussions = $true
} | ConvertTo-Json

Invoke-RestMethod `
  -Method Patch `
  -Uri "https://api.github.com/repos/$Owner/$Repo" `
  -Headers $headers `
  -Body $repoBody `
  -ContentType "application/json" | Out-Null

$topicsBody = @{
  names = @(
    "awesome-list",
    "music-production",
    "audio-plugins",
    "sample-packs",
    "audio-dsp",
    "music-tech",
    "producer-resources",
    "curated-resources"
  )
} | ConvertTo-Json

Invoke-RestMethod `
  -Method Put `
  -Uri "https://api.github.com/repos/$Owner/$Repo/topics" `
  -Headers $headers `
  -Body $topicsBody `
  -ContentType "application/json" | Out-Null

Write-Host "GitHub API settings applied for $Owner/$Repo"
