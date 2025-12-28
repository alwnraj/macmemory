# Mac Memory Monitor

A lightweight, optimized macOS menu bar app that displays memory usage for all running user applications. Built with SwiftUI for a native macOS experience.

## Features

- 🎯 Lives in your menu bar for quick access
- 📊 Shows memory usage in both GB and percentage
- 🎨 Clean, native macOS design with SwiftUI
- ⚡ Fast refresh on demand with background processing
- 🔍 Focuses on user-visible applications only
- 📈 Sorted by memory usage (highest first)
- 🎨 Color-coded progress bars for quick visual reference
- 🔋 Power-efficient with optimized background processing
- ⚙️ Filters out apps with minimal memory usage (<1MB)

## Requirements

- **macOS 13.0 (Ventura) or later**
- **Xcode 14.0 or later** (for building from source)

## Quick Start

### Option 1: Download Pre-built Release (Easiest)

1. Go to the [Releases](https://github.com/yourusername/macmemory/releases) page
2. Download the latest `MacMemoryApp-v*.zip`
3. Extract and move `MacMemoryApp.app` to `/Applications/`
4. Right-click and select "Open" (first time only)
5. See [INSTALL.md](INSTALL.md) for detailed installation instructions

### Option 2: Build from Source

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

4. **Or open in Xcode:**
   ```bash
   open MacMemoryApp.xcodeproj
   ```
   - Select the "MacMemoryApp" scheme
   - Press `Cmd + R` to build and run

### Option 2: Build from Command Line

```bash
# Navigate to project directory
cd macmemory

# Build the app
xcodebuild -project MacMemoryApp.xcodeproj \
           -scheme MacMemoryApp \
           -configuration Release \
           -derivedDataPath ./build

# The built app will be at:
# ./build/Build/Products/Release/MacMemoryApp.app
```

### Option 3: Use the Build Script

```bash
# Make the script executable (first time only)
chmod +x build.sh

# Run the build script
./build.sh
```

The built app will be in the `build/` directory.

## Installation

After building:

1. **Locate the built app:**
   - If built in Xcode: `~/Library/Developer/Xcode/DerivedData/MacMemoryApp-*/Build/Products/Release/MacMemoryApp.app`
   - If built with script: `./build/MacMemoryApp.app`

2. **Move to Applications:**
   ```bash
   cp -R MacMemoryApp.app /Applications/
   ```

3. **First Launch:**
   - Open the app from Applications (or double-click)
   - macOS may show a security warning since the app isn't notarized
   - Go to **System Settings → Privacy & Security**
   - Click **"Open Anyway"** next to the security message
   - The app will appear in your menu bar

## How to Use

1. **Click the memory chip icon** in your menu bar (top right)
2. **View memory usage** - See all running apps with their memory consumption
3. **Click "Refresh"** - Update the memory data anytime
4. **Color indicators:**
   - 🔵 Blue: Low memory usage (<5%)
   - 🟠 Orange: Medium memory usage (5-10%)
   - 🔴 Red: High memory usage (>10%)

## Distribution

### For GitHub Releases

To create a distributable version:

1. **Build a Release version:**
   ```bash
   ./build.sh
   ```

2. **Create a ZIP archive:**
   ```bash
   cd build
   zip -r MacMemoryApp-v1.0.zip MacMemoryApp.app
   ```

3. **Upload to GitHub Releases:**
   - Go to your repository → Releases → Create a new release
   - Upload the ZIP file
   - Users can download, unzip, and move to Applications

### Note on Code Signing

The app uses **Automatic Code Signing** with no development team set. For distribution:

- **Personal use:** Works fine as-is
- **Public distribution:** Consider:
  - Setting up an Apple Developer account
  - Configuring code signing in Xcode
  - Notarizing the app for Gatekeeper compatibility

Users may need to right-click and select "Open" the first time, then click "Open" in the security dialog.

## Technical Details

- **SwiftUI** with `MenuBarExtra` for modern menu bar integration
- **NSWorkspace** to enumerate running user applications
- **libproc** (`proc_pid_rusage`) for accurate per-process memory footprint
- **Background processing** with `DispatchQueue` for power efficiency
- **Debounced refresh** to prevent excessive CPU usage
- **No App Sandbox** (required to read other processes' memory information)

## Performance Optimizations

- ✅ Background queue processing (doesn't block UI)
- ✅ Debounced refresh calls
- ✅ Memory threshold filtering (<1MB apps excluded)
- ✅ Optimized SwiftUI rendering
- ✅ Efficient progress bar rendering without GeometryReader

## Project Structure

```
MacMemoryApp/
├── MacMemoryApp.swift           # App entry point with MenuBarExtra
├── ContentView.swift             # Main popover view
├── Models/
│   └── AppMemoryInfo.swift       # Data model for app memory info
├── Services/
│   └── MemoryMonitor.swift       # Memory data fetching service
├── Views/
│   └── AppRowView.swift          # Individual app row component
└── Assets.xcassets               # App assets and icons
```

## Troubleshooting

### App doesn't appear in menu bar
- Check if the app is running in Activity Monitor
- Look for the memory chip icon in your menu bar
- Try quitting and relaunching the app

### "App is damaged" or security warning
- Right-click the app → Open (first time only)
- Or: System Settings → Privacy & Security → Allow the app
- This happens because the app isn't notarized (normal for open source apps)

### Memory data doesn't load
- Click the "Refresh" button
- Check Console.app for error messages
- Ensure you're running macOS 13.0 or later

### Build fails
- Ensure Xcode 14+ is installed
- Clean build folder: `Product → Clean Build Folder` (Cmd+Shift+K)
- Check that macOS 13.0+ SDK is available

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Credits

Built with SwiftUI and native macOS APIs. Optimized for performance and power efficiency.

