-- Copyright 2018 Nicholas Smith <mips171@icloud.com>
-- Adapted from luci-proto-qmi
-- Licensed to the public under the GNU GPL v2.0.

local map, section, net = ...

local device, apn, pincode, username, password
local auth, ipv6

device = section:taboption("general", Value, "device", translate("Modem device"))
device.rmempty = false

-- Supports only one modem that has already been registered by MM.  Ensures the modem is usable.
local handle = io.popen("mmcli -m 0 | grep 'device: ' | grep -Eo '/sys/devices/.*' | tr -d \"'\"", "r")
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

auth = section:taboption("general", Value, "auth", translate("Authentication type"))
auth:value("", translate("-- Please choose --"))
auth:value("both", "PAP/CHAP (both)")
auth:value("pap", "PAP")
auth:value("chap", "CHAP")
auth:value("none", "NONE")

iptype = section:taboption("general", Value, "iptype", translate("IP connection type"))
iptype:value("", translate("-- Please choose --"))
iptype:value("ipv4", "IPv4 only")
iptype:value("ipv6", "IPv6 only")
iptype:value("ipv4v6", "IPv4/IPv6 (both - defaults to IPv4)")
