# Whisper AI Generate Subtitles & Transcriptions

A powerful, user-friendly web application for generating accurate transcripts and subtitles from audio and video content. Powered by OpenAI's Whisper AI with automatic translations via LibreTranslate.

🌐 **Live Demo**: [freesubtitles.ai](https://freesubtitles.ai)

## ✨ Features

- **AI-Powered Transcription**: Uses OpenAI Whisper for highly accurate speech-to-text
- **Multi-Language Support**: 100+ languages for transcription and 50+ for translation
- **Multiple Input Sources**: Upload files or process YouTube videos directly
- **Real-Time Progress**: WebSocket-powered live transcription status
- **Multiple Output Formats**: SRT, VTT subtitle formats
- **Translation Services**: Automatic subtitle translation via LibreTranslate
- **Modern Web Interface**: Responsive, mobile-friendly design
- **Batch Processing**: Queue system for handling multiple files
- **Cloud Ready**: Docker support and cloud deployment guides

## 📖 Documentation

- **[Installation Guide](INSTALLATION.md)** - Complete step-by-step setup instructions
- **[Development Logs](DEVELOPMENT_LOGS.md)** - Track development progress and decisions
- **[Change Log](CHANGELOG.md)** - Version history and release notes
- **[Development Plans](DEVELOPMENT_PLANS.md)** - Roadmap and future features
- **[API Documentation](docs/)** - Technical documentation and examples

## 🛠️ Technology Stack

- **Backend**: Node.js, Express.js
- **Frontend**: Pug templates, vanilla JavaScript, CSS
- **AI/ML**: OpenAI Whisper, LibreTranslate
- **Real-time**: WebSockets for live progress updates
- **File Processing**: FFmpeg for audio/video handling
- **Queue System**: Custom implementation for batch processing

## 🔧 Configuration

The application uses environment variables for configuration. Copy `.env.sample` to `.env` and customize:

```env
# Server Configuration
PORT=3000
NODE_ENV=development

# Whisper Settings
WHISPER_MODEL=base          # tiny, base, small, medium, large
WHISPER_DEVICE=auto         # auto, cpu, cuda

# Features
ENABLE_YOUTUBE_DOWNLOAD=true
ENABLE_TRANSLATIONS=true
FILES_PASSWORD=your_password

# Translation Service (Optional)
LIBRETRANSLATE_URL=https://libretranslate.de
```

## 📊 Supported Formats

### Input Formats
- **Audio**: MP3, WAV, FLAC, M4A, AAC, OGG
- **Video**: MP4, AVI, MOV, MKV, WEBM, FLV
- **URLs**: YouTube, direct media links

### Output Formats
- **Subtitles**: SRT, VTT
- **Text**: Plain text transcriptions
- **Languages**: 100+ supported languages

## 🚀 Quick Start

### Option 1: One-Command Setup
```bash
git clone https://github.com/mayeaux/generate-subtitles.git
cd generate-subtitles
./setup.sh  # Linux/macOS
# or setup.ps1 for Windows
npm start
```

### Option 2: Manual Installation
For detailed setup instructions, see our comprehensive [Installation Guide](INSTALLATION.md).

### Basic Requirements
- Node.js 18+ 
- Python 3.8+
- FFmpeg
- OpenAI Whisper

```bash
# Quick install (after prerequisites)
git clone https://github.com/mayeaux/generate-subtitles.git
cd generate-subtitles
npm install
cp .env.sample .env
npm start
```

Navigate to `http://localhost:3000` to start using the application.

## Using a GPU Cloud Provider
Note: Unless you have a GPU that can use CUDA, you will likely have to use your CPU to transcribe which is significantly less performant, hence why you may have to rent a GPU server from a cloud provider. The only GPU cloud provider that I've had a good experience with is VastAI which is what I use to run https://freesubtitles.ai , if you use this link I should receive a 2.5% of your purchase for the referral: http://vast.ai/?ref=52232

To setup the Vast server to run Whisper, you can use the following script: 
https://github.com/mayeaux/generate-subtitles/blob/master/docs/install.sh (Note, this script isn't perfect yet but has all the ingredients you need).

While creating the Vast server, you will have to open some ports, this is the configuration I use to achieve that:

Hit `EDIT IMAGE & CONFIG..`

<img src="https://user-images.githubusercontent.com/7200471/207619301-5cdbf85e-8b6e-479a-8562-0d7d01bea715.JPG" width="500" alt="Screen Shot 2022-12-14 at 3 15 48 PM" />


I select CUDA though it's not 100% necessary

<img src="https://user-images.githubusercontent.com/7200471/207619367-ce4779fc-8d21-4120-8f21-22bb179eb601.JPG" alt="Screen Shot 2022-12-14 at 3 15 58 PM" width="600" />

Then hit the `SELECT` button (the one that's to the right of the CUDA description and not the one next to cancel) and you can add this line to open the ports:
`-p 8081:8081 -p 8080:8080 -p 80:80 -p 443:443 -p 3000:3000 -p 5000:5000`

<img src="https://user-images.githubusercontent.com/7200471/207619664-4baeae12-9139-40bd-b4a3-2ac9bf4dffc3.JPG" alt="Screen Shot 2022-12-14 at 3 16 22 PM" width="600" />

Hit `SELECT & SAVE` and when you create an instance it should have the proper ports opened to be able to access the web app. Vast uses port forwarding so when your port 3000 is opened it will be accessed through another port but you should be able to figure that out from their interface.

## 🚀 Deployment Options

### Local Development
```bash
npm run dev  # Start with nodemon for auto-restart
```

### Production Deployment
```bash
npm start    # Standard production start
```

### Docker Deployment
```bash
docker-compose up -d
```

### Cloud Deployment
See our [Installation Guide](INSTALLATION.md) for detailed cloud deployment instructions including:
- VPS setup
- GPU cloud providers (Vast.ai, Google Colab)
- Kubernetes deployment
- CDN configuration

## 🤝 Contributing

We welcome contributions! Here's how you can help:

### For Developers
1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### For Users
- 🐛 **Report bugs** via GitHub Issues
- 💡 **Suggest features** and improvements
- 📝 **Improve documentation**
- 🧪 **Test beta features** and provide feedback

### Development Setup
```bash
git clone https://github.com/mayeaux/generate-subtitles.git
cd generate-subtitles
npm install
cp .env.sample .env
npm run dev  # Start development server
```

See [Development Logs](DEVELOPMENT_LOGS.md) for coding standards and contribution guidelines.

## 📈 Performance & Hardware

### CPU Processing
- **Minimum**: 4GB RAM, multi-core processor
- **Recommended**: 16GB RAM, 8+ cores
- **Large files**: Consider cloud GPU instances

### GPU Acceleration (Recommended)
- **NVIDIA GPU** with CUDA support
- **4GB+ VRAM** for medium models
- **10GB+ VRAM** for large models
- **Up to 10x faster** than CPU processing

### Model Performance Comparison

| Model | Size | Speed | Accuracy | RAM Usage | Best For |
|-------|------|-------|----------|-----------|----------|
| tiny | 39 MB | ⚡⚡⚡⚡⚡ | ⭐⭐ | 1GB | Quick tests |
| base | 74 MB | ⚡⚡⚡⚡ | ⭐⭐⭐ | 1GB | General use |
| small | 244 MB | ⚡⚡⚡ | ⭐⭐⭐⭐ | 2GB | Balanced |
| medium | 769 MB | ⚡⚡ | ⭐⭐⭐⭐⭐ | 5GB | High accuracy |
| large | 1550 MB | ⚡ | ⭐⭐⭐⭐⭐ | 10GB | Best quality |

## 📞 Support & Community

### Getting Help
- 📚 **Documentation**: Start with our [Installation Guide](INSTALLATION.md)
- 🐛 **Issues**: Search existing [GitHub Issues](https://github.com/mayeaux/generate-subtitles/issues)
- 💬 **Discussions**: Join [GitHub Discussions](https://github.com/mayeaux/generate-subtitles/discussions)
- 📧 **Contact**: Create a detailed issue report

### Reporting Issues
Please include:
- Operating system and version
- Node.js and Python versions
- Complete error messages
- Steps to reproduce the problem
- Expected vs. actual behavior

### Community Resources
- **Live Demo**: [freesubtitles.ai](https://freesubtitles.ai)
- **GitHub**: [Project Repository](https://github.com/mayeaux/generate-subtitles)
- **Documentation**: [Installation](INSTALLATION.md) | [API Docs](docs/) | [Development](DEVELOPMENT_LOGS.md)

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **OpenAI** for the incredible Whisper speech recognition model
- **LibreTranslate** for open-source translation services
- **yt-dlp** for YouTube video processing capabilities
- **FFmpeg** for robust audio/video processing
- **Community contributors** who help improve this project

## ⭐ Star History

If this project helped you, please consider giving it a star! It helps others discover the project and motivates continued development.

---

**Made with ❤️ by the open-source community**

For more information, visit our [comprehensive documentation](INSTALLATION.md) or try the [live demo](https://freesubtitles.ai).
