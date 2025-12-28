# GitHub Setup Guide

Quick guide to get your MacMemoryApp repository ready for GitHub.

## Initial Setup

### 1. Create GitHub Repository

1. Go to [GitHub](https://github.com/new)
2. Repository name: `macmemory` (or your preferred name)
3. Description: "A lightweight macOS menu bar app that displays memory usage for all running applications"
4. Choose **Public** (or Private if you prefer)
5. **Don't** initialize with README (you already have one)
6. Click **Create repository**

### 2. Update Repository URLs

Before pushing, update these files with your actual GitHub username:

**README.md:**
- Replace `yourusername` with your GitHub username in:
  - Clone URL
  - Releases URL
  - Any other GitHub links

**INSTALL.md:**
- Update the releases URL

**DEPLOYMENT.md:**
- Update any GitHub references

### 3. Initialize Git (if not already done)

```bash
cd /Users/AlwinRajkumar/Desktop/resume/macmemory

# Initialize git (if needed)
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: MacMemoryApp - macOS memory monitor"

# Add remote (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/macmemory.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## Creating Your First Release

### Step 1: Build the App

```bash
./build.sh
```

### Step 2: Create ZIP

```bash
cd build/Build/Products/Release
zip -r MacMemoryApp-v1.0.0.zip MacMemoryApp.app
```

### Step 3: Create GitHub Release

1. Go to your repository on GitHub
2. Click **Releases** → **Create a new release**
3. **Tag version:** `v1.0.0` (create new tag)
4. **Release title:** `MacMemoryApp v1.0.0`
5. **Description:**
   ```markdown
   ## First Release! 🎉
   
   MacMemoryApp is a lightweight macOS menu bar app that displays memory usage for all running applications.
   
   ### Features
   - Menu bar integration
   - Real-time memory monitoring
   - Clean SwiftUI interface
   - Power-efficient background processing
   
   ### Installation
   1. Download `MacMemoryApp-v1.0.0.zip`
   2. Extract and move to Applications
   3. Right-click and select "Open" (first time only)
   
   See [INSTALL.md](INSTALL.md) for detailed instructions.
   ```
6. **Attach binary:** Drag and drop `MacMemoryApp-v1.0.0.zip`
7. Check **"Set as the latest release"**
8. Click **Publish release**

## Repository Settings

### Recommended Settings

1. **Description:** "A lightweight macOS menu bar app that displays memory usage for all running applications"
2. **Topics:** Add tags like:
   - `macos`
   - `swift`
   - `swiftui`
   - `menu-bar`
   - `memory-monitor`
   - `system-monitor`
3. **Website:** (optional) Leave blank or add your website
4. **Social Preview:** GitHub will auto-generate from your README

### Enable GitHub Actions

The repository includes a GitHub Actions workflow (`.github/workflows/build.yml`) that will:
- Build the app automatically on push/PR
- Create artifacts you can download
- Attach to releases automatically

It's already set up - just push your code and it will work!

## README Badges (Optional)

Add these to the top of your README for a professional look:

```markdown
![macOS](https://img.shields.io/badge/macOS-13.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-4.0-green.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)
```

## Files to Review Before Pushing

Make sure these are correct:

- ✅ `README.md` - Update GitHub URLs
- ✅ `LICENSE` - MIT License (already set)
- ✅ `.gitignore` - Excludes build artifacts (already set)
- ✅ `build.sh` - Build script (ready to use)
- ✅ `.github/workflows/build.yml` - CI/CD (optional, but included)

## Quick Checklist

- [ ] Create GitHub repository
- [ ] Update `yourusername` in README.md
- [ ] Initialize git and push code
- [ ] Build the app (`./build.sh`)
- [ ] Create ZIP archive
- [ ] Create first release on GitHub
- [ ] Add repository description and topics
- [ ] Test downloading and installing from release

## Next Steps After Publishing

1. **Share the link:** `https://github.com/YOUR_USERNAME/macmemory`
2. **Star your own repo** (helps with visibility)
3. **Add to your portfolio/resume**
4. **Consider adding screenshots** to README
5. **Write a blog post** (optional) about building it

## Troubleshooting

### Push Fails

If you get authentication errors:
```bash
# Use GitHub CLI (if installed)
gh auth login

# Or use SSH instead of HTTPS
git remote set-url origin git@github.com:YOUR_USERNAME/macmemory.git
```

### GitHub Actions Not Running

- Make sure the workflow file is in `.github/workflows/`
- Check the **Actions** tab in your repository
- Ensure you've pushed the workflow file

### Release Not Showing

- Make sure you clicked "Publish release" (not just "Save draft")
- Check that the tag was created
- Verify the ZIP file uploaded successfully

Good luck! 🚀

