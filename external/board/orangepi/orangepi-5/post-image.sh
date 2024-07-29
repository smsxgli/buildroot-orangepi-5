#!/bin/sh

echo copy dtb overlays
linuxDir=`find ${BASE_DIR}/build -name 'vmlinux' -type f | xargs dirname`
mkdir -p ${BINARIES_DIR}/rockchip/overlays
if [ -d ${linuxDir}/arch/arm64/boot/dts/rockchip/overlay ]; then
  cp -a ${linuxDir}/arch/arm64/boot/dts/rockchip/overlay/*.dtbo ${BINARIES_DIR}/rockchip/overlays
fi

echo copy boot text file
cp -a ${BR2_EXTERNAL_ORANGEPI_5_PATH}/board/orangepi/orangepi-5/boot-vars.txt ${BINARIES_DIR}
cp -a ${BR2_EXTERNAL_ORANGEPI_5_PATH}/board/orangepi/orangepi-5/boot.cmd ${BINARIES_DIR}

echo copy dtb
cp -a ${BINARIES_DIR}/rk3588s-orangepi-5.dtb ${BINARIES_DIR}/rockchip

echo copy tpl
cp -a ${BR2_EXTERNAL_ORANGEPI_5_PATH}/board/orangepi/orangepi-5/rkbin/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.16.bin ${BINARIES_DIR}

echo creating idbloader.img
ubootDir=`find ${BASE_DIR}/build -name 'uboot-*' -type d`
${ubootDir}/tools/mkimage -n rk3588 -T rksd -d ${BINARIES_DIR}/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.16.bin:${BINARIES_DIR}/u-boot-spl.bin ${BINARIES_DIR}/idbloader.img

echo creating boot.scr
${ubootDir}/tools/mkimage -n 'boot script' -T script -A arm -C none -d ${BINARIES_DIR}/boot.cmd ${BINARIES_DIR}/boot.scr

${CONFIG_DIR}/support/scripts/genimage.sh -c ${BR2_EXTERNAL_ORANGEPI_5_PATH}/board/orangepi/orangepi-5/genimage.cfg

echo done
