allZones = {
    {
        label = "[E] Use Elevator", -- Elevator 1st floor
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
        label = "[E] Use Elevator", -- Elevator basement
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
        label = "[E] Hack", -- Elevator basement
        key = 38,
        coords = {-3.7646, -686.8660, 16.1308},
        canInteract = function()
            return (not isCop())
        end,
        event = "av_union:hackVault",
        distance = 1,
        args = {
            
        }
    },
    {
        label = "[E] Inspect", -- Tunnel C4
        key = 38,
        coords = {6.5489, -658.8716, 16.1309},
        canInteract = function()
            return (not isCop() and not heist['tunnelOpen'])
        end,
        event = "av_union:plantC4",
        distance = 1,
        args = {
            
        }
    },
}