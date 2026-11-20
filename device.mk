#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Omit Dolby integration from the initial renoir build.
TARGET_INCLUDES_DOLBY := false

# Install the Tempest perf tables before the inherited Qualcomm defaults.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/perf/perfboostsconfig.xml:$(TARGET_COPY_OUT_VENDOR)/etc/perf/perfboostsconfig.xml \
    $(LOCAL_PATH)/configs/perf/targetresourceconfigs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/perf/targetresourceconfigs.xml

# Inherit from sm8350-common
$(call inherit-product, device/xiaomi/sm8350-common/common.mk)

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_platform_info_shimaidp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_shima/audio_platform_info_shimaidp.xml \
    $(LOCAL_PATH)/audio/mixer_paths_shimaidp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_shima/mixer_paths_shimaidp.xml \
    $(LOCAL_PATH)/audio/mixer_paths_overlay_dynamic.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_shima/mixer_paths_overlay_dynamic.xml \
    $(LOCAL_PATH)/audio/mixer_paths_overlay_static.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_shima/mixer_paths_overlay_static.xml \
    $(LOCAL_PATH)/audio/sound_trigger_mixer_paths_shimaidp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_shima/sound_trigger_mixer_paths_shimaidp.xml \
    $(LOCAL_PATH)/audio/sound_trigger_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_shima/sound_trigger_platform_info.xml

PRODUCT_SYSTEM_PROPERTIES += \
    ro.miui.notch=1 \
    ro.product.mod_device=renoir_global

# Kernel
PRODUCT_COPY_FILES += device/xiaomi/renoir-kernel-6.18/Image:kernel
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

# NFC
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/nfc/libnfc-nci.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nci.conf \
    $(LOCAL_PATH)/nfc/libnfc-nxp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nxp.conf \
    $(LOCAL_PATH)/nfc/libnfc-nxp_RF.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nxp_RF.conf

# Overlays
PRODUCT_PACKAGES += \
    ApertureOverlayRenoir \
    NfcOverlayRenoir

PRODUCT_PACKAGES += \
    FrameworkOverlayRenoir \
    SettingsOverlayRenoir \
    SettingsProviderOverlayRenoir \
    SystemUIOverlayRenoir \
    WifiOverlayRenoir

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Vibrator
$(call soong_config_set,qti_vibrator,effect_lib,libqtivibratoreffect.xiaomi)
$(call soong_config_set_bool,qti_vibrator,use_effect_stream,true)

# Call the proprietary setup
$(call inherit-product, vendor/xiaomi/renoir/renoir-vendor.mk)
