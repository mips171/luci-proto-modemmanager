-- Copyright 2018 Nicholas Smith <mips171@icloud.com>
-- Adapted from luci-proto-qmi
-- Licensed to the public under the Apache License 2.0.

local map, section, net = ...

local device, apn, pincode, username, password
local auth, ipv6


device = section:taboption("general", Value, "device", translate("Modem device"))
device.rmempty = false


-- Supports only one modem that has already been registered by MM.  Ensures the modem is usable.
local device_suggestions = io.popen("mmcli -m 0 | grep 'device: ' | grep -Eo '/sys/devices/.*' | tr -d \"'\"", "r")
-- Here are a couple of other ways to do this and possibly support more devices.  Note: realpath should be added to BusyBox.
--local device_suggestions = nixio.fs.glob("/sys/devices/platform/1e1c0000.xhci/usb2/2-*")
--local handle = io.popen("realpath /sys/class/net/wwan0/device", "r")
local device_suggestions = handle:read("*l")
handle:close()

if handle then
	device:value(device_suggestions)
end


apn = section:taboption("general", Value, "apn", translate("APN"))
apn:value("", translate("-- Please choose --"))
apn:value("live.vodafone.com", "Vodafone: live.vodafone.com")
apn:value("internet", "Telstra: internet")
apn:value("telstra.internet", "Telstra: telstra.internet")
apn:value("connect", "Optus: connect")


pincode = section:taboption("general", Value, "pincode", translate("PIN"))


username = section:taboption("general", Value, "username", translate("PAP/CHAP username"))


password = section:taboption("general", Value, "password", translate("PAP/CHAP password"))
password.password = true

auth = section:taboption("general", Value, "auth", translate("Authentication Type"))
auth:value("", translate("-- Please choose --"))
auth:value("both", "PAP/CHAP (both)")
auth:value("pap", "PAP")
auth:value("chap", "CHAP")
auth:value("none", "NONE")

if luci.model.network:has_ipv6() then
    ipv6 = section:taboption("advanced", Flag, "ipv6", translate("Enable IPv6 negotiation"))
    ipv6.default = ipv6.disabled
end
