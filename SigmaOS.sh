#!/bin/bash

# Remove the local manifests directory if it exists (cleanup before repo initialization)
rm -rf .repo/local_manifests/
# Initialize ROM manifest
repo init -u https://github.com/sigmadroid-project/manifest -b sigma-14.3 --git-lfs
# repo ync
/opt/crave/resync.sh
# cloning DT
# device tree
git clone https://github.com/Sepidermn/device_xiaomi_mojito.git --depth 1 -b mojito-universe device/xiaomi/mojito
git clone https://github.com/MatrixxOS9/android_device_xiaomi_sm6150-common.git --depth 1-b mojito-universe device/xiaomi/sm6150-common
# kernel tree
git clone https://github.com/Sepidermn/kernel_xiaomi_mojito.git --depth 1 -b inline-rom kernel/xiaomi/mojito
# vendor tree
git clone https://gitlab.com/Sepidermn/android_vendor_xiaomi_mojito.git--depth 1 -b 14 vendor/xiaomi/mojito
git clone https://gitlab.com/Sepidermn/android_vendor_xiaomi_sm6150-common.git --depth 1 -b 14 vendor/xiaomi/sm6150-common
# hardware tree
git clone https://github.com/MatrixxOS9/android_hardware_xiaomi.git --depth 1 - mojito hardware/xiaomi
# set build environment
. build/envsetup.sh
# lunch
lunch sigma_mojito-ap2a-userdebug
# bacon
make bacon
