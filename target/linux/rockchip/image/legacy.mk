define Device/Legacy/rk3588s
$(call Device/Legacy)
  SOC := rk3588s
  DEVICE_PACKAGES := kmod-rga3 kmod-rk_vcodec kmod-rkgpu-bifrost-csf-coex kmod-rknpu
endef

define Device/friendlyarm_nanopi-r6s
$(call Device/Legacy/rk3588s)
  DEVICE_VENDOR := FriendlyARM
  DEVICE_MODEL := NanoPi R6S/R6C
  SUPPORTED_DEVICES += friendlyarm,nanopi-r6s friendlyarm,nanopi-r6c
  SUPPORTED_DEVICES += friendlyelec,nanopi-r6s friendlyelec,nanopi-r6c
  DEVICE_DTS := rockchip/rk3588s-nanopi-r6s rockchip/rk3588s-nanopi-r6c
  BOOT_SCRIPT := rk3588-friendlyelec
  UBOOT_DEVICE_NAME := easepi-rk3588
  DEVICE_PACKAGES += kmod-r8169
  DEVICE_PACKAGES := kmod-r8169
endef
