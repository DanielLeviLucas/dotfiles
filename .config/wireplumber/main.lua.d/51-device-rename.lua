rule = {
    matches = {
        {
            { "node.name", "equals", "alsa_output.pci-0000_27_00.6.analog-stereo" },
        },
    },
    apply_properties = {
        ["node.description"] = "System",
        ["node.nick"] = "System",

    },
}

table.insert(alsa_monitor.rules, rule)
