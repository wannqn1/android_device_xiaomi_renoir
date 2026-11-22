#!/bin/bash

DEVICE_PATH="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
FW_BASE="$DEVICE_PATH/../../../frameworks/base"

apply_renoir_build_patch() {
    local tree="$1"
    local patch="$DEVICE_PATH/patches/$2"
    if ! git -C "$tree" apply --reverse --check "$patch" 2>/dev/null; then
        git -C "$tree" apply "$patch"
    fi
}

apply_renoir_build_patch "$DEVICE_PATH/../../../vendor/lineage" \
    0003-Use-the-declared-Renoir-UAPI-outputs.patch || return 1
apply_renoir_build_patch "$DEVICE_PATH/../../../hardware/qcom-caf/sm8350/display" \
    0004-gralloc-Include-the-Qualcomm-DRM-modifiers.patch || return 1

# Apply 4G Icon patch to frameworks/base
if [ ! -f "$FW_BASE/.patch_applied_4g_icon" ]; then
    echo "Applying 4G icon patch to frameworks/base..."
    if git -C "$FW_BASE" apply "$DEVICE_PATH/patches/0001-telephony-Default-to-showing-4G-icon-instead-of-LTE.patch"; then
        touch "$FW_BASE/.patch_applied_4g_icon"
    else
        echo "Failed to apply 4G icon patch to frameworks/base."
    fi
else
    echo "4G icon patch already applied to frameworks/base."
fi

# Apply NFC Statusbar Icon patch to frameworks/base
if [ ! -f "$FW_BASE/.patch_applied_nfc_icon" ]; then
    echo "Applying NFC Statusbar Icon patch to frameworks/base..."
    if git -C "$FW_BASE" apply "$DEVICE_PATH/patches/0002-SystemUI-Add-status-bar-NFC-icon.patch"; then
        touch "$FW_BASE/.patch_applied_nfc_icon"
    else
        echo "Failed to apply NFC Statusbar Icon patch to frameworks/base."
    fi
else
    echo "NFC Statusbar Icon patch already applied to frameworks/base."
fi
