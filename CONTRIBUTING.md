# Contributing Guidelines

Contributions welcome! Help keep legacy NVIDIA GPUs working on modern kernels.

## Reporting Issues

Include:

```
GPU Model: Tesla M2090 / GTX 680 / etc.
Driver: 390.157
Kernel: 6.8.0-86-generic (uname -r)
Distribution: Ubuntu 24.04 / Debian 12 / etc.
Error: [paste full error]
Logs: /var/lib/dkms/nvidia/390.157/build/make.log
```

## Testing New Kernels

1. Run with verbose output
2. Document new patches needed
3. Report success/failure with logs
4. Submit PR with patch updates

## Adding Patches

1. Test on hardware
2. Document source (git commit URL)
3. Add to `install_nvidia_patches.sh`
4. Update README with description
5. Submit PR with test results

## Testing Before PR

```bash
# Clean install
./install_nvidia_patches.sh

# Verify
nvidia-smi
lsmod | grep nvidia

# Reboot test
sudo reboot
nvidia-smi
```

## Pull Request Process

1. Fork repository
2. Create branch: `git checkout -b feature/kernel-6.10-support`
3. Test thoroughly
4. Update documentation
5. Push: `git push origin feature/kernel-6.10-support`
6. Open PR with:
   - Description
   - Hardware tested
   - Kernel version
   - Before/after logs

## PR Checklist

- [ ] Tested on real hardware
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] No sensitive data
- [ ] Scripts executable
- [ ] Clear commit messages

## Finding Patches

**RPM Fusion:**
```bash
git clone https://github.com/rpmfusion/xorg-x11-drv-nvidia-390xx
ls *.patch
```

**ALT Linux:**
```
https://git.altlinux.org/gears/n/nvidia_glx_src_390.157.git
```

**Arch AUR:**
```
https://aur.archlinux.org/packages/nvidia-390xx-dkms
```

## License

By contributing, you agree contributions will be licensed under MIT License.

---

**Thank you for helping keep legacy GPUs alive!**
