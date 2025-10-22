# Quick Start Guide

Install NVIDIA 390.157 on modern Linux kernels in 5 minutes.

## 1. Prerequisites

```bash
# Check kernel (need 6.2+)
uname -r

# Install required packages
sudo apt-get update
sudo apt-get install -y build-essential dkms linux-headers-$(uname -r) \
    pkg-config libglvnd-dev curl
```

## 2. Installation

```bash
# Download driver
wget https://us.download.nvidia.com/XFree86/Linux-x86_64/390.157/NVIDIA-Linux-x86_64-390.157.run

# Run installer
chmod +x install_nvidia_patches.sh
./install_nvidia_patches.sh

# Reboot
sudo reboot
```

## 3. Verification

```bash
nvidia-smi
```

**Expected output:**
```
NVIDIA-SMI 390.157        Driver Version: 390.157
GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC
...
```

## Troubleshooting

### Installation failed?

```bash
sudo tail -50 /var/lib/dkms/nvidia/390.157/build/make.log
```

### Driver not loading?

```bash
# Blacklist nouveau
echo "blacklist nouveau" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
sudo update-initramfs -u
sudo reboot
```

## Supported Hardware

**Fermi (2010-2012):** Tesla M2090/M2070, GTX 480/580/470/460  
**Kepler (2012-2014):** Tesla K80/K40/K20, GTX 780/770/760/680/670/660

[Full compatibility list](https://www.nvidia.com/Download/driverResults.aspx/122150/)

## Next Steps

### CUDA Development

```bash
wget https://developer.nvidia.com/compute/cuda/9.1/Prod/local_installers/cuda_9.1.85_387.26_linux
sudo sh cuda_9.1.85_387.26_linux --silent --toolkit --samples
```

### GPU Monitoring

```bash
watch -n1 nvidia-smi
```

---

**Installation time:** ~5 minutes  
**Supported kernels:** 6.2 - 6.15+
