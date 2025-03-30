-- DualSense (PS5) controller description rename to just "Wireless Controller"
-- Some games look specifically for this, and vibration relies on this
--
-- https://github.com/ValveSoftware/Proton/issues/5900
-- https://wiki.archlinux.org/title/WirePlumber#Changing_a_device/node_property

rule = {
	matches = {
		{
			{ "node.name", "matches", "*Sony_Interactive_Entertainment_Wireless_Controller*" },
		},
	},
	apply_properties = {
		["node.description"] = "Wireless Controller",
	},
}

table.insert(alsa_monitor.rules,rule)
