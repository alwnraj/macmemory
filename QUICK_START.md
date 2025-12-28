# Quick Start Guide

## Opening the Project

1. Navigate to: `/Users/AlwinRajkumar/Desktop/resume/macmemory/`
2. Double-click on `MacMemoryApp.xcodeproj` to open in Xcode

## Building the App

1. In Xcode, select the "MacMemoryApp" scheme from the scheme selector at the top
2. Press `Cmd + B` to build the project
3. Press `Cmd + R` to run the app

## First Run

When you run the app for the first time:
- The app will launch and appear in your menu bar (top right) with a memory chip icon
- It won't appear in the Dock (it's configured as an agent app)
- Click the menu bar icon to see the memory monitor interface

## Using the App

1. **Click the menu bar icon** - A popover window will appear
2. **View memory usage** - See all running apps with their memory consumption
3. **Click "Refresh"** - Update the memory data anytime
4. **Click "Quit"** - Close the app completely
5. **Color indicators**:
   - Blue: Low memory usage (<5%)
   - Orange: Medium memory usage (5-10%)
   - Red: High memory usage (>10%)

## Troubleshooting

### If the app doesn't show in menu bar:
- Make sure the app is actually running (check Activity Monitor)
- Look for the memory chip icon in your menu bar
- Try quitting and relaunching

### If memory data doesn't load:
- Click the "Refresh" button
- Check Console.app for any error messages
- Verify the app has necessary permissions

### If build fails:
- Ensure you're running macOS 13.0 (Ventura) or later
- Make sure Xcode 14 or later is installed
- Clean build folder: Product → Clean Build Folder (`Cmd + Shift + K`)

## Technical Notes

- The app uses `proc_pid_rusage()` to get accurate memory footprint
- App Sandbox is disabled (required for reading other processes' memory)
- Only user-visible applications are shown (no system daemons)
- Memory data is sorted by usage (highest first)

## Quick Update Script

If you already have the app installed and want to quickly rebuild and update it:

```bash
./update.sh
```

This script will:
- Quit the running app (if it's running)
- Clean and rebuild the app
- Remove the old version from Applications
- Install the new version
- Optionally launch the updated app

Alternatively, you can use the standard build script:

```bash
./build.sh
```

Then manually copy to Applications:

```bash
cp -R build/Build/Products/Release/MacMemoryApp.app /Applications/
```

## Customization Ideas

You can customize the app by:
- Changing the menu bar icon (edit `MacMemoryApp.swift`, line with `Image(systemName:)`)
- Adjusting the color thresholds (edit `AppRowView.swift`, `progressColor` property)
- Modifying the window width (edit `ContentView.swift`, `.frame(width:)`)
- Adding auto-refresh with a timer (modify `MemoryMonitor.swift`)

Enjoy your new Mac Memory Monitor app!

