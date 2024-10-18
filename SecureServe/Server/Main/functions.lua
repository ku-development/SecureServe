local COLORS = {
    ["Red Orange"] = "^1",
    ["Light Green"] = "^2",
    ["Light Yellow"] = "^3",
    ["Dark Blue"] = "^4",
    ["Light Blue"] = "^5",
    ["Violet"] = "^6",
    ["White"] = "^7",
    ["Blood Red"] = "^8",
    ["Fuchsia"] = "^9"
}

sm_print = function(color, content)
    print(COLORS["Light Blue"] .. "[SecureServe] " .. COLORS["White"] .. ": " .. COLORS[color] .. content .. COLORS["White"])
end