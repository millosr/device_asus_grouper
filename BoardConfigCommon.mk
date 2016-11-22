# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

# inherit from the proprietary version
# needed for BP-flashing updater extensions

# Default value, if not overridden else where.
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR ?= device/asus/grouper/bluetooth

TARGET_BOARD_PLATFORM := tegra3
TARGET_TEGRA_VERSION := t30

TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a9

# Jack
ifeq ($(ANDROID_JACK_VM_ARGS),)
  ANDROID_JACK_VM_ARGS := -Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4096m
endif

# Filesystem
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

BOARD_SYSTEMIMAGE_PARTITION_SIZE := 681574400
BOARD_CACHEIMAGE_PARTITION_SIZE := 464519168
BOARD_USERDATAIMAGE_PARTITION_SIZE := 6567231488
BOARD_FLASH_BLOCK_SIZE := 4096

# Disable journaling on system.img to save space
BOARD_SYSTEMIMAGE_JOURNAL_SIZE := 0

# Don't dex preoptimize because of small system partition
WITH_DEXPREOPT := false

# Configure jemalloc for low-memory
MALLOC_SVELTE := true

# Wifi related defines
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WPA_SUPPLICANT_VERSION      := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE           := bcmdhd
#WIFI_DRIVER_MODULE_PATH     := "/system/lib/modules/bcm4329.ko"
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA     := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_AP      := "/vendor/firmware/fw_bcmdhd_apsta.bin"

#camera
TARGET_HAS_LEGACY_CAMERA_HAL1 := true

TARGET_BOOTLOADER_BOARD_NAME := grouper

BOARD_USES_GENERIC_AUDIO := false
BOARD_USES_ALSA_AUDIO := false

BOARD_USES_GENERIC_INVENSENSE := false

BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true

USE_OPENGL_RENDERER := true
BOARD_EGL_CFG := device/asus/grouper/egl.cfg

ifneq ($(HAVE_NVIDIA_PROP_SRC),false)
# needed for source compilation of nvidia libraries
-include vendor/nvidia/proprietary_src/build/definitions.mk
-include vendor/nvidia/build/definitions.mk
endif

# Override healthd HAL
BOARD_HAL_STATIC_LIBRARIES := libdumpstate.grouper libhealthd.tegra3

# Avoid the generation of ldrcc instructions
NEED_WORKAROUND_CORTEX_A9_745320 := true

BOARD_USES_GROUPER_MODULES := true

TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK := true

# ViPER4Android
VIPER4ANDROID_MODE := NEON

# custom ota
BOARD_CUSTOM_OTA_MK := device/asus/grouper/custom/customota.mk

# Use clang platform builds
USE_CLANG_PLATFORM_BUILD := true

TARGET_GCC_VERSION_EXP := 4.9

# Various optimizations
TARGET_DISABLE_ARM_PIE := true
TARGET_GLOBAL_CFLAGS += -mtune=cortex-a9 -mfpu=neon -mfloat-abi=hardfp -gtoggle -s -DNDEBUG -march=armv7-a -mthumb -O2 -funroll-loops -mimplicit-it=always -mno-warn-deprecated -mauto-it --disable-docs -mtls-dialect=gnu2 --param l1-cache-size=32 --param l1-cache-line-size=32 --param l2-cache-size=1024 --param simultaneous-prefetches=6 --param prefetch-latency=400 -mvectorize-with-neon-quad
TARGET_GLOBAL_CPPFLAGS += -mtune=cortex-a9 -mfpu=neon -mfloat-abi=hardfp -gtoggle -s -DNDEBUG -O2 -funroll-loops -mthumb -march=armv7-a -mimplicit-it=always -mno-warn-deprecated -mauto-it --disable-docs -mtls-dialect=gnu2 --param l1-cache-size=32 --param l1-cache-line-size=32 --param l2-cache-size=1024 --param simultaneous-prefetches=6 --param prefetch-latency=400 -mvectorize-with-neon-quad
# TARGET_BOOTANIMATION_PRELOAD := true
BOARD_SKIP_ANDROID_DOC_BUILD := true
DISABLE_DROIDDOC := true
# TARGET_BOOTANIMATION_TEXTURE_CACHE := false
TARGET_ENABLE_NON_PIE_SUPPORT := true
HWUI_COMPILE_FOR_PERF := true
$(call add-product-dex-preopt-module-config,services,--compiler-filter=everything)


# SELinux
BOARD_SEPOLICY_DIRS += \
        device/asus/grouper/sepolicy
