# SPDX-License-Identifier: GPL-2.0-only

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

DEVICE_VARS += UBOOT_DEVICE_NAME

define Build/Compile
	(cd ../dts/rk3588 && ./check.sh)
	$(CP) $(LINUX_DIR)/COPYING $(KDIR)/COPYING.linux
endef

### Image scripts ###
define Build/boot-common
	# This creates a new folder copies the dtb (as rockchip.dtb) 
	# and the kernel image (as kernel.img)
	rm -fR $@.boot
	mkdir -p $@.boot

	$(CP) $(IMAGE_KERNEL) $@.boot/kernel.img
endef

define Build/boot-script
	# Make an U-boot image and copy it to the boot partition
	mkimage -A arm -O linux -T script -C none -a 0 -e 0 -d $(if $(1),$(1),default).bootscript $@.boot/boot.scr
endef

define Build/pine64-img
	# Creates the final SD/eMMC images, 
	# combining boot partition, root partition as well as the u-boot bootloader

	# Generate a new partition table in $@ with 32 MiB of 
	# alignment padding for the u-boot-rockchip.bin (idbloader + u-boot) to fit:
	# http://opensource.rock-chips.com/wiki_Boot_option#Boot_flow
	#
	# U-Boot SPL expects the U-Boot ITB to be located at sector 0x4000 (8 MiB) on the MMC storage
	SIGNATURE="$(IMG_PART_SIGNATURE)" \
	$(SCRIPT_DIR)/gen_image_generic.sh \
		$@ \
		$(CONFIG_TARGET_KERNEL_PARTSIZE) $@.boot \
		$(CONFIG_TARGET_ROOTFS_PARTSIZE) $(IMAGE_ROOTFS) \
		32768

	# Copy the u-boot-rockchip.bin to the image at sector 0x40
	dd if="$(STAGING_DIR_IMAGE)"/$(UBOOT_DEVICE_NAME)-u-boot-rockchip.bin of="$@" seek=64 conv=notrunc
endef

### Legacy Image scripts ###
define Build/boot-common-legacy
	# This creates a new folder copies the dtbs (as rockchip*.dtb) 
	# and the kernel image (as kernel.img)
	rm -fR $@.boot
	mkdir -p $@.boot

	i=0; \
	for dts in $(DEVICE_DTS); do \
		$(CP) $(KDIR)/image-$${dts##*/}.dtb $@.boot/rockchip$$(perl -e 'printf "%b\n",'$$i).dtb || exit 1; \
		let i+=1; \
	done
	$(LN) rockchip0.dtb $@.boot/rockchip.dtb
	$(CP) $(IMAGE_KERNEL) $@.boot/kernel.img
endef

define Build/boot-script-legacy
	# Make an U-boot image and copy it to the boot partition
	mkimage -A arm -O linux -T script -C none -a 0 -e 0 -d legacy/$(if $(1),$(1),default).bootscript $@.boot/boot.scr
endef

### Devices ###
define Device/Default
  PROFILES := Default
  KERNEL = kernel-bin | lzma | fit lzma $$(DTS_DIR)/$$(DEVICE_DTS).dtb
  BOOT_SCRIPT :=
  IMAGES := sysupgrade.img.gz
  IMAGE/sysupgrade.img.gz = boot-common | boot-script $$(BOOT_SCRIPT) | pine64-img | gzip | append-metadata
  DEVICE_DTS = rockchip/$$(SOC)-$(lastword $(subst _, ,$(1)))
  UBOOT_DEVICE_NAME = $(lastword $(subst _, ,$(1)))-$$(SOC)
endef

define Device/Legacy
  KERNEL = kernel-bin
  DEVICE_DTS_DIR := ../dts
  DEVICE_DTS = $$(SOC)/$$(SOC)-$(lastword $(subst _, ,$(1)))
  IMAGE/sysupgrade.img.gz = boot-common-legacy | boot-script-legacy $$(BOOT_SCRIPT) | pine64-img | gzip | append-metadata
endef

include $(SUBTARGET).mk

$(eval $(call BuildImage))
