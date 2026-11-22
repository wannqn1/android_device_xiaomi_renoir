#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/renoir

TARGET_RENOIR_KERNEL_618 := true
$(call soong_config_set_bool,xiaomi_sm8350,use_renoir_ssccalapi,true)

# Inherit from sm8350-common
include device/xiaomi/sm8350-common/BoardConfigCommon.mk

# Board
TARGET_BOOTLOADER_BOARD_NAME := renoir

# HIDL
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/hidl/manifest.xml

# The kernel builder deposits a matched set here.
RENOIR_KERNEL_PREBUILTS := device/xiaomi/renoir-kernel-6.18
# Export the matched UAPI to Qualcomm HALs through LineageOS's headers_install rule.
TARGET_KERNEL_SOURCE := $(RENOIR_KERNEL_PREBUILTS)/headers
TARGET_KERNEL_VERSION := 6.18
TARGET_NO_KERNEL_OVERRIDE := true
BOARD_PREBUILT_DTBOIMAGE := $(RENOIR_KERNEL_PREBUILTS)/dtbo.img
BOARD_PREBUILT_DTBIMAGE_DIR := $(RENOIR_KERNEL_PREBUILTS)/dtb

BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(RENOIR_KERNEL_PREBUILTS)/vendor_ramdisk/*.ko)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(RENOIR_KERNEL_PREBUILTS)/vendor_ramdisk/modules.load 2>/dev/null))
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD)
BOARD_DO_NOT_STRIP_VENDOR_RAMDISK_MODULES := true
BOARD_RAMDISK_USE_LZ4 := true

BOARD_KERNEL_CMDLINE += binder.impl=rust
BOARD_KERNEL_CMDLINE += iommu.strict=1
BOARD_KERNEL_CMDLINE += clk_ignore_unused pd_ignore_unused
BOARD_KERNEL_CMDLINE += deferred_probe_timeout=30 fw_devlink.sync_state=timeout

# SELinux
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# Partitions
BOARD_DTBOIMG_PARTITION_SIZE := 25165824

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Include proprietary files
include vendor/xiaomi/renoir/BoardConfigVendor.mk
