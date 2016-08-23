LOCAL_PATH := $(call my-dir)

name := n$(TARGET_PRODUCT)
ifeq ($(TARGET_BUILD_TYPE),debug)
  name := $(name)_debug
endif
name := $(name)-$(PLATFORM_VERSION)-$(ROM_BUILD_SUFFIX)

INTERNAL_OTA_PACKAGE_TARGET := $(PRODUCT_OUT)/$(name).zip

$(INTERNAL_OTA_PACKAGE_TARGET): KEY_CERT_PAIR := $(DEFAULT_KEY_CERT_PAIR)

$(INTERNAL_OTA_PACKAGE_TARGET): $(BUILT_TARGET_FILES_PACKAGE) $(DISTTOOLS)
	@echo "Package OTA: $@"
	$(hide) MKBOOTIMG=$(BOARD_CUSTOM_BOOTIMG_MK) \
	   ./build/tools/releasetools/ota_from_target_files -v \
	   --block \
	   -p $(HOST_OUT) \
	   -k $(KEY_CERT_PAIR) \
	   --no_separate_recovery=true \
	   $(BUILT_TARGET_FILES_PACKAGE) $@

