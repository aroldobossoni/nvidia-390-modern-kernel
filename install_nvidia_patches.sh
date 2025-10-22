#!/bin/bash
# Automated NVIDIA 390.157 driver installation with RPM Fusion/ALT Linux patches
# Source: https://git.altlinux.org/gears/n/nvidia_glx_src_390.157.git

set -e

BASE_URL="https://git.altlinux.org/gears/n/nvidia_glx_src_390.157.git?p=nvidia_glx_src_390.157.git;a=blob_plain;f=rpmfusion"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PATCH_DIR="$SCRIPT_DIR/nvidia_patches"
KERNEL_DIR="$SCRIPT_DIR/NVIDIA-Linux-x86_64-390.157/kernel"
DRIVER_RUN="$SCRIPT_DIR/NVIDIA-Linux-x86_64-390.157.run"

# Create patch directory
mkdir -p "$PATCH_DIR"

echo "=========================================="
echo "Downloading patches from RPM Fusion/ALT Linux"
echo "=========================================="
echo ""

cd "$PATCH_DIR"

# Patch list from RPM Fusion
PATCH_FILES=(
    "do-div-cast.patch"
    "kernel-4.16%2B-memory-encryption.patch"
    "0018-backport-nv_install_notifier-changes-from-418.30.patch"
    "nvidia-390xx-kmod-0024-kernel-6.2-adaptation.patch"
    "nvidia-390xx-kmod-0025-kernel-6.3-adaptation.patch"
    "nvidia-390xx-kmod-0026-kernel-6.4-adaptation.patch"
    "nvidia-390xx-kmod-0027-kernel-6.5-garbage-collect-all-references-to-get_user.patch"
    "nvidia-390xx-kmod-0028-kernel-6.5-handle-get_user_pages-vmas-argument-remova.patch"
    "nvidia-390xx-kmod-0029-kernel-6.6-backport-drm_gem_prime_handle_to_fd-changes-from-470.patch"
    "nvidia-390xx-kmod-0030-kernel-6.6-refuse-to-load-legacy-module-if-IBT-is-enabled.patch"
    "nvidia-390xx-kmod-0031-kernel-6.8-adaptation.patch"
    "nvidia-390xx-kmod-0032-kernel-6.8-conftest_h-wait_on_bit_lock.patch"
    "nvidia-390xx-kmod-0033-kernel-5.6-ioremap_nocache_removed.patch"
    "nvidia-390xx-kmod-0034-kernel-5.9-dma_is_direct-removed.patch"
    "nvidia-390xx-kmod-0035-gcc14-no-previous-prototype-for-nv_load_dma_map_scatterlist.patch"
    "nvidia-390xx-kmod-0036-undef-NV_ACPI_BUS_GET_DEVICE_PRESENT-in-conftest_sh.patch"
    "nvidia-390xx-kmod-0037-add-RPM_CFLAGS-setup-in-conftest_sh.patch"
    "nvidia-390xx-kmod-0038-workaround-NV_EFI_ENABLED-macro.patch"
    "nvidia-390xx-kmod-0039-incompatible-function-type-nv_gpu_numa_c.patch"
    "nvidia-390xx-kmod-0040-fix-fallthrough-warning-nv_mmap_c.patch"
    "nvidia-390xx-kmod-0041-no-previous-prototype-for-exercise_error_forwarding_va.patch"
    "nvidia-390xx-kmod-0042-undef-NV_DO_GETTIMEOFDAY_PRESENT-in-conftest_sh.patch"
    "nvidia-390xx-kmod-0043-undef-NV_SET_MEMORY_ARRAY_UC_PRESENT-in-conftest_sh.patch"
    "nvidia-390xx-kmod-0044-undef-NV_ACQUIRE_CONSOLE_SEM_PRESENT-in-conftest_sh.patch"
    "nvidia-390xx-kmod-0045-undef-NV_UNSAFE_FOLLOW_PFN_PRESENT-in-conftest_sh.patch"
    "nvidia-390xx-kmod-0046-undef-NV_JIFFIES_TO_TIMESPEC_PRESENT-in-conftest_sh.patch"
    "nvidia-390xx-kmod-0047-undef-NV_PNV_NPU2_INIT_CONTEXT_PRESENT-in-conftest_sh.patch"
    "nvidia-390xx-kmod-0048-fix-atomic64-include-in-conftest_sh.patch"
    "nvidia-390xx-kmod-0049-fix-dma_buf_map-renamed-to-iosys_map.patch"
    "nvidia-390xx-kmod-0050-no-previous-prototype-for-nv_pci_register_driver.patch"
    "nvidia-390xx-kmod-0051-no-previous-prototype-for-nvidia_init_exit_module-in-nv_c.patch"
    "nvidia-390xx-kmod-0052-no-previous-prototype-for-on_nv_assert.patch"
    "nvidia-390xx-kmod-0053-no-previous-prototype-for-_raw_q_flush.patch"
    "nvidia-390xx-kmod-0054-no-previous-prototype-for-nv-ibmnpu-functions.patch"
    "nvidia-390xx-kmod-0055-no-previous-prototype-for-uvm_tools_init_exit.patch"
    "nvidia-390xx-kmod-0056-no-previous-prototype-for-uvm8_test_set_prefetch_filtering.patch"
    "nvidia-390xx-kmod-0057-no-previous-prototype-in-uvm8_va_space_c.patch"
    "nvidia-390xx-kmod-0058-no-previous-prototype-for-uvm_channel_manager_print_pending_pushes.patch"
    "nvidia-390xx-kmod-0059-no-previous-prototype-in-uvm8_va_range_c.patch"
    "nvidia-390xx-kmod-0060-no-previous-prototype-in-uvm8_range_group_c.patch"
    "nvidia-390xx-kmod-0061-no-previous-prototype-in-uvm8_gpu_replayable_faults_c.patch"
    "nvidia-390xx-kmod-0062-no-previous-prototype-for-block_map.patch"
    "nvidia-390xx-kmod-0063-no-previous-prototype-for-try_get_ptes.patch"
    "nvidia-390xx-kmod-0064-no-previous-prototype-in-uvm8_pushbuffer_c.patch"
    "nvidia-390xx-kmod-0065-no-previous-prototype-in-uvm8_kepler_mmu_c.patch"
    "nvidia-390xx-kmod-0066-no-previous-prototype-in-uvm8_pascal_mmu_c.patch"
    "nvidia-390xx-kmod-0067-no-previous-prototype-for-parse_fault_entry_common.patch"
    "nvidia-390xx-kmod-0068-no-previous-prototype-in-uvm8_volta_access_counter_buffer_c.patch"
    "nvidia-390xx-kmod-0069-no-previous-prototype-for-va_block_set_read_duplication_locked.patch"
    "nvidia-390xx-kmod-0070-no-previous-prototype-for-map_rm_pt_range.patch"
)

