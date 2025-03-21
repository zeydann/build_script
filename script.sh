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
repo init -u https://github.com/AxionAOSP/android.git -b lineage-22.2 --git-lfs

# Sync the repo with force to ensure a clean sync
/opt/crave/resync.sh

# remove frameworks/native
 rm -rf frameworks/native

# cloning device tree
git clone https://github.com/zeydann/android_device_xiaomi_mojito.git --depth 1 -b axion device/xiaomi/mojito
git clone https://github.com/zeydann/android_device_xiaomi_sm6150-common.git --depth 1 -b test device/xiaomi/sm6150-common

# cloning kernel tree
git clone https://github.com/zeydann/kernel_xiaomi_mojito.git --depth 1 -b 15 kernel/xiaomi/mojito

# cloning vendor tree
git clone https://gitlab.com/Sepidermn/android_vendor_xiaomi_mojito.git --depth 1 -b 15 vendor/xiaomi/mojito
git clone https://gitlab.com/Sepidermn/android_vendor_xiaomi_sm6150-common.git --depth 1 -b 15 vendor/xiaomi/sm6150-common

# cloning hardware tree
git clone https://github.com/zeydann/android_hardware_xiaomi.git --depth 1 -b mojito hardware/xiaomi

# add modify
 git clone https://github.com/Kou-Yeager/android_frameworks_native.git --depth 1 -b 15 frameworks/native

# Export
export SELINUX_IGNORE_NEVERALLOWS=true

# Set up th build environment
. build/envsetup.sh

# keys
gk -s

# Choose the target device
axion mojito va

# full target
brunch mojito userdebug
