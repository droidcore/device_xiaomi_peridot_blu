#!/bin/bash

# Vendor (fresh clone)
echo "Cloning vendor tree..."
rm -rf vendor/xiaomi/peridot
git clone -b lineage-23.0 https://github.com/sm8635-dev/vendor_xiaomi_peridot.git vendor/xiaomi/peridot

# Kernel source (fresh clone)
echo "Cloning kernel source tree..."
rm -rf kernel/xiaomi/sm8635
git clone -b lineage-23.0 --depth 1 https://github.com/sm8635-dev/kernel_xiaomi_sm8635.git kernel/xiaomi/sm8635

rm -rf kernel/xiaomi/sm8635-modules
git clone -b lineage-23.0 https://github.com/sm8635-dev/kernel_xiaomi_sm8635-modules.git kernel/xiaomi/sm8635-modules

rm -rf kernel/xiaomi/sm8635-devicetrees
git clone -b lineage-23.0 https://github.com/sm8635-dev/kernel_xiaomi_sm8635-devicetrees.git kernel/xiaomi/sm8635-devicetrees

# MiuiCamera device tree (fresh clone)
echo "Cloning MiuiCamera device tree..."
rm -rf device/xiaomi/peridot-miuicamera
git clone https://github.com/sm8635-dev/device_xiaomi_peridot-miuicamera.git device/xiaomi/peridot-miuicamera

# MiuiCamera vendor tree (fresh clone)
echo "Cloning MiuiCamera vendor tree..."
rm -rf vendor/xiaomi/peridot-miuicamera
git clone https://github.com/sm8635-dev/vendor_xiaomi_peridot-miuicamera.git vendor/xiaomi/peridot-miuicamera

# Hardware xiaomi (fresh clone)
echo "Cloning hardware xiaomi source..."
rm -rf hardware/xiaomi
git clone -b lineage-23.0 https://github.com/sm8635-dev/hardware_xiaomi.git hardware/xiaomi

# KProfiles (fresh clone)
echo "Cloning KProfiles..."
rm -rf packages/apps/KProfiles
git clone -b lineage-23.0 https://github.com/sm8635-dev/packages_apps_KProfiles.git packages/apps/KProfiles

# Refresh signing keys
echo "Refreshing signing keys in vendor/evolution-priv/keys..."

mkdir -p vendor/evolution-priv

if [ -d vendor/evolution-priv/keys ]; then
  echo "Removing existing signing keys..."
  rm -rf vendor/evolution-priv/keys
fi

echo "Cloning fresh signing keys..."
git clone -b evox-keys https://github.com/Neon-Duchamp/keys.git vendor/evolution-priv/keys

# Always back to root at the end
if command -v croot &>/dev/null; then
  croot
else
  cd "$ANDROID_BUILD_TOP" || true
fi

echo "vendorsetup.sh execution complete."