# Download all patches
for patch_name in "${PATCH_FILES[@]}"; do
    patch_name_decoded=$(echo "$patch_name" | sed 's/%2B/+/g')
    echo "Downloading: $patch_name_decoded"
    curl -s -o "$patch_name_decoded" "${BASE_URL}/${patch_name}"
done

echo ""
echo "✓ $(ls -1 *.patch 2>/dev/null | wc -l) patches downloaded"
echo ""

# Extract driver
echo "=========================================="
echo "Extracting clean driver..."
echo "=========================================="
echo ""

cd "$SCRIPT_DIR"

if [ -d "NVIDIA-Linux-x86_64-390.157" ]; then
    rm -rf NVIDIA-Linux-x86_64-390.157
fi

if [ ! -f "$DRIVER_RUN" ]; then
    echo "ERROR: NVIDIA-Linux-x86_64-390.157.run not found in current directory"
    echo "Download it first:"
    echo "  wget https://us.download.nvidia.com/XFree86/Linux-x86_64/390.157/NVIDIA-Linux-x86_64-390.157.run"
    exit 1
fi

./NVIDIA-Linux-x86_64-390.157.run --extract-only

echo "✓ Driver extracted"
echo ""

# Apply patches in order
echo "=========================================="
echo "Applying patches..."
echo "=========================================="
echo ""

