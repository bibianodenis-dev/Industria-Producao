<#
.SYNOPSIS
    Script de automação para vincular o repositório local ao GitHub e realizar push.
.DESCRIPTION
    Configura o remote 'origin', a branch 'main' e envia os commits para o GitHub:
    https://github.com/bibianodenis-dev/Industria-Producao.git
#>

[CmdletBinding()]
param (
    [string]$RemoteUrl = "https://github.com/bibianodenis-dev/Industria-Producao.git",
    [string]$Branch = "main"
)

$ErrorActionPreference = "Stop"

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  Conectando repositório ao GitHub: $RemoteUrl" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# Verifica se git está instalado
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "Git não está instalado ou não foi encontrado no PATH do sistema."
    exit 1
}

# Verifica se o repositório local foi inicializado
if (-not (Test-Path ".git")) {
    Write-Host "Inicializando repositório Git local..." -ForegroundColor Yellow
    git init -b $Branch
}

# Verifica e configura o remote origin
$existingRemote = git remote get-url origin 2>$null
if ($LASTEXITCODE -eq 0 -and $existingRemote) {
    Write-Host "Remote 'origin' já existe ($existingRemote). Atualizando URL..." -ForegroundColor Yellow
    git remote set-url origin $RemoteUrl
} else {
    Write-Host "Adicionando remote 'origin' -> $RemoteUrl..." -ForegroundColor Green
    git remote add origin $RemoteUrl
}

# Garante a branch main
git branch -M $Branch

# Exibe status e confirmação
Write-Host "`nRemotes configurados:" -ForegroundColor Cyan
git remote -v

Write-Host "`nExecutando push para $Branch no GitHub..." -ForegroundColor Green
git push -u origin $Branch

Write-Host "`n[SUCESSO] Repositório sincronizado com o GitHub com sucesso!" -ForegroundColor Green
