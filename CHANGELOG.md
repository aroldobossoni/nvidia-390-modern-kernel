# Changelog

All notable changes documented here.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [1.0.0] - 2025-10-22

### Added

- Automated installation script (`install_nvidia_patches.sh`)
- 50 patches from ALT Linux/RPM Fusion
- Kernel 6.2-6.8 compatibility
- Kernel 6.12-6.15 support
- GCC 14 fixes (38 patches)
- DKMS integration
- Professional documentation

### Tested

- **Hardware:** NVIDIA Tesla M2090 (Fermi)
- **OS:** Ubuntu 24.04.3 LTS
- **Kernel:** 6.8.0-86-generic
- **GCC:** 13.3.0
- **Driver:** 390.157
- **CUDA:** 9.1 compatible

### Fixed

- Kernel 6.2+ compilation errors
- Kernel 6.3+ vm_flags issues
- Kernel 6.4+ DRM API changes
- Kernel 6.5+ memory management
- Kernel 6.8+ DRM locking
- GCC 14 prototype warnings

## Compatibility Matrix

| Kernel | Status | Patches | Notes |
|--------|--------|---------|-------|
| 6.2-6.3 | ✅ Tested | 12 | EDID, ACPI, vm_flags |
| 6.4-6.5 | ✅ Tested | 15 | DRM, get_user_pages |
| 6.6-6.7 | ✅ Verified | 18 | GEM, IBT |
| 6.8 | ✅ Tested | 20 | Full test suite |
| 6.9-6.11 | ⚠️ Expected | 20 | Should work |
| 6.12-6.15 | ⚠️ Community | 25 | Patches available |
| 6.16+ | ❓ Unknown | TBD | May need updates |

## GPU Compatibility

| GPU Series | Architecture | Status |
|------------|--------------|--------|
| Tesla M-series | Fermi | ✅ Tested |
| GTX 400/500 | Fermi | ✅ Expected |
| GTX 600/700 | Kepler | ✅ Expected |
| Tesla K-series | Kepler | ✅ Expected |

## Known Issues

### Current

- **NVENC unavailable:** Tesla M2090 has API 8.1 (ffmpeg needs 12.1+)
- **X11 required for VDPAU:** Headless servers can't use hardware decode

### Resolved

- ✅ Kernel 6.8 compilation (v1.0.0)
- ✅ GCC 14 warnings (v1.0.0)
- ✅ DKMS integration (v1.0.0)
- ✅ vm_flags read-only (v1.0.0)

## Patch Sources

- **[ALT Linux](https://git.altlinux.org/gears/n/nvidia_glx_src_390.157.git)** - Primary source
- **[RPM Fusion](https://rpmfusion.org/)** - Original development
- **Nicolas Viéville** - Kernel 6.2-6.8 adaptations

---

**Last Updated:** 2025-10-22
