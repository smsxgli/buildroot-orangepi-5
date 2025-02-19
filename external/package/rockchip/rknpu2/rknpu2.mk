################################################################################
#
# rknpu2
#
################################################################################

RKNPU2_VERSION = $(subst /,-,$(BR2_PACKAGE_ROCKCHIP_SDK_VERSION))
RKNPU2_SITE = $(call gitlab,firefly-linux,external/rknpu2,$(BR2_PACKAGE_ROCKCHIP_SDK_VERSION))
RKNPU2_SOURCE = rknpu2-$(RKNPU2_VERSION).tar.bz2
RKNPU2_INSTALL_STAGING = YES

RKNPU2_LICENSE = ROCKCHIP
RKNPU2_LICENSE_FILES = LICENSE

RKNPU2_ARCH = $(call qstrip,$(BR2_PACKAGE_RKNPU2_ARCH))

define RKNPU2_INSTALL_TARGET_CMDS
	cp -r $(@D)/runtime/Linux/rknn_server/$(RKNPU2_ARCH)/* \
		$(TARGET_DIR)/
	cp -r $(@D)/runtime/Linux/librknn_api/$(RKNPU2_ARCH)/* \
		$(TARGET_DIR)/usr/lib/
endef

define RKNPU2_INSTALL_STAGING_CMDS
	cp -r $(@D)/runtime/Linux/librknn_api/$(RKNPU2_ARCH)/* \
		$(STAGING_DIR)/usr/lib/
	cp -rT $(@D)/runtime/Linux/librknn_api/include \
		$(STAGING_DIR)/usr/include/rknn
endef

ifeq ($(BR2_PACKAGE_RKNPU2_EXAMPLE),)
$(eval $(generic-package))
else
RKNPU2_SUBDIR = examples/rknn_common_test

define RKNPU2_INSTALL_TARGET_EXAMPLE
	cp -r $(@D)/runtime/Linux/librknn_api/$(RKNPU2_ARCH)/* \
		$(STAGING_DIR)/usr/lib/
	cp -rT $(@D)/runtime/Linux/librknn_api/include \
		$(STAGING_DIR)/usr/include/rknn

	cp $(@D)/$(RKNPU2_SUBDIR)/rknn_common_test $(TARGET_DIR)/usr/bin/
	cp -r $(@D)/$(RKNPU2_SUBDIR)/model $(TARGET_DIR)/usr/share/
endef
RKNPU2_POST_INSTALL_TARGET_HOOKS += RKNPU2_INSTALL_TARGET_EXAMPLE
$(eval $(cmake-package))
endif
