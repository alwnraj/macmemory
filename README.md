# MacMemory — Simple macOS memory monitor

A tiny, native macOS menu bar app that shows memory usage for user apps. Fast, power‑efficient, and built with SwiftUI.

Why use it?
- Instant view of which apps use the most RAM
- Small, unobtrusive menu bar UI
- Optimized background refreshes to save battery

Features
- Menu bar app with quick popover list
- Memory shown in GB and percentage
- Sorted by memory usage (highest first)
- Color-coded usage bars (low/medium/high)
- Ignores tiny processes (<1 MB)
- Lightweight, SwiftUI-based, background-friendly

Requirements
- macOS 13.0 (Ventura) or later
- Xcode 14.0 or later (to build)

Quick start

Option A — Download a release
1. Go to the Releases: [MacMemory Releases](https://github.com/alwnraj/macmemory/releases)
2. Download `MacMemoryApp-v*.zip`, unzip and move `MacMemoryApp.app` to `/Applications/`
3. First launch: right-click → Open if macOS blocks it

Option B — Build from the repo
```bash
git clone https://github.com/alwnraj/macmemory.git
cd macmemory
chmod +x build.sh
./build.sh
# or open in Xcode: open MacMemoryApp.xcodeproj
```
After build:
```bash
cp -R build/Build/Products/Release/MacMemoryApp.app /Applications/
```

How to use
- Click the chip icon in the menu bar
- See apps and their memory usage
- Tap Refresh to update immediately

Creating a release

**Easy way:**
```bash
./build.sh          # Builds app and creates MacMemoryApp.zip automatically
./distribute.sh     # Creates versioned ZIP (MacMemoryApp-v1.0.zip) for releases
```

The ZIP files are created in `build/Build/Products/Release/`:
- `MacMemoryApp.zip` - Created automatically by `build.sh`
- `MacMemoryApp-v*.zip` - Versioned ZIP created by `distribute.sh`

**Upload to GitHub Releases:**
```bash
gh release create v1.0 build/Build/Products/Release/MacMemoryApp-v1.0.zip --title "v1.0"
```

Or manually upload at: https://github.com/alwnraj/macmemory/releases/new

**Note:** For public distribution, sign and notarize the app with an Apple Developer account (Gatekeeper will otherwise require manual Open)

Technical highlights
- Uses MenuBarExtra, NSWorkspace and libproc (`proc_pid_rusage`)
- Memory collection runs off the main thread with debounced refreshes
- No App Sandbox (required to read other processes)

Project layout
```
MacMemoryApp/
├─ MacMemoryApp.swift
├─ ContentView.swift
├─ Models/AppMemoryInfo.swift
├─ Services/MemoryMonitor.swift
├─ Views/AppRowView.swift
└─ Assets.xcassets
```

Troubleshooting
- App not visible: confirm it’s running in Activity Monitor and look for the icon in the menu bar
- macOS blocks opening: right-click → Open, or System Settings → Privacy & Security → Open Anyway
- Data not updating: press Refresh and check Console.app for errors

Contributing
PRs welcome — keep changes small and well-described.

License
MIT — see [LICENSE](LICENSE).

Credits
Built with SwiftUI and native macOS APIs. Contact: alwnraj on GitHub.
