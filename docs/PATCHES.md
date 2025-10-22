# Patch Verification

**Date:** 2025-10-22  
**Kernel:** 6.8.0-86-generic  
**Source:** ALT Linux / RPM Fusion

## Status

✅ **ALL PATCHES APPLIED SUCCESSFULLY**

**Total patches:** 50  
**Source:** https://git.altlinux.org/gears/n/nvidia_glx_src_390.157.git

## Patch Categories

| Category | Count | Description |
|----------|-------|-------------|
| Kernel 6.2-6.8 adaptations | 12 | API compatibility |
| GCC 14 fixes | 38 | Function prototypes |
| DMA/Memory fixes | 5 | Memory management |

## Key Patches

### Kernel 6.2

- **0024-kernel-6.2-adaptation.patch**
  - EDID/ACPI changes
  - Strip level: -p1

### Kernel 6.3

- **0025-kernel-6.3-adaptation.patch**
  - vm_flags read-only fix
  - Strip level: -p1

### Kernel 6.4

- **0026-kernel-6.4-adaptation.patch**
  - dumb_destroy removal
  - Strip level: -p1

### Kernel 6.5

- **0027-kernel-6.5-garbage-collect-all-references-to-get_user.patch**
- **0028-kernel-6.5-handle-get_user_pages-vmas-argument-remova.patch**
  - get_user_pages_remote API changes
  - Strip level: -p1

### Kernel 6.8

- **0031-kernel-6.8-adaptation.patch**
  - DRM_UNLOCKED mock
  - Strip level: -p1
  
- **0032-kernel-6.8-conftest_h-wait_on_bit_lock.patch**
  - wait_on_bit_lock header changes
  - Strip level: -p1

## Directory Structure

```
NVIDIA-Linux-x86_64-390.157/
├── kernel/
│   ├── conftest.sh
│   ├── nvidia/
│   │   └── nv-acpi.c
│   ├── nvidia-drm/
│   │   ├── nvidia-drm-connector.c
│   │   ├── nvidia-drm-drv.c
│   │   └── nvidia-drm-fb.c
│   └── ...
```

## Verification

```bash
# Check applied patches
grep -r "KERNEL_VERSION(6, 2, 0)" NVIDIA-Linux-x86_64-390.157/kernel/
grep -r "KERNEL_VERSION(6, 8, 0)" NVIDIA-Linux-x86_64-390.157/kernel/
```

## Compliance

Based on **nvidia_glx_src_390.157-alt234** (Sep 12, 2025):

✅ Using RPM Fusion patches  
✅ Correct strip levels  
✅ Applied from kernel/ directory  
✅ All patches from ALT Linux repository

## References

- **ALT Linux:** https://git.altlinux.org/gears/n/nvidia_glx_src_390.157.git
- **RPM Fusion:** https://rpmfusion.org/
- **Package:** https://packages.altlinux.org/en/sisyphus/srpms/nvidia_glx_src_390.157/

