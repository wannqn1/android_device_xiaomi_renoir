Copyright (C) 2021 The LineageOS Project

Device configuration for Xiaomi Mi 11 Lite 5G
=========================================

The Xiaomi Mi 11 Lite 5G (codenamed _"renoir"_) is a mid-range smartphone from Xiaomi.

It was released in April 2021.

## Device specifications

Basic   | Spec Sheet
-------:|:-------------------------
CPU     | Kryo 670, Up to 2.4 GHz, Octa-core CPU
Chipset | Qualcomm Snapdragon 780G 5G (SM7350-AB)
GPU     | Adreno 642
Memory  | 6/8 GB, LPDDR4X
Storage | 128 GB, UFS 2.2
Shipped Android Version | 11
Battery | Non-removable 4250 mAh
Display | 2400 x 1080 pixels, 6.55 inches
Camera  | 64 MP main, 8 MP ultra-wide angle, 5 MP telemacro, 20 MP front

## Device picture

![Xiaomi Mi 11 Lite 5G](https://i01.appmifile.com/webfile/globalimg/products/pc/mi-11-lite-5g/specs01.png "Xiaomi Mi 11 Lite 5G")

## LineageOS 24.0 with Linux 6.18

This branch targets the Xiaomi Mi 11 Lite 5G (renoir, SM7350). The baseline
product builds with Aperture and excludes BCR, MIUI Camera, and Dolby.

From a fresh Android source directory on a Linux filesystem, with Repo and
Git LFS installed:

```sh
repo init -u https://github.com/LineageOS/android.git -b lineage-24.0 --depth=1 --git-lfs
mkdir -p .repo/local_manifests
curl -fLS https://raw.githubusercontent.com/wannqn1/android_device_xiaomi_renoir/renoir-6.18/renoir.xml \
    -o .repo/local_manifests/renoir.xml
repo sync -c --no-tags -j4
git -C vendor/xiaomi/renoir lfs pull
source build/envsetup.sh
breakfast renoir userdebug
m -j2 bacon
```

The manifest supplies the vendor blobs and firmware and the matched
kernel Image, DTB, DTBO, and matching modules. Build output goes to
`out/target/product/renoir/`.

Kernel sources are available in the [Shima kernel](https://github.com/wannqn1/android_kernel_xiaomi_sm7350),
[device trees](https://github.com/wannqn1/android_kernel_xiaomi_sm7350-devicetrees)
and [external modules](https://github.com/wannqn1/android_kernel_xiaomi_sm7350-modules)
repositories on `renoir-6.18`. Rebuild the Image, DT files and modules together
when updating the kernel package.

The kernel package passed build and dependency checks. The complete Android
build and boot on renoir still need verification.
