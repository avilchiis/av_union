allZones = {
    {
        label = Lang['use_elevator'], -- Elevator 1st floor
        key = 38, -- Used for interaction
        coords = {10.4317, -672.78, 33.4495}, -- Where the zone is located
        canInteract = function() -- Return true/false, used for some extra checks
            return true
        end,
        event = "av_union:teleport", -- Event that is gonna be triggered
        distance = 5, -- Distance ? duh
        args = { -- Some args that you would want to send thru the event
            x = -0.0959, y = -705.8996, z = 16.1315, heading = 339.5779
        }
    },
    {
        label = Lang['use_elevator'], -- Elevator basement
        key = 38,
        coords = {-0.0979, -705.8881, 16.1244},
        canInteract = function()
            return true
        end,
        event = "av_union:teleport",
        distance = 5,
        args = {
            x = 10.5236, y = -670.8502, z = 33.4495, heading = 3.6180
        }
    },
    {
        label = Lang['hack_vault'], -- Elevator basement
        key = 38,
        coords = {-3.7646, -686.8660, 16.1308},
        canInteract = function()
            return (not isCop() and not heist['vaultOpen'])
        end,
        event = "av_union:hackVault",
        distance = 1,
        args = {}
    },
    {
        label = Lang['plant_c4'], -- Tunnel C4
        key = 38,
        coords = {6.5489, -658.8716, 16.1309},
        canInteract = function()
            return (not isCop() and not heist['tunnelOpen'])
        end,
        event = "av_union:plantC4",
        distance = 1,
        args = {}
    },
    {
        label = Lang['steal_money'], -- Trolley 1R
        key = 38,
        coords = {5.061, -680.50, 15.13},
        canInteract = function()
            return (not isCop() and isTrolley())
        end,
        event = "av_union:money",
        distance = 1.5,
        args = {}
    },
    {
        label = Lang['steal_money'], -- Trolley 2R
        key = 38,
        coords = {6.32, -674.99, 15.13},
        canInteract = function()
            return (not isCop() and isTrolley())
        end,
        event = "av_union:money",
        distance = 1.5,
        args = {}
    },
    {
        label = Lang['steal_money'], -- Trolley 1L
        key = 38,
        coords = {-6.13, -676.20, 15.13},
        canInteract = function()
            return (not isCop() and isTrolley())
        end,
        event = "av_union:money",
        distance = 1.5,
        args = {}
    },
    {
        label = Lang['steal_money'], -- Trolley 2L
        key = 38,
        coords = {-3.97, -671.06, 15.13},
        canInteract = function()
            return (not isCop() and isTrolley())
        end,
        event = "av_union:money",
        distance = 1.5,
        args = {}
    },
}