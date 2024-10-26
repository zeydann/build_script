#!/bin/bash

# Remove the local manifests directory if it exists (cleanup before repo initialization)
rm -rf .repo/local_manifests/
# remove device
rm -rf device/xiaomi/mojito
rm -rf device/xiaomi/xiaomi/sm6150-common
# remove kernel
rm -rf kernel/xiaomi/mojito
# remove hardware
rm -rf hardware/xiaomi
# remove vendor
rm -rf vendor/xiaomi/mojito
rm -rf vendor/xiaomi/sm6150-common
# Initialize ROM manifest
repo init -u https://github.com/Project-Mist-OS/manifest -b qpr3 --git-lfs
# repo sync
/opt/crave/resync.sh
# cloning DT
# device tree
git clone https://github.com/Sepidermn/device_xiaomi_mojito.git --depth 1 -b mojito-universe device/xiaomi/mojito
git clone https://github.com/Sepidermn/android_device_xiaomi_sm6150-common.git --depth 1 -b mojito-universe device/xiaomi/sm6150-common
# kernel tree
git clone https://github.com/Sepidermn/kernel_xiaomi_mojito.git --depth 1 -b inline-rom kernel/xiaomi/mojito
# vendor tree
git clone https://gitlab.com/Sepidermn/android_vendor_xiaomi_mojito.git --depth 1 -b 14 vendor/xiaomi/mojito
git clone https://gitlab.com/Sepidermn/android_vendor_xiaomi_sm6150-common.git --depth 1 -b 14 vendor/xiaomi/sm6150-common
# hardware tree
git clone https://github.com/Sepidermn/android_hardware_xiaomi.git --depth 1 -b mojito hardware/xiaomi
# set build environment
. build/envsetup.sh
# lunch
lunch mist_mojito-user
# bacon
make bacon
