#
# Copyright 2019 Nicholas Smith <mips171@icloud.com>
# SPDX-License-Identifier: Apache-2.0
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=Support for ModemManager
LUCI_DEPENDS:=+modemmanager

include ../../luci.mk

# call BuildPackage - OpenWrt buildroot signature
