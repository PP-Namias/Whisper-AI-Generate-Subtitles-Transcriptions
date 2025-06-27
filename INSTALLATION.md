# Installation Guide

A comprehensive step-by-step guide to install and set up the Whisper AI Generate Subtitles & Transcriptions application.

## Table of Contents
- [System Requirements](#system-requirements)
- [Quick Start](#quick-start)
- [Detailed Installation](#detailed-installation)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)
- [Advanced Setup](#advanced-setup)

---

## System Requirements

### Minimum Requirements
- **OS**: Windows 10/11, macOS 10.15+, or Linux (Ubuntu 18.04+)
- **Memory**: 4GB RAM (8GB recommended)
- **Storage**: 5GB free space (more for processing large files)
- **Network**: Internet connection for initial setup and translations

### Recommended Requirements
- **OS**: Windows 11, macOS 12+, or Linux (Ubuntu 20.04+)
- **Memory**: 16GB RAM or more
- **Storage**: 20GB+ free space on SSD
- **GPU**: NVIDIA GPU with CUDA support (for faster processing)
- **Network**: High-speed internet connection

### Hardware Considerations
- **CPU**: Multi-core processor recommended for CPU-based transcription
- **GPU**: NVIDIA GPU with 4GB+ VRAM for optimal performance
- **Storage**: SSD recommended for faster file I/O operations

---

## Quick Start

### Option 1: Automated Installation (Recommended)

1. **Clone the repository**
   ```bash
   git clone https://github.com/mayeaux/generate-subtitles.git
   cd generate-subtitles
   ```

2. **Run the setup script**
   ```bash
   # For Linux/macOS
   chmod +x setup.sh
   ./setup.sh
   
   # For Windows (run in PowerShell as Administrator)
   .\setup.ps1
   ```

3. **Start the application**
   ```bash
   npm start
   ```

4. **Open your browser**
   Navigate to `http://localhost:3000`

### Option 2: Manual Installation

Follow the [Detailed Installation](#detailed-installation) section below.

---

## Detailed Installation

### Step 1: Install Prerequisites

#### 1.1 Install Node.js

**Windows:**
1. Download Node.js 18+ from [nodejs.org](https://nodejs.org/)
2. Run the installer and follow the setup wizard
3. Verify installation:
   ```cmd
   node --version
   npm --version
   ```

**macOS:**
```bash
# Using Homebrew (recommended)
brew install node@18

# Or download from nodejs.org
```

**Linux (Ubuntu/Debian):**
```bash
# Using NodeSource repository
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verify installation
node --version
npm --version
```

#### 1.2 Install Python 3.8+

**Windows:**
1. Download Python 3.8+ from [python.org](https://python.org/)
2. During installation, check "Add Python to PATH"
3. Verify: `python --version`

**macOS:**
```bash
# Using Homebrew
brew install python@3.10

# Verify
python3 --version
```

**Linux:**
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install python3 python3-pip

# Verify
python3 --version
```

#### 1.3 Install FFmpeg

**Windows:**
1. Download from [ffmpeg.org](https://ffmpeg.org/download.html)
2. Extract to `C:\ffmpeg`
3. Add `C:\ffmpeg\bin` to your system PATH
4. Verify: `ffmpeg -version`

**macOS:**
```bash
brew install ffmpeg
```

**Linux:**
```bash
sudo apt update
sudo apt install ffmpeg
```

### Step 2: Install OpenAI Whisper

```bash
# Install Whisper
pip install openai-whisper

# Verify installation
whisper --help
```

**For GPU acceleration (NVIDIA):**
```bash
# Install CUDA-enabled PyTorch first
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# Then install Whisper
pip install openai-whisper
```

### Step 3: Install yt-dlp (for YouTube support)

**Windows:**
```cmd
# Download yt-dlp.exe to a folder in your PATH
# Or use pip
pip install yt-dlp
```

**macOS/Linux:**
```bash
# Using pip (recommended)
pip install yt-dlp

# Or download binary
sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
sudo chmod a+rx /usr/local/bin/yt-dlp
```

### Step 4: Clone and Setup Application

1. **Clone the repository**
   ```bash
   git clone https://github.com/mayeaux/generate-subtitles.git
   cd generate-subtitles
   ```

2. **Install Node.js dependencies**
   ```bash
   npm install
   ```

3. **Create environment configuration**
   ```bash
   # Copy example environment file
   cp .env.sample .env
   
   # Edit .env file with your settings
   nano .env  # or use your preferred editor
   ```

### Step 5: Configure Environment Variables

Edit the `.env` file with your preferred settings:

```env
# Server Configuration
PORT=3000
NODE_ENV=development

# File Storage
UPLOAD_DIR=./uploads
TRANSCRIPTION_DIR=./transcriptions
MAX_FILE_SIZE=500MB

# Whisper Configuration
WHISPER_MODEL=base
WHISPER_DEVICE=auto

# Translation Service (Optional)
LIBRETRANSLATE_URL=https://libretranslate.de
LIBRETRANSLATE_API_KEY=

# Security
FILES_PASSWORD=your_secure_password
SESSION_SECRET=your_session_secret

# Features
ENABLE_YOUTUBE_DOWNLOAD=true
ENABLE_TRANSLATIONS=true
ENABLE_FILE_CLEANUP=true
```

### Step 6: Test Installation

1. **Start the application**
   ```bash
   npm start
   ```

2. **Verify services**
   ```bash
   # Test Whisper
   whisper --help
   
   # Test yt-dlp
   yt-dlp --version
   
   # Test FFmpeg
   ffmpeg -version
   ```

3. **Open the application**
   Navigate to `http://localhost:3000` in your browser

4. **Test transcription**
   - Upload a small audio file
   - Verify transcription completes successfully

---

## Configuration

### Basic Configuration

#### Environment Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `PORT` | Server port | 3000 | No |
| `NODE_ENV` | Environment mode | development | No |
| `WHISPER_MODEL` | Whisper model size | base | No |
| `WHISPER_DEVICE` | Processing device | auto | No |
| `MAX_FILE_SIZE` | Maximum upload size | 500MB | No |
| `FILES_PASSWORD` | Admin password | - | Yes |

#### Whisper Models

Choose based on your hardware and accuracy needs:

| Model | Size | Speed | Accuracy | VRAM |
|-------|------|-------|----------|------|
| tiny | 39 MB | Fastest | Lowest | 1GB |
| base | 74 MB | Fast | Good | 1GB |
| small | 244 MB | Medium | Better | 2GB |
| medium | 769 MB | Slow | Very Good | 5GB |
| large | 1550 MB | Slowest | Best | 10GB |

### Advanced Configuration

#### GPU Configuration

For NVIDIA GPU acceleration:

1. **Install CUDA Toolkit**
   - Download from [NVIDIA Developer](https://developer.nvidia.com/cuda-downloads)
   - Follow installation instructions for your OS

2. **Verify GPU support**
   ```bash
   python -c "import torch; print(torch.cuda.is_available())"
   ```

3. **Set environment variables**
   ```env
   WHISPER_DEVICE=cuda
   ```

#### LibreTranslate Setup (Optional)

For translation services:

1. **Install LibreTranslate**
   ```bash
   pip install libretranslate
   ```

2. **Start LibreTranslate server**
   ```bash
   libretranslate --host 0.0.0.0 --port 5000
   ```

3. **Configure in .env**
   ```env
   LIBRETRANSLATE_URL=http://localhost:5000
   ```

#### Reverse Proxy Setup

For production deployment with Nginx:

1. **Install Nginx**
   ```bash
   # Ubuntu/Debian
   sudo apt install nginx
   ```

2. **Configure Nginx**
   ```nginx
   server {
       listen 80;
       server_name your-domain.com;
       
       location / {
           proxy_pass http://localhost:3000;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection 'upgrade';
           proxy_set_header Host $host;
           proxy_cache_bypass $http_upgrade;
       }
   }
   ```

---

## Troubleshooting

### Common Issues

#### 1. Whisper Not Found
**Error:** `whisper: command not found`

**Solution:**
```bash
# Verify Python PATH
python -m pip list | grep openai-whisper

# Reinstall if needed
pip install --upgrade openai-whisper
```

#### 2. FFmpeg Not Found
**Error:** `ffmpeg: command not found`

**Solution:**
- **Windows**: Add FFmpeg to system PATH
- **macOS**: `brew install ffmpeg`
- **Linux**: `sudo apt install ffmpeg`

#### 3. Port Already in Use
**Error:** `EADDRINUSE: address already in use :::3000`

**Solution:**
```bash
# Find process using port 3000
netstat -tulpn | grep 3000

# Kill the process or change port in .env
PORT=3001
```

#### 4. GPU Not Detected
**Error:** GPU not being used for transcription

**Solution:**
```bash
# Check CUDA installation
nvidia-smi

# Verify PyTorch CUDA support
python -c "import torch; print(torch.cuda.is_available())"

# Reinstall CUDA-enabled PyTorch
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
```

#### 5. Large File Upload Fails
**Error:** File upload timeout or memory issues

**Solution:**
```env
# Increase limits in .env
MAX_FILE_SIZE=1GB
```

```bash
# For Node.js memory issues
export NODE_OPTIONS="--max-old-space-size=4096"
npm start
```

### Memory Issues

#### For Large Files
```bash
# Increase Node.js memory limit
export NODE_OPTIONS="--max-old-space-size=8192"

# Use smaller Whisper model
WHISPER_MODEL=small
```

#### For Multiple Concurrent Users
```bash
# Implement queue limits
CONCURRENT_TRANSCRIPTIONS=2
```

### Performance Optimization

#### CPU Optimization
```env
# Use appropriate model for your hardware
WHISPER_MODEL=base  # for 4-8GB RAM
WHISPER_MODEL=small # for 8-16GB RAM
```

#### GPU Optimization
```env
# Use GPU acceleration
WHISPER_DEVICE=cuda

# Optimize for specific GPU
CUDA_VISIBLE_DEVICES=0
```

### Logging and Debugging

#### Enable Debug Logging
```env
NODE_ENV=development
DEBUG=whisper:*
```

#### Check Application Logs
```bash
# Start with verbose logging
npm start 2>&1 | tee app.log

# Monitor logs in real-time
tail -f app.log
```

---

## Advanced Setup

### Docker Deployment

#### 1. Using Docker Compose (Recommended)

Create `docker-compose.yml`:
```yaml
version: '3.8'
services:
  whisper-app:
    build: .
    ports:
      - "3000:3000"
    volumes:
      - ./uploads:/app/uploads
      - ./transcriptions:/app/transcriptions
    environment:
      - NODE_ENV=production
      - WHISPER_MODEL=base
    depends_on:
      - libretranslate
  
  libretranslate:
    image: libretranslate/libretranslate:latest
    ports:
      - "5000:5000"
    environment:
      - LT_DISABLE_WEB_UI=true
```

#### 2. Build and Run
```bash
docker-compose up -d
```

### Cloud Deployment

#### VPS Deployment
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Install Docker Compose
sudo apt install docker-compose-plugin

# Clone and deploy
git clone https://github.com/mayeaux/generate-subtitles.git
cd generate-subtitles
docker-compose up -d
```

#### GPU Cloud Providers

**Vast.ai Setup:**
1. Create account at [vast.ai](https://vast.ai/)
2. Search for GPU instances with:
   - CUDA 11.8+
   - 8GB+ VRAM
   - Ubuntu 20.04+
3. Use the provided installation script

**Google Colab Setup:**
```python
# In Colab notebook
!git clone https://github.com/mayeaux/generate-subtitles.git
%cd generate-subtitles
!pip install -r requirements.txt
!npm install

# Start with ngrok for public access
!npm install -g localtunnel
!lt --port 3000 &
!npm start
```

### Production Deployment

#### System Service Setup

Create systemd service file:
```bash
sudo nano /etc/systemd/system/whisper-app.service
```

```ini
[Unit]
Description=Whisper AI Transcription App
After=network.target

[Service]
Type=simple
User=whisper
WorkingDirectory=/opt/whisper-app
ExecStart=/usr/bin/npm start
Restart=always
RestartSec=10
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
```

Enable and start:
```bash
sudo systemctl enable whisper-app
sudo systemctl start whisper-app
sudo systemctl status whisper-app
```

#### SSL Certificate Setup

Using Let's Encrypt:
```bash
# Install Certbot
sudo apt install certbot python3-certbot-nginx

# Obtain certificate
sudo certbot --nginx -d your-domain.com

# Auto-renewal
sudo systemctl enable certbot.timer
```

### Monitoring and Maintenance

#### Health Monitoring
```bash
# Install monitoring tools
npm install -g pm2

# Start with PM2
pm2 start app.js --name whisper-app
pm2 startup
pm2 save
```

#### Log Rotation
```bash
# Setup logrotate
sudo nano /etc/logrotate.d/whisper-app
```

```
/var/log/whisper-app/*.log {
    daily
    rotate 7
    compress
    missingok
    notifempty
    create 644 whisper whisper
}
```

---

## Security Considerations

### File Upload Security
- Implement file type validation
- Set reasonable size limits
- Scan uploads for malware
- Use temporary directories with cleanup

### Network Security
- Use SSL/TLS in production
- Implement rate limiting
- Configure firewall rules
- Regular security updates

### Data Privacy
- Clean up uploaded files
- Secure transcription storage
- Implement user data protection
- Regular backup procedures

---

## Support and Community

### Getting Help
1. **Documentation**: Check this guide and project README
2. **Issues**: Search existing GitHub issues
3. **Community**: Join project discussions
4. **Support**: Create detailed issue reports

### Contributing
1. Fork the repository
2. Create feature branch
3. Make changes with tests
4. Submit pull request

### Reporting Issues
Include in your report:
- Operating system and version
- Node.js and Python versions
- Error messages and logs
- Steps to reproduce
- Expected vs actual behavior

---

*This installation guide is maintained by the community. For updates and improvements, please contribute to the project repository.*

*Last Updated: 2025-06-27*
