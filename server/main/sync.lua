heist = {
    vaultOpen = false,
    tunnelOpen = false
}

RegisterServerEvent('av_union:triggerC4', function()
    local src = source
    local player = GetPlayerPed(src)
    if #(GetEntityCoords(player) - vector3(6.4984, -659.1194, 16.1308)) <= 50 then
        if not heist['tunnelOpen'] then
            heist['tunnelOpen'] = true
            TriggerClientEvent('av_union:c4explosion',-1)
            syncPlayers()
        end
    else
        -- Trigger your ban event here cause this guy triggered this using a mod menu (?)
    end
end)

RegisterServerEvent('av_union:openVault', function()
    local src = source
    local player = GetPlayerPed(src)
    if #(GetEntityCoords(player) - vector3(-3.5310, -685.3057, 16.1309)) <= 20 then
        if not heist['vaultOpen'] then
            heist['vaultOpen'] = true
            TriggerClientEvent('av_union:openVault',-1)
            syncPlayers()
        end
    else
        -- Trigger your ban event here cause this guy triggered this using a mod menu (?)
    end
end)

function syncPlayers()
    TriggerClientEvent('av_union:sync',-1,heist)
end

AddEventHandler('playerJoining', function(source)
	if source then
		TriggerClientEvent('av_union:sync',source,heist)
	end
end)

AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  Wait(500)
  TriggerClientEvent('av_union:sync',-1,heist)
end)