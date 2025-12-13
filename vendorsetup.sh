#!/bin/bash

# Vendor (fresh clone)
echo "Cloning vendor tree..."
rm -rf vendor/xiaomi/peridot
git clone -b lineage-23.0 https://github.com/droidcore/vendor_xiaomi_peridot_blu.git vendor/xiaomi/peridot

# Kernel source (fresh clone)
echo "Cloning kernel source tree..."
rm -rf kernel/xiaomi/sm8635
git clone -b lineage-23.0 --depth 1 https://github.com/droidcore/android_kernel_xiaomi_sm8635.git kernel/xiaomi/sm8635
rm -rf kernel/xiaomi/sm8635-modules
git clone -b lineage-23.1 --depth 1 https://github.com/sm8635-dev/kernel_xiaomi_sm8635-modules.git kernel/xiaomi/sm8635-modules

rm -rf kernel/xiaomi/sm8635-devicetrees
git clone -b lineage-23.0 --depth 1 https://github.com/droidcore/android_kernel_xiaomi_sm8635-devicetrees.git kernel/xiaomi/sm8635-devicetrees

# Hardware xiaomi (fresh clone)
echo "Cloning hardware xiaomi source..."
rm -rf hardware/xiaomi
git clone -b lineage-23.0 https://github.com/droidcore/hardware_xiaomi.git hardware/xiaomi

# MiuiCamera device tree (fresh clone)
echo "Cloning MiuiCamera device tree..."
rm -rf device/xiaomi/peridot-miuicamera
git clone https://github.com/F6-test/device_xiaomi_peridot-miuicamera.git device/xiaomi/peridot-miuicamera

# MiuiCamera vendor tree (fresh clone)
echo "Cloning MiuiCamera vendor tree..."
rm -rf vendor/xiaomi/peridot-miuicamera
git clone https://github.com/F6-test/vendor-xiaomi-peridot-miuicamera.git vendor/xiaomi/peridot-miuicamera

# Viper4Android 
echo "Cloning Viper4Android tree..."
rm -rf packages/apps/ViPER4AndroidFX
git clone https://github.com/TogoFire/packages_apps_ViPER4AndroidFX.git packages/apps/ViPER4AndroidFX

# KProfiles (fresh clone)
echo "Cloning KProfiles..."
rm -rf packages/apps/KProfiles
git clone -b lineage-23.1 https://github.com/sm8635-dev/packages_apps_KProfiles.git packages/apps/KProfiles

# Gamebar
echo "Cloning Gamebar tree..."
rm -rf packages/apps/GameBar
git clone https://github.com/droidcore/packages_apps_GameBar.git packages/apps/GameBar

# Packages Apps Settings
echo "Cloning Custom Apps Settings tree..."
rm -rf packages/apps/Settings
git clone https://github.com/droidcore/packages_apps_Settings.git packages/apps/Settings

# system sepolicy 
echo "Cloning Custom system sepolicy tree..."
rm -rf system/sepolicy
git clone https://github.com/droidcore/system_sepolicy.git system/sepolicy

echo "Fetching kernel tree..."
cd kernel/xiaomi/sm8635
git fetch https://github.com/droidcore/android_kernel_xiaomi_sm8635.git lineage-23.0
git reset --hard beb37e0cabdd249215e338cba4b7b398f25021b3
croot

echo "Fetching QPR1 compat..."
cd kernel/xiaomi/sm8635-devicetrees
git fetch https://github.com/droidcore/android_kernel_xiaomi_sm8635-devicetrees.git lineage-23.0
git reset --hard e903a7600fdbb1ebd64256a0ebfafab55e853faf
croot

# Refresh signing keys
if [ -d vendor/lineage-priv/keys ]; then
  echo "Removing existing signing keys..."
  rm -rf vendor/lineage-priv/keys
fi
echo "Cloning fresh signing keys..."
git clone https://github.com/droidcore/private_key.git -b main vendor/lineage-priv/keys

# Always back to root at the end
if command -v croot &>/dev/null; then
  croot
else
  cd "$ANDROID_BUILD_TOP" || true
fi

echo "vendorsetup.sh execution complete."
