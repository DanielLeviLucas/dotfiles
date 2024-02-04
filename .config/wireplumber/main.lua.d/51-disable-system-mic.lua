rule = {
    matches = {
        {
            { "node.name", "equals", "alsa_input.pci-0000_27_00.6.analog-stereo" },
        },
    },
    apply_properties = {
        ["device.disabled"] = true,
    },
}

table.insert(alsa_monitor.rules, rule)
