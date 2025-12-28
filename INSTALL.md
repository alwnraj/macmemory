# Installation Guide

## Quick Installation

### Step 1: Download

Download the latest release from GitHub:
- Go to the [Releases](https://github.com/yourusername/macmemory/releases) page
- Download `MacMemoryApp-v1.0.zip` (or latest version)

### Step 2: Extract

1. Double-click the ZIP file to extract it
2. You should see `MacMemoryApp.app`

### Step 3: Install

**Option A: Drag and Drop**
1. Open Finder
2. Navigate to Applications folder (Cmd+Shift+A)
3. Drag `MacMemoryApp.app` into the Applications folder

**Option B: Command Line**
```bash
# Navigate to where you extracted the app
cd ~/Downloads  # or wherever you extracted it

# Move to Applications
mv MacMemoryApp.app /Applications/
```

### Step 4: First Launch

1. **Open the app:**
   - Go to Applications folder
   - Double-click `MacMemoryApp.app`
   - OR use Spotlight (Cmd+Space) and type "MacMemoryApp"

2. **Handle Security Warning (First Time Only):**
   
   macOS may show a security warning because the app isn't notarized. This is normal for open source apps.
   
   **Method 1: Right-click Open**
   - Right-click on `MacMemoryApp.app`
   - Select "Open"
   - Click "Open" in the security dialog
   
   **Method 2: System Settings**
   - If you see a security message, go to:
   - **System Settings → Privacy & Security**
   - Scroll down to find the blocked app message
   - Click **"Open Anyway"**

3. **Verify Installation:**
   - Look for a memory chip icon (🧠) in your menu bar (top right)
   - Click it to see the memory monitor interface

## Building from Source

If you prefer to build from source:

### Prerequisites
- macOS 13.0 (Ventura) or later
- Xcode 14.0 or later

### Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/macmemory.git
   cd macmemory
   ```

2. **Build using the script:**
   ```bash
   chmod +x build.sh
   ./build.sh
   ```

3. **Install the built app:**
   ```bash
   cp -R build/Build/Products/Release/MacMemoryApp.app /Applications/
   ```

## Uninstallation

To remove the app:

1. **Quit the app:**
   - Click the menu bar icon
   - Or use Activity Monitor to quit the process

2. **Delete the app:**
   ```bash
   rm -rf /Applications/MacMemoryApp.app
   ```

## Troubleshooting

### "App is damaged and can't be opened"

This is a Gatekeeper security feature. To fix:

1. Right-click the app → Open
2. Or run in Terminal:
   ```bash
   sudo xattr -rd com.apple.quarantine /Applications/MacMemoryApp.app
   ```

### App doesn't appear in menu bar

1. Check if it's running:
   ```bash
   ps aux | grep MacMemoryApp
   ```

2. If not running, launch it:
   ```bash
   open /Applications/MacMemoryApp.app
   ```

3. Check menu bar visibility:
   - Some menu bar items can be hidden
   - Look in the menu bar overflow area (click the "..." icon)

### Permission Issues

The app needs to read memory information from other processes. If you see permission errors:

1. Check System Settings → Privacy & Security
2. Ensure the app has necessary permissions
3. You may need to grant Full Disk Access (rarely needed)

## System Requirements

- **macOS:** 13.0 (Ventura) or later
- **RAM:** Minimal (app uses <50MB)
- **Disk Space:** <10MB

## Support

If you encounter issues:

1. Check the [Troubleshooting](#troubleshooting) section above
2. Open an issue on GitHub
3. Check the [README.md](README.md) for more information

