#!/bin/bash

# Quick update script for MacMemoryApp
# This script rebuilds and reinstalls the app in one command

set -e  # Exit on error

echo "🚀 Quick Update for MacMemoryApp"
echo "================================"
echo ""

# Check if app is currently running
APP_RUNNING=$(pgrep -x "MacMemoryApp" || true)
if [ ! -z "$APP_RUNNING" ]; then
    echo "⚠️  MacMemoryApp is currently running"
    echo "🛑 Quitting the app..."
    killall MacMemoryApp 2>/dev/null || true
    sleep 1
fi

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf build

# Build the app
echo "📦 Building Release configuration..."
xcodebuild -project MacMemoryApp.xcodeproj \
           -scheme MacMemoryApp \
           -configuration Release \
           -derivedDataPath ./build \
           clean build \
           CODE_SIGN_IDENTITY="" \
           CODE_SIGNING_REQUIRED=NO \
           CODE_SIGNING_ALLOWED=NO > /dev/null 2>&1

# Check if build succeeded
if [ $? -ne 0 ]; then
    echo "❌ Build failed!"
    exit 1
fi

echo "✅ Build successful!"

# Remove old app from Applications
if [ -d "/Applications/MacMemoryApp.app" ]; then
    echo "🗑️  Removing old version from Applications..."
    rm -rf /Applications/MacMemoryApp.app
fi

# Install new version
echo "📲 Installing new version to Applications..."
cp -R build/Build/Products/Release/MacMemoryApp.app /Applications/

echo ""
echo "✨ Update complete!"
echo ""
echo "💡 To launch the app:"
echo "   open /Applications/MacMemoryApp.app"
echo ""
echo "   Or find it in your Applications folder"
echo ""

# Ask if user wants to launch now
read -p "🚀 Launch MacMemoryApp now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🎉 Launching MacMemoryApp..."
    open /Applications/MacMemoryApp.app
fi

