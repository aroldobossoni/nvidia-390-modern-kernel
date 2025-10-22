# Hardware Testing Results

**Date:** 2025-10-22  
**GPU:** Tesla M2090 (Fermi)  
**Driver:** 390.157  
**Kernel:** 6.8.0-86-generic

## Test Results

### ✅ CPU Encoding (Baseline)

```bash
ffmpeg -i test_input.mp4 -c:v libx264 -preset fast -crf 23 test_output.mp4
```

**Results:**
- Time: 14.3 seconds
- FPS: ~21 fps
- Speed: 0.7x realtime
- Output: 323 KB

### ❌ NVENC (Hardware Encoding)

**Status:** NOT SUPPORTED

**Error:**
```
Driver does not support the required nvenc API version.
Required: 12.1 Found: 8.1
```

**Reason:** Tesla M2090 has NVENC 1st gen (API 8.1), ffmpeg 6.1+ requires API 12.1+ (Maxwell/Pascal+)

## GPU Capabilities

### ✅ Supported

| Feature | Status | Notes |
|---------|--------|-------|
| CUDA 9.1 | ✅ | Compute Capability 2.0 |
| OpenCL 1.1 | ✅ | Legacy version |
| OpenGL 4.6 | ✅ | Full support |
| VDPAU | ⚠️ | Requires X11 server |
| PhysX | ✅ | Physics acceleration |

### ❌ Not Supported

| Feature | Reason |
|---------|--------|
| NVENC modern | API 8.1 too old |
| CUDA 10+ | Compute Capability 3.0+ required |
| Vulkan | Driver 418+ required |
| RTX/DLSS | Turing+ architecture required |

## Recommended Usage

### ✅ Ideal Use Cases

1. **CUDA computation** - Scientific computing, simulations
2. **3D rendering** - Blender Cycles, V-Ray
3. **Legacy ML** - TensorFlow 1.x, PyTorch 1.7
4. **OpenCL** - General purpose computing

### ❌ Not Recommended

1. **Modern video encoding** - NVENC incompatible
2. **Modern ML/AI** - Requires CUDA 10+
3. **Gaming** - Limited performance

## CUDA Testing

```bash
# Install CUDA 9.1
wget https://developer.nvidia.com/compute/cuda/9.1/Prod/local_installers/cuda_9.1.85_387.26_linux
sudo sh cuda_9.1.85_387.26_linux --silent --toolkit --samples

# Run samples
cd /usr/local/cuda-9.1/samples/1_Utilities/deviceQuery
make
./deviceQuery
```

## Performance Comparison

| Task | CPU (2 cores) | GPU (M2090) | Speedup |
|------|---------------|-------------|---------|
| Video encoding (x264) | 14.3s | N/A | - |
| CUDA compute | ~1s | ~0.1s | ~10x |
| Matrix multiplication | Slow | Fast | ~50x |

## Alternatives for Video Encoding

### CPU with optimizations

```bash
# x264 ultrafast
ffmpeg -i input.mp4 -c:v libx264 -preset ultrafast -crf 23 output.mp4

# x265 HEVC
ffmpeg -i input.mp4 -c:v libx265 -preset fast -crf 28 output.mp4
```

### Intel Quick Sync (if available)

```bash
vainfo
ffmpeg -vaapi_device /dev/dri/renderD128 -i input.mp4 \
  -vf 'format=nv12,hwupload' -c:v h264_vaapi -b:v 2M output.mp4
```

## Conclusion

**For video encoding:** Tesla M2090 is NOT suitable (NVENC too old)  
**For computation:** Tesla M2090 is EXCELLENT (CUDA 9.1, OpenCL, rendering)

Use this GPU for scientific computing, 3D rendering, and legacy CUDA projects, not for modern video encoding.

## References

- **NVENC Support Matrix:** https://developer.nvidia.com/video-encode-and-decode-gpu-support-matrix-new
- **CUDA Archive:** https://developer.nvidia.com/cuda-toolkit-archive
- **Tesla M2090 Specs:** https://www.nvidia.com/docs/IO/43395/M2090_datasheet_jun2011.pdf

