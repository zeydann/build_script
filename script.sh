#!/bin/bash

# Remove the local manifests directory if it exists (cleanup before repo initialization)
rm -rf .repo/local_manifests/

# remove device tree
rm -rf device/xiaomi/mojito
rm -rf device/xiaomi/sm6150-common
rm -rf kernel/xiaomi/mojito
rm -rf vendor/xiaomi/sm6150-common
rm -rf hardware/xiaomi

# Initialize ROM manifest
repo init -u https://github.com/RisingOS-Revived/android -b fifteen --git-lfs

# Sync the repo with force to ensure a clean sync
/opt/crave/resync.sh

# cloning device tree
git clone https://github.com/zeydann/android_device_xiaomi_mojito.git --depth 1 -b rising device/xiaomi/mojito
git clone https://github.com/zeydann/android_device_xiaomi_sm6150-common.git --depth 1 -b 15 device/xiaomi/sm6150-common

# cloning kernel tree
git clone https://github.com/zeydann/kernel_xiaomi_mojito.git --depth 1 -b 15 kernel/xiaomi/mojito

# cloning vendor tree
git clone https://gitlab.com/Sepidermn/android_vendor_xiaomi_mojito.git --depth 1 -b 15 vendor/xiaomi/mojito
git clone https://gitlab.com/Sepidermn/android_vendor_xiaomi_sm6150-common.git --depth 1 -b 15 vendor/xiaomi/sm6150-common

# cloning hardware tree
git clone https://github.com/zeydann/android_hardware_xiaomi.git --depth 1 -b rising hardware/xiaomi

# Export
export SELINUX_IGNORE_NEVERALLOWS=true

# Set up th build environment
. build/envsetup.sh

# Choose the target device
riseup mojito userdebug

# keys
gk -s

# Build the ROM (use mka bacon for a full build)
rise b
