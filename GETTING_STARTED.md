# Getting Started

Welcome! This guide will help you get MacMemoryApp running on your machine and ready for GitHub.

## What You Have

✅ **Fully optimized Mac Memory Monitor app**
- Power-efficient background processing
- Clean SwiftUI interface
- Menu bar integration

✅ **Complete documentation**
- README.md - Main project documentation
- INSTALL.md - Installation instructions
- DEPLOYMENT.md - Build and deployment guide
- GITHUB_SETUP.md - GitHub repository setup
- QUICK_START.md - Quick reference guide

✅ **Build tools**
- `build.sh` - Automated build script
- GitHub Actions workflow (optional CI/CD)

✅ **Ready for distribution**
- MIT License
- Proper .gitignore
- All source code organized

## Quick Start (3 Steps)

### 1. Build the App

```bash
cd /Users/AlwinRajkumar/Desktop/resume/macmemory
chmod +x build.sh
./build.sh
```

**Note:** Requires Xcode to be installed. If you get an error, install Xcode from the App Store first.

### 2. Install on Your Machine

```bash
cp -R build/Build/Products/Release/MacMemoryApp.app /Applications/
open /Applications/MacMemoryApp.app
```

**First time:** Right-click the app and select "Open" to bypass macOS security.

### 3. Use the App

Look for the memory chip icon (🧠) in your menu bar. Click it to see memory usage!

## Next Steps

### For Personal Use

1. ✅ Build and install (steps above)
2. ✅ Enjoy monitoring your Mac's memory!

### For GitHub Distribution

1. **Read:** [GITHUB_SETUP.md](GITHUB_SETUP.md)
2. **Create:** GitHub repository
3. **Update:** Replace `yourusername` in README.md with your GitHub username
4. **Push:** Your code to GitHub
5. **Create:** First release with the built app

## Documentation Guide

| File | Purpose | When to Read |
|------|---------|--------------|
| **README.md** | Main project documentation | Start here |
| **INSTALL.md** | Installation instructions | When installing |
| **DEPLOYMENT.md** | Build and deployment | When building |
| **GITHUB_SETUP.md** | GitHub setup | Before pushing to GitHub |
| **QUICK_START.md** | Quick reference | Quick lookup |
| **ARCHITECTURE.md** | Technical architecture | Understanding the code |
| **GETTING_STARTED.md** | This file | Right now! |

## Common Tasks

### Build the App
```bash
./build.sh
```

### Install Locally
```bash
cp -R build/Build/Products/Release/MacMemoryApp.app /Applications/
```

### Create Release ZIP
```bash
cd build/Build/Products/Release
zip -r MacMemoryApp-v1.0.0.zip MacMemoryApp.app
```

### Uninstall
```bash
rm -rf /Applications/MacMemoryApp.app
```

### Launch
```bash
open /Applications/MacMemoryApp.app
```

## Troubleshooting

### "xcodebuild: command not found"
- Install Xcode from App Store
- Run: `sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer`

### "App is damaged"
- Right-click → Open (first time)
- Or: `sudo xattr -rd com.apple.quarantine /Applications/MacMemoryApp.app`

### App not in menu bar
- Check Activity Monitor
- Look in menu bar overflow (click "..." icon)
- Relaunch: `killall MacMemoryApp && open /Applications/MacMemoryApp.app`

## Project Structure

```
macmemory/
├── MacMemoryApp/              # Source code
│   ├── MacMemoryApp.swift     # App entry point
│   ├── ContentView.swift      # Main UI
│   ├── Models/                # Data models
│   ├── Services/              # Business logic
│   └── Views/                 # UI components
├── MacMemoryApp.xcodeproj/    # Xcode project
├── build.sh                   # Build script
├── README.md                  # Main docs
├── INSTALL.md                 # Installation guide
├── DEPLOYMENT.md              # Deployment guide
├── GITHUB_SETUP.md           # GitHub setup
└── LICENSE                    # MIT License
```

## Need Help?

1. Check the relevant documentation file (see table above)
2. Review [Troubleshooting](#troubleshooting) section
3. Check GitHub Issues (if you've published)
4. Review the code comments

## What's Next?

1. **Build and test** the app on your machine
2. **Customize** if desired (colors, thresholds, etc.)
3. **Push to GitHub** when ready
4. **Create a release** for others to download
5. **Share** with the community!

Good luck! 🚀

