#!/bin/bash

# Whisper AI Transcription Setup Script for Linux/macOS
# This script will install all required dependencies and set up the application

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_info() {
    echo -e "${BLUE}📦 $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_header() {
    echo -e "${CYAN}🚀 $1${NC}"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}

# Function to install package on different systems
install_package() {
    local package=$1
    local os=$(detect_os)
    
    case $os in
        "linux")
            if command_exists apt-get; then
                sudo apt-get update
                sudo apt-get install -y $package
            elif command_exists yum; then
                sudo yum install -y $package
            elif command_exists dnf; then
                sudo dnf install -y $package
            elif command_exists pacman; then
                sudo pacman -S --noconfirm $package
            else
                print_error "Unsupported package manager. Please install $package manually."
                return 1
            fi
            ;;
        "macos")
            if command_exists brew; then
                brew install $package
            else
                print_error "Homebrew not found. Please install Homebrew first or install $package manually."
                return 1
            fi
            ;;
        *)
            print_error "Unsupported operating system. Please install $package manually."
            return 1
            ;;
    esac
}

# Main setup function
main() {
    print_header "Starting Whisper AI Transcription Setup..."
    echo "This script will install all required dependencies and set up the application."
    echo ""

    # Check if we're in the project directory
    if [ ! -f "package.json" ]; then
        print_error "Not in project directory. Please run this script from the project root."
        print_warning "If you haven't cloned the repository yet, run:"
        echo "git clone https://github.com/mayeaux/generate-subtitles.git"
        echo "cd generate-subtitles"
        exit 1
    fi

    # Install system dependencies
    print_info "Installing system dependencies..."
    
    # Install Node.js
    if ! command_exists node; then
        print_info "Installing Node.js..."
        case $(detect_os) in
            "linux")
                # Install Node.js via NodeSource repository
                curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
                sudo apt-get install -y nodejs
                ;;
            "macos")
                if command_exists brew; then
                    brew install node@18
                else
                    print_error "Please install Homebrew first: https://brew.sh/"
                    exit 1
                fi
                ;;
        esac
    else
        print_status "Node.js already installed"
    fi

    # Install Python 3
    if ! command_exists python3; then
        print_info "Installing Python 3..."
        case $(detect_os) in
            "linux")
                install_package "python3 python3-pip"
                ;;
            "macos")
                install_package "python@3.10"
                ;;
        esac
    else
        print_status "Python 3 already installed"
    fi

    # Install FFmpeg
    if ! command_exists ffmpeg; then
        print_info "Installing FFmpeg..."
        install_package "ffmpeg"
    else
        print_status "FFmpeg already installed"
    fi

    # Install Git
    if ! command_exists git; then
        print_info "Installing Git..."
        install_package "git"
    else
        print_status "Git already installed"
    fi

    # Install Python packages
    print_info "Installing Python packages..."
    if command_exists python3; then
        python3 -m pip install --user --upgrade pip
        python3 -m pip install --user openai-whisper
        python3 -m pip install --user yt-dlp
        print_status "Python packages installed successfully"
    elif command_exists python; then
        python -m pip install --user --upgrade pip
        python -m pip install --user openai-whisper
        python -m pip install --user yt-dlp
        print_status "Python packages installed successfully"
    else
        print_error "Python not found. Please install Python 3.8+ manually."
        exit 1
    fi

    # Install Node.js dependencies
    print_info "Installing Node.js dependencies..."
    npm install
    print_status "Node.js dependencies installed successfully"

    # Create .env file if it doesn't exist
    if [ ! -f ".env" ]; then
        if [ -f ".env.sample" ]; then
            print_info "Creating .env configuration file..."
            cp .env.sample .env
            print_status ".env file created from .env.sample"
            print_warning "Please edit .env file with your settings before starting the application"
        else
            print_info "Creating default .env configuration..."
            cat > .env << 'EOF'
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
EOF
            print_status "Default .env file created"
            print_error "IMPORTANT: Please change the default passwords in .env file!"
        fi
    fi

    # Test installations
    print_info "Testing installations..."
    echo ""

    tests_passed=0
    total_tests=5

    # Test Node.js
    if command_exists node; then
        node_version=$(node --version)
        print_status "Node.js: $node_version"
        ((tests_passed++))
    else
        print_error "Node.js not found"
    fi

    # Test Python
    if command_exists python3; then
        python_version=$(python3 --version)
        print_status "Python: $python_version"
        ((tests_passed++))
    elif command_exists python; then
        python_version=$(python --version)
        print_status "Python: $python_version"
        ((tests_passed++))
    else
        print_error "Python not found"
    fi

    # Test FFmpeg
    if command_exists ffmpeg; then
        print_status "FFmpeg: Available"
        ((tests_passed++))
    else
        print_error "FFmpeg not found"
    fi

    # Test Whisper
    if python3 -c "import whisper" 2>/dev/null || python -c "import whisper" 2>/dev/null; then
        print_status "Whisper: Available"
        ((tests_passed++))
    else
        print_error "Whisper not available"
    fi

    # Test yt-dlp
    if python3 -c "import yt_dlp" 2>/dev/null || python -c "import yt_dlp" 2>/dev/null; then
        print_status "yt-dlp: Available"
        ((tests_passed++))
    else
        print_error "yt-dlp not available"
    fi

    echo ""
    echo -e "${CYAN}📊 Setup Results: $tests_passed/$total_tests tests passed${NC}"
    echo ""

    if [ $tests_passed -eq $total_tests ]; then
        print_header "Setup completed successfully!"
        print_warning "You can now start the application with: npm start"
        print_info "The application will be available at: http://localhost:3000"
        echo ""
        
        # Ask if user wants to start the application
        read -p "Would you like to start the application now? (y/N): " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_header "Starting application..."
            npm start
        else
            print_warning "To start the application later, run: npm start"
        fi
    else
        print_warning "Setup completed with errors. Please check the failed tests above."
        echo "You may need to:"
        echo "1. Restart your terminal"
        echo "2. Run the failed installations manually"
        echo "3. Check your PATH environment variable"
        echo "4. Install missing dependencies manually"
    fi

    echo ""
    print_info "For detailed setup instructions, see: INSTALLATION.md"
    print_info "For issues and support, visit: https://github.com/mayeaux/generate-subtitles/issues"
}

# Run main function
main "$@"
