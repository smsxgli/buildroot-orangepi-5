## ATTENTION!

After initial `make all`, you must `make uboot-rebuild` and then `make all` to get a usable u-boot.itb, or you shall stub in boot progress and struggle in fdt errors! (I guess it may because such fdt relies on kernel's dtb?)
