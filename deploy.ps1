# Deployment script for Milena Marchini website
# This script deploys the website to Spaceship using SSH/SCP

# Load environment variables from .env file
$envFile = ".\.env"
if (Test-Path $envFile) {
    Get-Content $envFile | ForEach-Object {
        if ($_ -match "^\s*([^#][^=]+)=(.*)$") {
            $key = $matches[1].Trim()
            $value = $matches[2].Trim()
            Set-Item -Path "Env:$key" -Value $value
        }
    }
    Write-Host "Environment variables loaded from .env file" -ForegroundColor Green
} else {
    Write-Host "Error: .env file not found. Please create it with your SSH credentials." -ForegroundColor Red
    exit 1
}

# Check if required environment variables are set
$requiredVars = @("SSH_HOST", "SSH_USER", "REMOTE_DIR")
$missingVars = @()

foreach ($var in $requiredVars) {
    if (-not (Get-Item "Env:$var" -ErrorAction SilentlyContinue)) {
        $missingVars += $var
    }
}

if ($missingVars.Count -gt 0) {
    Write-Host "Error: The following required environment variables are missing in .env file:" -ForegroundColor Red
    foreach ($var in $missingVars) {
        Write-Host "  - $var" -ForegroundColor Red
    }
    exit 1
}

# Set default SSH port if not specified
if (-not (Get-Item "Env:SSH_PORT" -ErrorAction SilentlyContinue)) {
    $env:SSH_PORT = "22"
    Write-Host "Using default SSH port: 22" -ForegroundColor Yellow
}

# Display deployment information
Write-Host "Deploying website to Spaceship..." -ForegroundColor Cyan
Write-Host "  Host: $env:SSH_HOST" -ForegroundColor Cyan
Write-Host "  User: $env:SSH_USER" -ForegroundColor Cyan
Write-Host "  Port: $env:SSH_PORT" -ForegroundColor Cyan
Write-Host "  Remote directory: $env:REMOTE_DIR" -ForegroundColor Cyan

# Ask for confirmation
$confirmation = Read-Host "Continue with deployment? (y/n)"
if ($confirmation -ne "y") {
    Write-Host "Deployment cancelled." -ForegroundColor Yellow
    exit 0
}

# Deploy using SCP
try {
    Write-Host "Deploying files to server..." -ForegroundColor Cyan
    
    # Exclude files that shouldn't be deployed
    $excludeList = @(".git", ".env", "deploy.ps1", "README.md")
    $excludeParams = $excludeList | ForEach-Object { "-x $_" }
    
    # Build the SCP command
    $scpCommand = "scp -r -P $env:SSH_PORT $excludeParams * $env:SSH_USER@$env:SSH_HOST`:$env:REMOTE_DIR"
    
    # Execute the command
    Write-Host "Executing: $scpCommand" -ForegroundColor Gray
    Invoke-Expression $scpCommand
    
    Write-Host "Deployment completed successfully!" -ForegroundColor Green
} catch {
    Write-Host "Error during deployment: $_" -ForegroundColor Red
    exit 1
}