cd "$KERNEL_DIR"

# Patch application order
PATCHES_ORDER=(
    "do-div-cast.patch"
    "kernel-4.16+-memory-encryption.patch"
    "0018-backport-nv_install_notifier-changes-from-418.30.patch"
    "nvidia-390xx-kmod-0024-kernel-6.2-adaptation.patch"
    "nvidia-390xx-kmod-0025-kernel-6.3-adaptation.patch"
    "nvidia-390xx-kmod-0026-kernel-6.4-adaptation.patch"
    "nvidia-390xx-kmod-0027-kernel-6.5-garbage-collect-all-references-to-get_user.patch"
    "nvidia-390xx-kmod-0028-kernel-6.5-handle-get_user_pages-vmas-argument-remova.patch"
    "nvidia-390xx-kmod-0029-kernel-6.6-backport-drm_gem_prime_handle_to_fd-changes-from-470.patch"
    "nvidia-390xx-kmod-0030-kernel-6.6-refuse-to-load-legacy-module-if-IBT-is-enabled.patch"
    "nvidia-390xx-kmod-0031-kernel-6.8-adaptation.patch"
    "nvidia-390xx-kmod-0032-kernel-6.8-conftest_h-wait_on_bit_lock.patch"
    "nvidia-390xx-kmod-0033-kernel-5.6-ioremap_nocache_removed.patch"
    "nvidia-390xx-kmod-0034-kernel-5.9-dma_is_direct-removed.patch"
    "nvidia-390xx-kmod-0035-gcc14-no-previous-prototype-for-nv_load_dma_map_scatterlist.patch"
    "nvidia-390xx-kmod-0036-undef-NV_ACPI_BUS_GET_DEVICE_PRESENT-in-conftest_sh.patch"
    "nvidia-390xx-kmod-0037-add-RPM_CFLAGS-setup-in-conftest_sh.patch"
    "nvidia-390xx-kmod-0038-workaround-NV_EFI_ENABLED-macro.patch"
    "nvidia-390xx-kmod-0039-incompatible-function-type-nv_gpu_numa_c.patch"
    "nvidia-390xx-kmod-0040-fix-fallthrough-warning-nv_mmap_c.patch"
    "nvidia-390xx-kmod-0041-no-previous-prototype-for-exercise_error_forwarding_va.patch"
    "nvidia-390xx-kmod-0042-undef-NV_DO_GETTIMEOFDAY_PRESENT-in-conftest_sh.patch"
    "nvidia-390xx-kmod-0043-undef-NV_SET_MEMORY_ARRAY_UC_PRESENT-in-conftest_sh.patch"
    "nvidia-390xx-kmod-0044-undef-NV_ACQUIRE_CONSOLE_SEM_PRESENT-in-conftest_sh.patch"
    "nvidia-390xx-kmod-0045-undef-NV_UNSAFE_FOLLOW_PFN_PRESENT-in-conftest_sh.patch"
    "nvidia-390xx-kmod-0046-undef-NV_JIFFIES_TO_TIMESPEC_PRESENT-in-conftest_sh.patch"
    "nvidia-390xx-kmod-0047-undef-NV_PNV_NPU2_INIT_CONTEXT_PRESENT-in-conftest_sh.patch"
    "nvidia-390xx-kmod-0048-fix-atomic64-include-in-conftest_sh.patch"
    "nvidia-390xx-kmod-0049-fix-dma_buf_map-renamed-to-iosys_map.patch"
    "nvidia-390xx-kmod-0050-no-previous-prototype-for-nv_pci_register_driver.patch"
    "nvidia-390xx-kmod-0051-no-previous-prototype-for-nvidia_init_exit_module-in-nv_c.patch"
    "nvidia-390xx-kmod-0052-no-previous-prototype-for-on_nv_assert.patch"
    "nvidia-390xx-kmod-0053-no-previous-prototype-for-_raw_q_flush.patch"
    "nvidia-390xx-kmod-0054-no-previous-prototype-for-nv-ibmnpu-functions.patch"
    "nvidia-390xx-kmod-0055-no-previous-prototype-for-uvm_tools_init_exit.patch"
    "nvidia-390xx-kmod-0056-no-previous-prototype-for-uvm8_test_set_prefetch_filtering.patch"
    "nvidia-390xx-kmod-0057-no-previous-prototype-in-uvm8_va_space_c.patch"
    "nvidia-390xx-kmod-0058-no-previous-prototype-for-uvm_channel_manager_print_pending_pushes.patch"
    "nvidia-390xx-kmod-0059-no-previous-prototype-in-uvm8_va_range_c.patch"
    "nvidia-390xx-kmod-0060-no-previous-prototype-in-uvm8_range_group_c.patch"
    "nvidia-390xx-kmod-0061-no-previous-prototype-in-uvm8_gpu_replayable_faults_c.patch"
    "nvidia-390xx-kmod-0062-no-previous-prototype-for-block_map.patch"
    "nvidia-390xx-kmod-0063-no-previous-prototype-for-try_get_ptes.patch"
    "nvidia-390xx-kmod-0064-no-previous-prototype-in-uvm8_pushbuffer_c.patch"
    "nvidia-390xx-kmod-0065-no-previous-prototype-in-uvm8_kepler_mmu_c.patch"
    "nvidia-390xx-kmod-0066-no-previous-prototype-in-uvm8_pascal_mmu_c.patch"
    "nvidia-390xx-kmod-0067-no-previous-prototype-for-parse_fault_entry_common.patch"
    "nvidia-390xx-kmod-0068-no-previous-prototype-in-uvm8_volta_access_counter_buffer_c.patch"
    "nvidia-390xx-kmod-0069-no-previous-prototype-for-va_block_set_read_duplication_locked.patch"
    "nvidia-390xx-kmod-0070-no-previous-prototype-for-map_rm_pt_range.patch"
)

