#!/bin/bash

# Distribution script for MacMemoryApp
# Creates a versioned ZIP file ready for GitHub Releases

set -e  # Exit on error

echo "📦 Creating Distribution Package"
echo "================================"
echo ""

# Check if app exists
APP_PATH="build/Build/Products/Release/MacMemoryApp.app"
if [ ! -d "$APP_PATH" ]; then
    echo "❌ App not found at $APP_PATH"
    echo "💡 Run ./build.sh first to build the app"
    exit 1
fi

# Try to get version from Info.plist
VERSION=$(plutil -extract CFBundleShortVersionString raw "$APP_PATH/Contents/Info.plist" 2>/dev/null || echo "1.0")

# Try to get git tag version if available
GIT_TAG=$(git describe --tags --exact-match 2>/dev/null || git describe --tags 2>/dev/null || echo "")

# Use git tag if available, otherwise use Info.plist version
if [ ! -z "$GIT_TAG" ]; then
    VERSION=$(echo "$GIT_TAG" | sed 's/^v//')
    ZIP_NAME="MacMemoryApp-v${VERSION}.zip"
else
    ZIP_NAME="MacMemoryApp-v${VERSION}.zip"
fi

# Ask user for version if they want to override
read -p "📝 Version (press Enter for '$VERSION'): " USER_VERSION
if [ ! -z "$USER_VERSION" ]; then
    VERSION="$USER_VERSION"
    ZIP_NAME="MacMemoryApp-v${VERSION}.zip"
fi

ZIP_PATH="build/Build/Products/Release/$ZIP_NAME"

echo ""
echo "📦 Creating ZIP: $ZIP_NAME"
BUILD_DIR="$(pwd)"
cd build/Build/Products/Release
rm -f "$ZIP_NAME"  # Remove old version if exists
zip -rq "$ZIP_NAME" MacMemoryApp.app
cd "$BUILD_DIR"

# Get file size
FILE_SIZE=$(du -h "$ZIP_PATH" | cut -f1)

echo ""
echo "✅ Distribution package created!"
echo ""
echo "📦 ZIP file:"
echo "   $(pwd)/$ZIP_PATH"
echo "   Size: $FILE_SIZE"
echo ""
echo "💡 Next steps:"
echo "   1. Test the ZIP by extracting it"
echo "   2. Upload to GitHub Releases:"
echo "      gh release create v${VERSION} $ZIP_PATH --title \"v${VERSION}\""
echo "   Or manually upload at: https://github.com/alwnraj/macmemory/releases/new"
echo ""

