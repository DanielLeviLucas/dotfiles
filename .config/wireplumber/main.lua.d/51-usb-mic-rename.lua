rule = {
    matches = {
        {
            { "node.name", "equals", "alsa_input.usb-0c76_USB_PnP_Audio_Device-00.mono-fallback" },
        },
    },
    apply_properties = {
        ["node.description"] = "Fifine microphone",
    },
}

table.insert(alsa_monitor.rules, rule)
