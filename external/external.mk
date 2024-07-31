BR2_PACKAGE_ROCKCHIP_SDK_VERSION := $(patsubst "%",%,$(BR2_PACKAGE_ROCKCHIP_SDK_VERSION))
include $(sort $(wildcard $(BR2_EXTERNAL_ORANGEPI_5_PATH)/package/rockchip/*/*.mk))