# Project Structure Documentation

This document provides a comprehensive overview of the Whisper AI Generate Subtitles & Transcriptions project structure.

## 📁 Root Directory

```
whisper-ai-transcription/
├── 📄 README.md                 # Main project documentation
├── 📄 INSTALLATION.md           # Detailed installation guide
├── 📄 DEVELOPMENT_LOGS.md       # Development progress tracking
├── 📄 CHANGELOG.md              # Version history and changes
├── 📄 DEVELOPMENT_PLANS.md      # Roadmap and future plans
├── 📄 PROJECT_STRUCTURE.md      # This file
├── 📄 LICENSE                   # MIT License
├── 📄 package.json              # Node.js dependencies and scripts
├── 📄 .env.sample               # Environment configuration template
├── 📄 .gitignore               # Git ignore rules
├── 📄 app.js                   # Main application entry point
├── 🔧 setup.sh                 # Linux/macOS setup script
├── 🔧 setup.ps1                # Windows PowerShell setup script
└── 📁 [directories...]         # Application directories
```

## 📂 Directory Structure

### `/constants/`
Configuration and constant values used throughout the application.

```
constants/
├── 📄 constants.js             # Application constants and configuration
└── 📄 ytdlpUsers.txt          # YouTube download user agents
```

**Purpose**: Centralized configuration management and constant definitions.

### `/docs/`
Additional documentation and configuration files.

```
docs/
├── 📄 readme.md                # API usage examples
├── 📄 install-libretranslate   # LibreTranslate installation guide
├── 🔧 install.sh               # Server installation script
├── ⚙️ libretranslate-nginx     # Nginx configuration for LibreTranslate
├── ⚙️ nginx-whisper-and-libretranslate.conf  # Complete Nginx config
└── ⚙️ thing.conf               # Additional server configuration
```

**Purpose**: Extended documentation, deployment guides, and server configurations.

### `/downloading/`
Handles file downloads and YouTube video processing.

```
downloading/
├── 📄 download.js              # General download functionality
└── 📄 yt-dlp-download.js       # YouTube video download using yt-dlp
```

**Purpose**: Download management for various media sources.

### `/examples/`
Sample files and examples for testing and demonstration.

```
examples/
└── 📄 dnevnik.srt              # Sample SRT subtitle file
```

**Purpose**: Testing files and format examples.

### `/helpers/`
Utility functions and helper modules.

```
helpers/
├── 📄 formatStdErr.js          # Error message formatting
├── 📄 getLanguageNames.js      # Language name utilities
└── 📄 helpers.js               # General utility functions
```

**Purpose**: Reusable utility functions shared across the application.

### `/lib/`
Core business logic and main application libraries.

```
lib/
├── 📄 convertText.js           # Text conversion utilities
├── 📄 files.js                 # File management operations
├── 📄 stats.js                 # Statistics and analytics
├── 📄 transcribing.js          # Transcription logic
└── 📄 websockets.js            # WebSocket server implementation
```

**Purpose**: Core application functionality and business logic.

### `/public/`
Static assets served to the client.

```
public/
├── 📄 robots.txt               # Search engine crawler instructions
├── 📁 images/                  # Image assets
│   ├── 🖼️ discordLogo.png
│   ├── 🖼️ favicon.ico
│   ├── 🖼️ gh-logo.png
│   ├── 🖼️ githublogo.png
│   ├── 🖼️ inverted.png
│   ├── 🖼️ Octocat.png
│   ├── 🖼️ telegramLogo.webp
│   ├── 🖼️ thing.png
│   ├── 🖼️ transcriptionIcon.png
│   └── 🖼️ twitterLogo.png
├── 📁 javascripts/            # Client-side JavaScript
│   └── 📄 circle-progress.min.js
└── 📁 stylesheets/           # CSS stylesheets
    └── 📄 style.css
```

**Purpose**: Static assets including images, CSS, and client-side JavaScript.

### `/queue/`
Queue management system for batch processing.

```
queue/
├── 📄 newQueue.js              # New queue implementation
└── 📄 queue.js                 # Original queue system
```

**Purpose**: Job queue management for handling multiple transcription requests.

### `/routes/`
Express.js route handlers for different endpoints.

```
routes/
├── 📄 admin.js                 # Admin panel routes
├── 📄 api.js                   # API endpoints
├── 📄 index.js                 # Main application routes
├── 📄 player.js                # Media player routes
├── 📄 stats.js                 # Statistics routes
├── 📄 transcribe.js            # Transcription routes
└── 📄 users.js                 # User management routes
```

**Purpose**: HTTP request handling and API endpoint definitions.

### `/scripts/`
Utility scripts and automation tools.

```
scripts/
├── 📄 deleteTranscriptionUploads.js  # File cleanup automation
├── 📄 extractAudioFfmpeg.js          # Audio extraction from video
├── 📄 postAudioFile.js               # Audio file processing
└── 📄 srtToVtt.js                    # SRT to VTT format conversion
```

**Purpose**: Automation scripts and utility tools.

### `/transcribe/`
Transcription processing modules.

```
transcribe/
├── 📄 transcribe-api-wrapped.js      # API wrapper for transcription
├── 📄 transcribe-via-api.js          # API-based transcription
├── 📄 transcribe-wrapped.js          # Wrapped transcription logic
└── 📄 transcribing.js                # Core transcription functionality
```

**Purpose**: Whisper AI integration and transcription processing.

### `/translate/`
Translation services and language processing.

```
translate/
├── 📄 create-translated-files.js     # Translated file generation
├── 📄 google-translate-browser.js    # Google Translate integration
├── 📄 helpers.js                     # Translation utilities
├── 📄 libreTranslateWrapper.js       # LibreTranslate wrapper
└── 📄 translate-files-api.js         # Translation API handling
```

