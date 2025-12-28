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
    echo "📱 App location:"
    echo "   $(pwd)/build/Build/Products/Release/MacMemoryApp.app"
    echo ""
    echo "💡 To install:"
    echo "   cp -R build/Build/Products/Release/MacMemoryApp.app /Applications/"
    echo ""
    echo "💡 To create a ZIP for distribution:"
    echo "   cd build/Build/Products/Release"
    echo "   zip -r MacMemoryApp-v1.0.zip MacMemoryApp.app"
    echo ""
else
    echo ""
    echo "❌ Build failed!"
    exit 1
fi

