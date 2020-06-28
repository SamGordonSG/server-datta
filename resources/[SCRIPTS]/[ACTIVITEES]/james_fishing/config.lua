Config = {}

Config.Debug = false -- only in dev mode.

Config.MarkerData = {
    ["type"] = 6,
    ["size"] = vector3(2.0, 2.0, 2.0),
    ["color"] = vector3(0, 255, 150)
}

Config.FishingRestaurant = {
    ["name"] = "L'espadon",
    ["blip"] = {
        ["sprite"] = 628,
        ["color"] = 3
    },
    ["ped"] = {
        ["model"] = 0xED0CE4C6,
        ["position"] = vector3(-1038.4545898438, -1397.0551757813, 5.553192615509),
        ["heading"] = 75.0
    }
}

Config.FishingItems = {
    ["rod"] = {
        ["name"] = "james_fishingrod",
        ["label"] = "Canne à pêche"
    },
    ["bait"] = {
        ["name"] = "james_fishingbait",
        ["label"] = "Leurre"
    },
    ["fish"] = {
        ["name"] = "james_fish",
        ["label"] = "Poisson Cru",
        ["price"] = 15 -- this is the price for each fish captured.
    }
}

Config.Command = "fish" -- if set to "" or "none" command will not work. otherwise item use will be used.