**Purpose**: Multi-language translation services and utilities.

### `/views/`
Pug templates for server-side rendering.

```
views/
├── 📄 admin.pug                # Admin panel template
├── 📄 error.pug                # Error page template
├── 📄 files.pug                # File management template
├── 📄 layout.pug               # Base layout template
├── 📄 queue.pug                # Queue status template
├── 📁 addTranslation/          # Translation management
│   └── 📄 addTranslation.pug
├── 📁 index/                   # Main application views
│   ├── 📄 index.pug
│   ├── 📁 components/
│   │   ├── 📄 amounts-header.pug
│   │   ├── 📄 social-buttons.pug
│   │   ├── 📄 transcription-results.pug
│   │   └── 📄 upload-form.pug
│   ├── 📁 js/                  # JavaScript templates
│   │   ├── 📄 js-index.pug
│   │   ├── 📄 js-util.pug
│   │   └── 📁 controllers/
│   │       ├── 📄 error-handling.pug
│   │       ├── 📄 file-handling.pug
│   │       ├── 📄 network-handling.pug
│   │       └── 📄 selection-dropdowns.pug
│   └── 📁 styles/              # CSS templates
│       ├── 📄 styles-amounts-header.pug
│       ├── 📄 styles-form.pug
│       ├── 📄 styles-social.pug
│       └── 📄 styles-transcription-results.pug
├── 📁 player/                  # Media player views
│   ├── 📄 player.pug
│   ├── 📄 styles-player.pug
│   └── 📁 js/
│       ├── 📄 captionsDisplay.pug
│       ├── 📄 secondCaptions.pug
│       └── 📄 videoProgress.pug
├── 📁 stats/                   # Statistics views
│   └── 📄 stats.pug
└── 📁 styles/                  # Global styles
    └── 📄 styles-global.pug
```

**Purpose**: Server-side templates using Pug templating engine.

## 🔧 Runtime Directories

These directories are created during application runtime:

### `/uploads/`
Temporary storage for uploaded files.
- **Purpose**: Stores user-uploaded audio/video files temporarily
- **Lifecycle**: Files are automatically cleaned up after processing
- **Security**: Should not be publicly accessible

### `/transcriptions/`
Generated transcription files and results.
- **Purpose**: Stores SRT, VTT, and text transcription files
- **Lifecycle**: Files may be retained based on configuration
- **Access**: Accessible via download links

### `/node_modules/`
Node.js dependencies installed by npm.
- **Purpose**: Contains all Node.js package dependencies
- **Management**: Managed by npm/yarn
- **Git**: Ignored by version control

## 📋 Key Files Explained

### `app.js`
The main application entry point that:
- Sets up Express.js server
- Configures middleware
- Initializes WebSocket server
- Sets up route handlers
- Starts the application

### `package.json`
Defines project metadata and dependencies:
- **dependencies**: Runtime packages required for production
- **devDependencies**: Development-only packages
- **scripts**: Automation commands (start, dev, lint)
- **nodemonConfig**: Development server configuration

### `.env.sample`
Template for environment configuration:
- Server settings (port, environment)
- Whisper AI configuration
- Feature toggles
- Security settings
- Service integrations

## 🏗️ Architecture Overview

### Request Flow
1. **Client Request** → Express.js routes (`/routes/`)
2. **Route Handler** → Business logic (`/lib/`)
3. **Processing** → Transcription/Translation (`/transcribe/`, `/translate/`)
4. **Response** → Template rendering (`/views/`) or JSON API

### File Processing Flow
1. **Upload** → Temporary storage (`/uploads/`)
2. **Validation** → File type and size checks
3. **Processing** → Audio extraction, transcription
4. **Output** → Subtitle files (`/transcriptions/`)
5. **Cleanup** → Automated file removal

### Real-time Communication
- **WebSockets** (`/lib/websockets.js`) provide real-time updates
- **Progress tracking** for long-running transcriptions
- **Error notifications** and status updates

## 🔐 Security Considerations

### File Security
- Upload validation and sanitization
- Temporary file cleanup
- Access control for sensitive files

### API Security
- Rate limiting implementation
- Input validation
- Authentication for admin features

### Configuration Security
- Environment variable usage
- Sensitive data protection
- Secure defaults

## 🚀 Development Workflow

### Local Development
1. **Setup**: Run `setup.sh` or `setup.ps1`
2. **Configuration**: Copy `.env.sample` to `.env`
3. **Development**: Use `npm run dev` for auto-reload
4. **Testing**: Manual testing via web interface

### Production Deployment
1. **Environment**: Set `NODE_ENV=production`
2. **Dependencies**: Run `npm install --production`
3. **Configuration**: Set production environment variables
4. **Monitoring**: Implement logging and health checks

## 📊 Monitoring and Maintenance

### Log Files
- Application logs for debugging
- Access logs for monitoring
- Error logs for troubleshooting

### File Cleanup
- Automated cleanup of old uploads
- Transcription file management
- Storage optimization

### Performance Monitoring
- Memory usage tracking
- Processing time metrics
- Queue status monitoring

## 🔧 Customization Points

### Adding New Features
1. **Routes**: Add new endpoints in `/routes/`
2. **Logic**: Implement in `/lib/`
3. **Templates**: Create views in `/views/`
4. **Styles**: Add CSS in `/public/stylesheets/`

### Configuration
- Environment variables in `.env`
- Constants in `/constants/`
- Feature toggles and settings

### Integration
- New AI models in `/transcribe/`
- Translation services in `/translate/`
- External APIs and webhooks

---

This documentation is maintained alongside the codebase. For questions about specific components, refer to the inline code comments and individual file documentation.

*Last Updated: 2025-06-27*
