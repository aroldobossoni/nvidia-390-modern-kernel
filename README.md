# NVIDIA 390.157 Driver for Modern Linux Kernels

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Kernel](https://img.shields.io/badge/Kernel-6.2--6.15%2B-blue.svg)](https://kernel.org/)
[![Driver](https://img.shields.io/badge/Driver-390.157-green.svg)](https://www.nvidia.com/Download/index.aspx)

Automated NVIDIA 390.157 driver installation for modern Linux kernels with comprehensive community patches.

## Quick Start

```bash
# Clone repository
git clone https://github.com/aroldobossoni/nvidia-390-modern-kernel.git
cd nvidia-390-modern-kernel

# Download driver
wget https://us.download.nvidia.com/XFree86/Linux-x86_64/390.157/NVIDIA-Linux-x86_64-390.157.run

# Run installer
chmod +x install_nvidia_patches.sh
./install_nvidia_patches.sh

# Reboot
sudo reboot

# Verify
nvidia-smi
```

## Compatibility

**Tested:** Ubuntu 24.04 LTS, Kernel 6.8.0-86, Tesla M2090 (Fermi)  
**Supported:** All Fermi/Kepler GPUs (GTX 400-700 series, Tesla K/M-series)  
**Kernels:** 6.2 through 6.15+

[Full GPU compatibility list](https://www.nvidia.com/Download/driverResults.aspx/122150/)

## Prerequisites

```bash
sudo apt-get update
sudo apt-get install -y build-essential dkms linux-headers-$(uname -r) \
    pkg-config libglvnd-dev curl
```

## What It Does

1. Downloads 80+ patches from RPM Fusion/ALT Linux
2. Extracts NVIDIA 390.157 driver
3. Applies 50 patches for kernel 6.2-6.15+ compatibility
4. Installs with DKMS for automatic kernel updates
5. Configures OpenGL/CUDA support

## Features

| Feature | Status | Notes |
|---------|--------|-------|
| CUDA 9.1 | ✅ | Compute Capability 2.0+ |
| OpenGL 4.6 | ✅ | Full support |
| VDPAU | ✅ | Video decode (H.264, MPEG-2) |
| DKMS | ✅ | Auto-rebuild on kernel updates |
| NVENC modern | ❌ | API 8.1 too old (requires 12.1+) |
| Vulkan | ❌ | Requires driver 418+ |

## Documentation

- **[QUICKSTART.md](QUICKSTART.md)** - 5-minute setup guide
- **[docs/INSTALLATION.md](docs/INSTALLATION.md)** - Installation summary
- **[docs/PATCHES.md](docs/PATCHES.md)** - Patch verification details
- **[docs/TESTING.md](docs/TESTING.md)** - Hardware testing results

## Troubleshooting

```bash
# Check logs
sudo tail -100 /var/lib/dkms/nvidia/390.157/build/make.log

# Rebuild driver
sudo dkms remove nvidia/390.157 --all
./install_nvidia_patches.sh

# Blacklist nouveau
echo "blacklist nouveau" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
sudo update-initramfs -u
```

## Credits

- **[RPM Fusion](https://rpmfusion.org/)** - Patch development
- **[ALT Linux](https://git.altlinux.org/)** - Patch hosting
- **Nicolas Viéville** - Kernel 6.2-6.8 adaptations

## License

MIT License - See [LICENSE](LICENSE) file.

NVIDIA driver is proprietary software subject to NVIDIA's EULA.

---

**Issues?** Open an issue with GPU model, kernel version, and error logs.
