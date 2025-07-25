include $(TOPDIR)/rules.mk

PKG_NAME:=r8126
PKG_VERSION:=10.015.00
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://github.com/openwrt/rtl8126/releases/download/$(PKG_VERSION)
PKG_HASH:=fac513aa925264a95b053e7532fcda56022d29db288f6625fafee2759a8a6124

PKG_BUILD_PARALLEL:=1
PKG_LICENSE:=GPLv2
PKG_MAINTAINER:=Alvaro Fernandez Rojas <noltari@gmail.com>

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

define KernelPackage/r8126
  SUBMENU:=Network Devices
  TITLE:=Realtek RTL8126 PCI 5 Gigabit Ethernet driver
  DEPENDS:=@PCI_SUPPORT +kmod-libphy
  FILES:=$(PKG_BUILD_DIR)/src/r8126.ko
  AUTOLOAD:=$(call AutoLoad,35,r8126)
  PROVIDES:=kmod-r8169
  VARIANT:=regular
endef

define KernelPackage/r8126/install/dkml
	$(INSTALL_DIR) $(1)/etc/modules-pending.d
	$(LN) ../modules.d/$(filter-out 0-,$(word 1,$(AUTOLOAD))-)$$(NAME) $(1)/etc/modules-pending.d/$$(NAME)
endef

ifeq ($(CONFIG_TARGET_x86),y)
KernelPackage/r8126/install = $(KernelPackage/r8126/install/dkml)
endif

define Package/kmod-r8126/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || rm -f /etc/modules-pending.d/$(NAME)
endef

define KernelPackage/r8126-rss
$(call KernelPackage/r8126)
  CONFLICTS:=kmod-r8126
  TITLE+= (RSS)
  VARIANT:=rss
endef

ifeq ($(BUILD_VARIANT),rss)
  PKG_MAKE_FLAGS += \
    ENABLE_MULTIPLE_TX_QUEUE=y \
    ENABLE_RSS_SUPPORT=y
endif

define Build/Compile
	+$(KERNEL_MAKE) $(PKG_JOBS) \
		$(PKG_MAKE_FLAGS) \
		M="$(PKG_BUILD_DIR)/src" \
		modules
endef

$(eval $(call KernelPackage,r8126))
$(eval $(call KernelPackage,r8126-rss))
