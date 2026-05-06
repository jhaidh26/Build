#!/bin/bash

# Infinity-X 3.10 (Android 16) Build Script for OnePlus 7T (hotdogb)

set -e

# Setup bin directory
mkdir -p ~/bin
export PATH="$HOME/bin:$PATH"

# Download repo tool
if [ ! -f ~/bin/repo ]; then
    curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
    chmod a+x ~/bin/repo
fi

# Configure Git
git config --global user.name "jhaidh277"
git config --global user.email "jhaidh277@gmail.com"

# Initialize ROM Source
echo "Initializing ROM Source..."
repo init -u https://github.com/ProjectInfinity-X/manifest.git -b 16 --depth=1

# Sync Source
echo "Syncing Source (this will take a long time and requires ~150GB+ space)..."
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# Clone Device Specific Trees
echo "Cloning Device, Vendor, and Kernel Trees..."
git clone https://github.com/Infinity-X-Devices/device_oneplus_hotdogb.git -b 16 device/oneplus/hotdogb
git clone https://github.com/Infinity-X-Devices/vendor_oneplus_hotdogb.git -b 16 vendor/oneplus/hotdogb
git clone https://github.com/Infinity-X-Devices/kernel_oneplus_sm8150.git -b 16 kernel/oneplus/sm8150

# Setup Environment and Build
echo "Starting Build..."
source build/envsetup.sh
lunch infinity_hotdogb-userdebug
mka bacon
