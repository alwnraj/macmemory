# Quick Update Instructions

## What's New
✅ Added a **Quit button** in the app footer (red button on the left)
✅ Created a **quick update script** for easy updates

## How to Update Your Installed App

### Option 1: Quick Update (Recommended)
Run the update script from the project directory:

```bash
cd /Users/AlwinRajkumar/Desktop/resume/macmemory
./update.sh
```

This will:
1. Automatically quit the app if it's running
2. Clean and rebuild the app
3. Remove the old version from Applications
4. Install the new version
5. Ask if you want to launch it

### Option 2: Manual Update

1. **Build the app:**
   ```bash
   cd /Users/AlwinRajkumar/Desktop/resume/macmemory
   ./build.sh
   ```

2. **Quit the current app** (using the new Quit button!)

3. **Install the new version:**
   ```bash
   cp -R build/Build/Products/Release/MacMemoryApp.app /Applications/
   ```

4. **Launch the app:**
   ```bash
   open /Applications/MacMemoryApp.app
   ```

## Scripts Available

- **`build.sh`** - Standard build script (builds the app but doesn't install)
- **`update.sh`** - Complete update workflow (build + install + launch)

## New Features

### Quit Button
- Located in the footer next to the Refresh button
- Red "Quit" button with an X icon
- Properly terminates the menu bar app

## Tips

- The update script will automatically handle closing the running app
- Both scripts skip code signing (not needed for personal use)
- The app will appear in your Applications folder
- It runs in the menu bar (look for the memory chip icon)

---

Last updated: December 28, 2025

