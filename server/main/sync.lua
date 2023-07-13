heist = {
    vaultOpen = false,
    tunnelOpen = false
}

RegisterServerEvent('av_union:triggerC4', function()
    local src = source
    local player = GetPlayerPed(src)
    local distance = #(GetEntityCoords(player) - vector3(6.4984, -659.1194, 16.1308))
    if distance <= 50 then
        if not heist['tunnelOpen'] then
            heist['tunnelOpen'] = true
            TriggerClientEvent('av_union:c4explosion',-1)
            syncPlayers()
        end
    else
        banPlayer(src, 'av_union:triggerC4', distance)
    end
end)

RegisterServerEvent('av_union:openVault', function()
    local src = source
    local player = GetPlayerPed(src)
    local distance = #(GetEntityCoords(player) - vector3(-3.5310, -685.3057, 16.1309))
    if distance <= 20 then
        if not heist['vaultOpen'] then
            heist['vaultOpen'] = true
            TriggerClientEvent('av_union:openVault',-1)
            syncPlayers()
            startedTime = os.time() + Config.Cooldown * 60
        end
    else
        banPlayer(src, 'av_union:openVault', distance)
    end
end)

RegisterServerEvent('av_union:thermiteFx', function(netId,coords)
    TriggerClientEvent('av_union:thermiteFx',-1,netId,coords)
end)

function syncPlayers()
    TriggerClientEvent('av_union:sync',-1,heist)
end

AddEventHandler('playerJoining', function(source)
	if source then
		TriggerClientEvent('av_union:sync',source,heist,doors)
	end
end)

AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  Wait(500)
  TriggerClientEvent('av_union:sync',-1,heist,doors)
end)

function WipeHeist()
    for k, v in pairs(trolleys) do
        while DoesEntityExist(v) do
            DeleteEntity(v)
            Wait(5)
        end
    end
    trolleys = {}
    for k, v in pairs(heist) do
        heist[k] = false
    end
    for k, v in pairs(doors) do
        v['locked'] = true
    end
    Wait(250) -- I don't know, just in case
    TriggerClientEvent('av_union:sync',-1,heist,doors)
    print("^2AV Union Heist got restarted.^7")
end