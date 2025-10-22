# Installation Summary

**Date:** 2025-10-22  
**System:** Ubuntu 24.04.3 LTS, Kernel 6.8.0-86-generic  
**GPU:** Tesla M2090 (Fermi)  
**Status:** ✅ Successfully installed

## Driver Info

```
NVIDIA-SMI 390.157
Driver Version: 390.157
CUDA Version: 9.1
```

## GPU Details

| Parameter | Value |
|-----------|-------|
| Model | Tesla M2090 |
| Memory | 6067 MiB |
| Architecture | Fermi (Compute Capability 2.0) |
| PCI Bus | 00000000:01:00.0 |
| Power | 81W |

## Loaded Modules

- **nvidia** (15.9 MB) - Main driver
- **nvidia_modeset** (1.0 MB) - DRM modesetting
- **nvidia_drm** (61 KB) - DRM/KMS support

## Installation Challenge

NVIDIA 390.157 doesn't compile natively on kernel 6.8+ due to kernel API changes.

## Solution

Applied **50 patches** from **RPM Fusion/ALT Linux**:

1. **Kernel 6.2+**: EDID/ACPI adaptations
2. **Kernel 6.3+**: vm_flags read-only
3. **Kernel 6.4+**: dumb_destroy removed
4. **Kernel 6.5+**: get_user_pages_remote changes
5. **Kernel 6.6+**: drm_gem_prime changes
6. **Kernel 6.8+**: DRM_UNLOCKED, wait_on_bit_lock
7. **GCC 14+**: Function prototypes

**Source:** https://git.altlinux.org/gears/n/nvidia_glx_src_390.157.git

## Installation Method

```bash
# Download driver
wget https://us.download.nvidia.com/XFree86/Linux-x86_64/390.157/NVIDIA-Linux-x86_64-390.157.run

# Apply patches and install
./install_nvidia_patches.sh
cd NVIDIA-Linux-x86_64-390.157
sudo ./nvidia-installer --dkms --install-libglvnd

# Reboot
sudo reboot
```

## Maintenance

### Kernel Updates

Driver registered with **DKMS** - automatically recompiles on kernel updates.

### Verification

```bash
nvidia-smi
lsmod | grep nvidia
dmesg | grep -i nvidia
dkms status nvidia
```

### Troubleshooting

```bash
# Check logs
sudo tail -100 /var/lib/dkms/nvidia/390.157/build/make.log

# Rebuild
sudo dkms remove nvidia/390.157 --all
cd NVIDIA-Linux-x86_64-390.157
sudo ./nvidia-installer --dkms
```

## Supported Features

| Feature | Status |
|---------|--------|
| CUDA 9.1 | ✅ |
| OpenGL 4.6 | ✅ |
| OpenCL 1.1 | ✅ |
| VDPAU decode | ✅ |
| Multi-GPU | ✅ |
| CUDA 10+ | ❌ |
| Vulkan | ❌ |
| NVENC modern | ❌ |

## References

- **Driver:** https://www.nvidia.com/Download/index.aspx
- **Patches:** https://git.altlinux.org/gears/n/nvidia_glx_src_390.157.git
- **RPM Fusion:** https://rpmfusion.org/

---

✅ **Installation successful on Ubuntu 24.04 with kernel 6.8**

