#!/bin/bash

# Build script for MacMemoryApp
# This script builds a release version of the app

set -e  # Exit on error

echo "🔨 Building MacMemoryApp..."
echo ""

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf build
mkdir -p build

# Build the app
echo "📦 Building Release configuration..."
xcodebuild -project MacMemoryApp.xcodeproj \
           -scheme MacMemoryApp \
           -configuration Release \
           -derivedDataPath ./build \
           clean build \
           CODE_SIGN_IDENTITY="" \
           CODE_SIGNING_REQUIRED=NO \
           CODE_SIGNING_ALLOWED=NO

# Check if build succeeded
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Build successful!"
    echo ""
    
    APP_PATH="build/Build/Products/Release/MacMemoryApp.app"
    ZIP_PATH="build/Build/Products/Release/MacMemoryApp.zip"
    
    # Automatically create ZIP file
    echo "📦 Creating ZIP archive..."
    BUILD_DIR="$(pwd)"
    cd build/Build/Products/Release
    zip -rq MacMemoryApp.zip MacMemoryApp.app
    cd "$BUILD_DIR"
    
    echo "✅ ZIP created!"
    echo ""
    echo "📱 App location:"
    echo "   $(pwd)/$APP_PATH"
    echo ""
    echo "📦 ZIP location:"
    echo "   $(pwd)/$ZIP_PATH"
    echo ""
    echo "💡 To install:"
    echo "   cp -R $APP_PATH /Applications/"
    echo ""
    echo "💡 To create a versioned release ZIP:"
    echo "   ./distribute.sh"
    echo ""
else
    echo ""
    echo "❌ Build failed!"
    exit 1
fi

