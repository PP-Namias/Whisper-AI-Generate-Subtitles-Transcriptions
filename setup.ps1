# Whisper AI Transcription Setup Script for Windows
# Run this script in PowerShell as Administrator

Write-Host "🚀 Starting Whisper AI Transcription Setup..." -ForegroundColor Green
Write-Host "This script will install all required dependencies and set up the application." -ForegroundColor Yellow

# Check if running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "❌ This script must be run as Administrator!" -ForegroundColor Red
    Write-Host "Please right-click PowerShell and select 'Run as Administrator'" -ForegroundColor Yellow
    exit 1
}

# Function to check if command exists
function Test-CommandExists {
    param($command)
    try {
        Get-Command $command -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

# Function to download and install from URL
function Install-FromUrl {
    param($url, $outputPath, $name)
    Write-Host "📥 Downloading $name..." -ForegroundColor Blue
    try {
        Invoke-WebRequest -Uri $url -OutFile $outputPath -UseBasicParsing
        Write-Host "✅ $name downloaded successfully" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "❌ Failed to download $name" -ForegroundColor Red
        return $false
    }
}

# Check and install Chocolatey if not present
if (!(Test-CommandExists "choco")) {
    Write-Host "📦 Installing Chocolatey package manager..." -ForegroundColor Blue
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH","User")
}

# Install Node.js
if (!(Test-CommandExists "node")) {
    Write-Host "📦 Installing Node.js..." -ForegroundColor Blue
    choco install nodejs -y
    $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH","User")
} else {
    Write-Host "✅ Node.js already installed" -ForegroundColor Green
}

# Install Python
if (!(Test-CommandExists "python")) {
    Write-Host "📦 Installing Python..." -ForegroundColor Blue
    choco install python -y
    $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH","User")
} else {
    Write-Host "✅ Python already installed" -ForegroundColor Green
}

# Install Git
if (!(Test-CommandExists "git")) {
    Write-Host "📦 Installing Git..." -ForegroundColor Blue
    choco install git -y
    $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH","User")
} else {
    Write-Host "✅ Git already installed" -ForegroundColor Green
}

# Install FFmpeg
if (!(Test-CommandExists "ffmpeg")) {
    Write-Host "📦 Installing FFmpeg..." -ForegroundColor Blue
    choco install ffmpeg -y
    $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH","User")
} else {
    Write-Host "✅ FFmpeg already installed" -ForegroundColor Green
}

# Refresh environment variables
$env:PATH = [System.Environment]::GetEnvironmentVariable("PATH","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH","User")

# Install Python packages
Write-Host "🐍 Installing Python packages..." -ForegroundColor Blue
try {
    python -m pip install --upgrade pip
    python -m pip install openai-whisper
    python -m pip install yt-dlp
    Write-Host "✅ Python packages installed successfully" -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to install Python packages" -ForegroundColor Red
    Write-Host "Please run manually: python -m pip install openai-whisper yt-dlp" -ForegroundColor Yellow
}

# Check if we're in the project directory
if (!(Test-Path "package.json")) {
    Write-Host "📁 Not in project directory. Please run this script from the project root." -ForegroundColor Yellow
    Write-Host "If you haven't cloned the repository yet, run:" -ForegroundColor Yellow
    Write-Host "git clone https://github.com/mayeaux/generate-subtitles.git" -ForegroundColor Cyan
    Write-Host "cd generate-subtitles" -ForegroundColor Cyan
    exit 1
}

# Install Node.js dependencies
Write-Host "📦 Installing Node.js dependencies..." -ForegroundColor Blue
try {
    npm install
    Write-Host "✅ Node.js dependencies installed successfully" -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to install Node.js dependencies" -ForegroundColor Red
    exit 1
}

# Create .env file if it doesn't exist
if (!(Test-Path ".env")) {
    if (Test-Path ".env.sample") {
        Write-Host "⚙️ Creating .env configuration file..." -ForegroundColor Blue
        Copy-Item ".env.sample" ".env"
        Write-Host "✅ .env file created from .env.sample" -ForegroundColor Green
        Write-Host "📝 Please edit .env file with your settings before starting the application" -ForegroundColor Yellow
    } else {
        Write-Host "⚙️ Creating default .env configuration..." -ForegroundColor Blue
        @"
# Server Configuration
PORT=3000
NODE_ENV=development

# Whisper Configuration  
WHISPER_MODEL=base
WHISPER_DEVICE=auto

# File Settings
MAX_FILE_SIZE=500MB
UPLOAD_DIR=./uploads
TRANSCRIPTION_DIR=./transcriptions

# Features
ENABLE_YOUTUBE_DOWNLOAD=true
ENABLE_TRANSLATIONS=true
ENABLE_FILE_CLEANUP=true

# Security (Change these!)
FILES_PASSWORD=changeme123
SESSION_SECRET=your-session-secret-here

# Translation Service (Optional)
LIBRETRANSLATE_URL=https://libretranslate.de
LIBRETRANSLATE_API_KEY=
"@ | Out-File -FilePath ".env" -Encoding UTF8
        Write-Host "✅ Default .env file created" -ForegroundColor Green
        Write-Host "⚠️ IMPORTANT: Please change the default passwords in .env file!" -ForegroundColor Red
    }
}

# Test installations
Write-Host "🧪 Testing installations..." -ForegroundColor Blue

$testsPassed = 0
$totalTests = 5

# Test Node.js
if (Test-CommandExists "node") {
    $nodeVersion = node --version
    Write-Host "✅ Node.js: $nodeVersion" -ForegroundColor Green
    $testsPassed++
} else {
    Write-Host "❌ Node.js not found" -ForegroundColor Red
}

# Test Python
if (Test-CommandExists "python") {
    $pythonVersion = python --version
    Write-Host "✅ Python: $pythonVersion" -ForegroundColor Green
    $testsPassed++
} else {
    Write-Host "❌ Python not found" -ForegroundColor Red
}

# Test FFmpeg
if (Test-CommandExists "ffmpeg") {
    Write-Host "✅ FFmpeg: Available" -ForegroundColor Green
    $testsPassed++
} else {
    Write-Host "❌ FFmpeg not found" -ForegroundColor Red
}

# Test Whisper
try {
    python -c "import whisper; print('Whisper available')" 2>$null
    Write-Host "✅ Whisper: Available" -ForegroundColor Green
    $testsPassed++
} catch {
    Write-Host "❌ Whisper not available" -ForegroundColor Red
}

# Test yt-dlp
try {
    python -c "import yt_dlp; print('yt-dlp available')" 2>$null
    Write-Host "✅ yt-dlp: Available" -ForegroundColor Green
    $testsPassed++
} catch {
    Write-Host "❌ yt-dlp not available" -ForegroundColor Red
}

Write-Host "`n📊 Setup Results: $testsPassed/$totalTests tests passed" -ForegroundColor Cyan

if ($testsPassed -eq $totalTests) {
    Write-Host "`n🎉 Setup completed successfully!" -ForegroundColor Green
    Write-Host "You can now start the application with: npm start" -ForegroundColor Yellow
    Write-Host "The application will be available at: http://localhost:3000" -ForegroundColor Cyan
    
    # Ask if user wants to start the application
    $startApp = Read-Host "`nWould you like to start the application now? (y/N)"
    if ($startApp -eq "y" -or $startApp -eq "Y") {
        Write-Host "🚀 Starting application..." -ForegroundColor Green
        npm start
    } else {
        Write-Host "To start the application later, run: npm start" -ForegroundColor Yellow
    }
} else {
    Write-Host "`n⚠️ Setup completed with errors. Please check the failed tests above." -ForegroundColor Yellow
    Write-Host "You may need to:" -ForegroundColor Yellow
    Write-Host "1. Restart your terminal/PowerShell" -ForegroundColor Yellow
    Write-Host "2. Run the failed installations manually" -ForegroundColor Yellow
    Write-Host "3. Check your PATH environment variable" -ForegroundColor Yellow
}

Write-Host "`n📚 For detailed setup instructions, see: INSTALLATION.md" -ForegroundColor Cyan
Write-Host "🐛 For issues and support, visit: https://github.com/mayeaux/generate-subtitles/issues" -ForegroundColor Cyan