PATCH_SUCCESS=0
PATCH_FAILED=0

for patch in "${PATCHES_ORDER[@]}"; do
    patch_path="$PATCH_DIR/$patch"
    
    if [ ! -f "$patch_path" ]; then
        echo "⚠️  Patch not found: $patch (skipping)"
        continue
    fi
    
    echo -n "Applying: $patch ... "
    
    if patch -p1 --forward --silent < "$patch_path" 2>/dev/null; then
        echo "✓"
        PATCH_SUCCESS=$((PATCH_SUCCESS + 1))
    else
        if patch -p1 --reverse --dry-run --silent < "$patch_path" 2>/dev/null; then
            echo "already applied"
        else
            echo "❌ FAILED"
            PATCH_FAILED=$((PATCH_FAILED + 1))
        fi
    fi
done

echo ""
echo "=========================================="
echo "Summary:"
echo "  ✓ Applied: $PATCH_SUCCESS"
echo "  ❌ Failed: $PATCH_FAILED"
echo "=========================================="
echo ""

if [ $PATCH_FAILED -eq 0 ]; then
    echo "🎉 All patches applied successfully!"
    echo ""
    echo "Next step:"
    echo "  cd NVIDIA-Linux-x86_64-390.157"
    echo "  sudo ./nvidia-installer --dkms --install-libglvnd"
else
    echo "⚠️  Some patches failed. Check errors above."
fi

