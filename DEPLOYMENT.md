# Deployment Guide

This guide will help you deploy MacMemoryApp to your machine and prepare it for GitHub distribution.

## Prerequisites

Before you begin, ensure you have:
- ✅ macOS 13.0 (Ventura) or later
- ✅ Xcode 14.0 or later installed
- ✅ Command Line Tools (usually installed with Xcode)

To verify Xcode is installed:
```bash
xcode-select -p
# Should output: /Applications/Xcode.app/Contents/Developer
```

If you get an error, install Xcode from the App Store and run:
```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

## Building the App

### Method 1: Using the Build Script (Recommended)

```bash
# Navigate to project directory
cd /path/to/macmemory

# Make script executable (first time only)
chmod +x build.sh

# Run the build
./build.sh
```

The built app will be at: `build/Build/Products/Release/MacMemoryApp.app`

### Method 2: Using Xcode

1. Open `MacMemoryApp.xcodeproj` in Xcode
2. Select **Product → Scheme → MacMemoryApp**
3. Select **Product → Destination → My Mac**
4. Press `Cmd + B` to build
5. The app will be in: `~/Library/Developer/Xcode/DerivedData/MacMemoryApp-*/Build/Products/Release/MacMemoryApp.app`

### Method 3: Command Line (xcodebuild)

```bash
xcodebuild -project MacMemoryApp.xcodeproj \
           -scheme MacMemoryApp \
           -configuration Release \
           -derivedDataPath ./build \
           clean build
```

## Installing on Your Machine

### Step 1: Locate the Built App

After building, find the app:
- **Build script:** `./build/Build/Products/Release/MacMemoryApp.app`
- **Xcode:** `~/Library/Developer/Xcode/DerivedData/MacMemoryApp-*/Build/Products/Release/MacMemoryApp.app`

### Step 2: Copy to Applications

```bash
# Replace PATH with actual path to your built app
cp -R PATH/MacMemoryApp.app /Applications/
```

### Step 3: Launch the App

```bash
open /Applications/MacMemoryApp.app
```

Or double-click it in Finder.

### Step 4: Handle Security (First Time)

macOS may block the app because it's not notarized. To allow it:

**Option A: Right-click Open**
1. Right-click `MacMemoryApp.app` in Applications
2. Select "Open"
3. Click "Open" in the security dialog

**Option B: System Settings**
1. Go to **System Settings → Privacy & Security**
2. Find the blocked app message
3. Click **"Open Anyway"**

**Option C: Terminal (Advanced)**
```bash
sudo xattr -rd com.apple.quarantine /Applications/MacMemoryApp.app
```

### Step 5: Verify

Look for the memory chip icon (🧠) in your menu bar. Click it to see the memory monitor.

## Preparing for GitHub Distribution

### Step 1: Create a Release Build

```bash
./build.sh
```

### Step 2: Create a ZIP Archive

```bash
cd build/Build/Products/Release
zip -r MacMemoryApp-v1.0.zip MacMemoryApp.app
```

This creates `MacMemoryApp-v1.0.zip` that you can upload to GitHub.

### Step 3: Test the ZIP

Before uploading, test it:
```bash
# Extract to a test location
cd ~/Downloads
unzip MacMemoryApp-v1.0.zip

# Try opening it
open MacMemoryApp.app
```

### Step 4: Create GitHub Release

1. Go to your GitHub repository
2. Click **Releases → Create a new release**
3. Fill in:
   - **Tag:** `v1.0.0` (or your version)
   - **Title:** `MacMemoryApp v1.0.0`
   - **Description:** Copy from your README or write release notes
4. **Upload** the ZIP file
5. Click **Publish release**

### Step 5: Update README (Optional)

Update the download link in your README:
```markdown
Download the latest release: [v1.0.0](https://github.com/yourusername/macmemory/releases/latest)
```

## Automated Builds (GitHub Actions)

The repository includes a GitHub Actions workflow (`.github/workflows/build.yml`) that:
- Automatically builds the app on push/PR
- Creates a ZIP archive
- Uploads it as an artifact
- Attaches it to releases when you create one

To use it:
1. Push your code to GitHub
2. The workflow will run automatically
3. Check **Actions** tab to see build status
4. Download artifacts from the Actions page

## Code Signing (Optional, for Public Distribution)

For wider distribution, consider code signing:

1. **Get an Apple Developer Account** ($99/year)
2. **In Xcode:**
   - Select the project
   - Go to **Signing & Capabilities**
   - Select your **Team**
   - Xcode will handle signing automatically

3. **Notarize the app** (for Gatekeeper):
   ```bash
   xcrun notarytool submit MacMemoryApp.app \
     --apple-id your@email.com \
     --team-id YOUR_TEAM_ID \
     --password YOUR_APP_SPECIFIC_PASSWORD
   ```

This is optional - the app works fine without it, users just need to right-click open the first time.

## Troubleshooting

### Build Fails

**Error: "xcodebuild: command not found"**
- Install Xcode from App Store
- Run: `sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer`

**Error: "No such scheme"**
- Open the project in Xcode first
- Let Xcode index the project
- Try building again

**Error: Code signing issues**
- For personal use, disable code signing in build script (already done)
- For distribution, set up Apple Developer account

### App Won't Launch

**"App is damaged"**
- Right-click → Open (first time)
- Or: `sudo xattr -rd com.apple.quarantine /Applications/MacMemoryApp.app`

**App doesn't appear in menu bar**
- Check Activity Monitor to see if it's running
- Look in menu bar overflow area (click "..." icon)
- Try relaunching: `killall MacMemoryApp && open /Applications/MacMemoryApp.app`

## Quick Reference

```bash
# Build
./build.sh

# Install
cp -R build/Build/Products/Release/MacMemoryApp.app /Applications/

# Launch
open /Applications/MacMemoryApp.app

# Create release ZIP
cd build/Build/Products/Release
zip -r MacMemoryApp-v1.0.zip MacMemoryApp.app

# Uninstall
rm -rf /Applications/MacMemoryApp.app
```

## Next Steps

1. ✅ Build the app
2. ✅ Install on your machine
3. ✅ Test it works
4. ✅ Create ZIP for distribution
5. ✅ Push to GitHub
6. ✅ Create a release with the ZIP
7. ✅ Share the link!

Good luck! 🚀

