# Git Publishing Guide

Quick guide to publish this repository to GitHub.

## Initial Setup

```bash
# Initialize git
git init

# Add all files
git add .

# Initial commit
git commit -m "Initial release: NVIDIA 390.157 for modern kernels

- 50+ patches from RPM Fusion/ALT Linux
- Kernel 6.2-6.15+ support
- DKMS integration
- Tested on Tesla M2090 (Fermi)
- Compatible with all Fermi/Kepler GPUs"

# Set main branch
git branch -M main
```

## Create GitHub Repository

1. Go to https://github.com/new
2. Repository name: `nvidia-390-modern-kernel`
3. Description: `Automated NVIDIA 390.157 driver installation for modern Linux kernels (6.2-6.15+) with legacy GPU support`
4. Choose: **Public**
5. Don't initialize with README (already have one)
6. Click "Create repository"

## Push to GitHub

```bash
# Add remote
git remote add origin https://github.com/aroldobossoni/nvidia-390-modern-kernel.git

# Push
git push -u origin main
```

## Create Release

```bash
# Create tag
git tag -a v1.0.0 -m "Release v1.0.0

- Automated patch installation
- 50 patches applied
- Kernel 6.2-6.15+ support
- Tested on Ubuntu 24.04 + Kernel 6.8
- Tesla M2090 verified"

# Push tag
git push origin v1.0.0
```

## Repository Settings

### Topics (add these on GitHub)

```
nvidia, driver, linux, kernel, fermi, kepler, 
dkms, legacy-gpu, ubuntu, patches
```

### Enable

- ✅ Issues
- ✅ Discussions
- ❌ Wiki (optional)
- ❌ Projects (not needed)

## Post-Publication

### Test Installation

```bash
# Clone on fresh system
git clone https://github.com/aroldobossoni/nvidia-390-modern-kernel.git
cd nvidia-390-modern-kernel

# Download driver
wget https://us.download.nvidia.com/XFree86/Linux-x86_64/390.157/NVIDIA-Linux-x86_64-390.157.run

# Test installation
./install_nvidia_patches.sh
```

### Share

**Reddit:** r/linux, r/nvidia, r/Ubuntu  
**Forums:** NVIDIA Developer Forums, Ubuntu Forums  
**Arch Wiki:** Submit to legacy NVIDIA driver section

---

**Repository ready for publication!**
