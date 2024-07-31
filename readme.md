## Quick Start
```bash
# this project uses submodule
git clone --recurse-submodules https://github.com/smsxgli/buildroot-orangepi-5
cd buildroot-orangepi-5/buildroot
make BR2_EXTERNAL=../external orangepi_5_defconfig
make all && make uboot-rebuild && make all
```

## ATTENTION!

After the initial `make all`, you must `make uboot-rebuild` and then `make all` to get a usable u-boot.itb, or you shall stub in boot progress and struggle in fdt errors! (I guess it may because this fdt relies on kernel's dtb?)
