-- For more scripts visit my site: http://av-scripts.com/
-- For more scripts visit my site: http://av-scripts.com/
-- For more scripts visit my site: http://av-scripts.com/

-- Join my Discord: https://discord.com/invite/2qcG8acvXq
-- Join my Discord: https://discord.com/invite/2qcG8acvXq
-- Join my Discord: https://discord.com/invite/2qcG8acvXq

-- If you want to report a bug please do it in my forum post/Github but NOT Discord, thanks!.

Config = {}
Config.Framework = "QBCore" -- Available options: "QBCore", "ESX", "Other".
Config.AdminLevel = "admin" -- Level needed to restart the heist.
Config.Command = "union:wipe" -- Command used by admins to restart the heist.
Config.Cooldown = 60 -- The heist will be automatically restarted after X minutes.
Config.Inventory = "ox_inventory" -- Available options: "ox_inventory", "qs-inventory", "lj-inventory", "qb-inventory"
Config.MinCops = 0 -- Min cops online to start the heist
Config.MoneyAccount = "cash" -- Your cash/money account name
Config.Reward = {min = 20000, max = 70000} -- Money you will receive per trolley
Config.PoliceJob = {
    ['police'] = true,
    ['sheriff'] = true,
}
Config.NeededItems = {
    ['hack_vault'] = "hacking_phone",
    ['thermite'] = "thermite",
    ['c4'] = "c4",
}