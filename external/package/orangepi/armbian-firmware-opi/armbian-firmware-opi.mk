################################################################################
#
# armbian-firmware
#
################################################################################

ARMBIAN_FIRMWARE_OPI_VERSION = e75d7b6e36696a7877111c02bd3497cbd2d5cb34
ARMBIAN_FIRMWARE_OPI_SITE = https://github.com/armbian/firmware
ARMBIAN_FIRMWARE_OPI_SITE_METHOD = git

# AP6212 WiFi/BT combo firmware
ifeq ($(BR2_PACKAGE_ARMBIAN_FIRMWARE_OPI_AP6212),y)
ARMBIAN_FIRMWARE_OPI_DIRS += ap6212
endif

# AP6256 WiFi/BT combo firmware
ifeq ($(BR2_PACKAGE_ARMBIAN_FIRMWARE_OPI_AP6256),y)
ARMBIAN_FIRMWARE_OPI_FILES += \
	brcm/BCM4345C5.hcd \
	brcm/brcmfmac43456-sdio.bin \
	brcm/brcmfmac43456-sdio.txt
endif

# AP6255 WiFi/BT combo firmware
ifeq ($(BR2_PACKAGE_ARMBIAN_FIRMWARE_OPI_AP6255),y)
ARMBIAN_FIRMWARE_OPI_FILES += \
	BCM4345C0.hcd \
	fw_bcm43455c0_ag.bin \
	fw_bcm43455c0_ag_apsta.bin \
	fw_bcm43455c0_ag_p2p.bin \
	nvram_ap6255.txt \
	brcm/brcmfmac43455-sdio.bin \
	brcm/brcmfmac43455-sdio.clm_blob \
	brcm/brcmfmac43455-sdio.txt \
	brcm/config.txt
endif

# AP6275P WiFi/BT combo firmware
ifeq ($(BR2_PACKAGE_ARMBIAN_FIRMWARE_OPI_AP6275P),y)
# ARMBIAN_FIRMWARE_OPI_FILES += \
# 	ap6275p/BCM4362A2.hcd \
# 	ap6275p/clm_bcm43752a2_pcie_ag.blob \
# 	ap6275p/config.txt \
# 	ap6275p/fw_bcm43752a2_pcie_ag.bin \
# 	ap6275p/nvram_AP6275P.txt
ARMBIAN_FIRMWARE_OPI_DIRS += ap6275p
endif

# Realtek 8822CS SDIO WiFi/BT combo firmware
ifeq ($(BR2_PACKAGE_ARMBIAN_FIRMWARE_OPI_RTL8822CS),y)
ARMBIAN_FIRMWARE_OPI_FILES += \
	rtlbt/rtl8822cs_config \
	rtlbt/rtl8822cs_fw \
	rtl_bt/rtl8822cs_config.bin \
	rtl_bt/rtl8822cs_fw.bin
endif

# XR819 WiFi firmware
ifeq ($(BR2_PACKAGE_ARMBIAN_FIRMWARE_OPI_XR819),y)
ARMBIAN_FIRMWARE_OPI_FILES += \
	xr819/boot_xr819.bin \
	xr819/fw_xr819.bin \
	xr819/sdd_xr819.bin
endif

ifneq ($(ARMBIAN_FIRMWARE_OPI_FILES),)
define ARMBIAN_FIRMWARE_OPI_INSTALL_FILES
	cd $(@D) && \
		$(TAR) cf install.tar $(sort $(ARMBIAN_FIRMWARE_OPI_FILES)) && \
		$(TAR) xf install.tar -C $(TARGET_DIR)/lib/firmware
endef
endif

ifneq ($(ARMBIAN_FIRMWARE_OPI_DIRS),)
# We need to rm -rf the destination directory to avoid copying
# into it in itself, should we re-install the package.
define ARMBIAN_FIRMWARE_OPI_INSTALL_DIRS
	$(foreach d,$(ARMBIAN_FIRMWARE_OPI_DIRS), \
		rm -rf $(TARGET_DIR)/lib/firmware/$(d); \
		cp -a $(@D)/$(d) $(TARGET_DIR)/lib/firmware/$(d)$(sep))
endef
endif

ifneq ($(ARMBIAN_FIRMWARE_OPI_FILES)$(ARMBIAN_FIRMWARE_OPI_DIRS),)
ARMBIAN_FIRMWARE_OPI_LICENSE = PROPRIETARY
ARMBIAN_FIRMWARE_OPI_REDISTRIBUTE = NO
endif

define ARMBIAN_FIRMWARE_OPI_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/lib/firmware
	$(ARMBIAN_FIRMWARE_OPI_INSTALL_FILES)
	$(ARMBIAN_FIRMWARE_OPI_INSTALL_DIRS)
endef

$(eval $(generic-package))
