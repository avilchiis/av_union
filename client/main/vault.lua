RegisterNetEvent('av_union:hackVault', function()
    if hasItem(Config.NeededItems['hack_safe'],1) then
        local vault = GetClosestObjectOfType(-1.727947, -686.5417, 16.68913, 2.0, `v_ilev_fin_vaultdoor`, false, false, false)
        if vault and vault ~= 0 then
            TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_STAND_MOBILE', -1, true)
            Citizen.Wait(3000)
            local res = hackMinigame()
            ClearPedTasks(PlayerPedId())
            Wait(2500)
            if res then
                TriggerServerEvent('av_union:openVault')
            end
        end
    else
        TriggerEvent('av_union:notification',Lang['no_item'],'error')
    end
end)

RegisterNetEvent('av_union:openVault', function()
    if #(GetEntityCoords(PlayerPedId()) - vector3(-3.5310, -685.3057, 16.1309)) <= 80 then
        local vault = GetClosestObjectOfType(-1.727947, -686.5417, 16.68913, 2.0, `v_ilev_fin_vaultdoor`, false, false, false)
        if vault and vault ~= 0 then
            OpenVault(vault,false)
        end
    end
end)

function OpenVault(obj,instant)
    if not IsAlarmPlaying('BIG_SCORE_HEIST_VAULT_ALARMS') then
        while not PrepareAlarm('BIG_SCORE_HEIST_VAULT_ALARMS') do
            Citizen.Wait(0)
        end
        StartAlarm('BIG_SCORE_HEIST_VAULT_ALARMS', 1)
    end
    if instant then
        SetEntityHeading(obj, (GetEntityHeading(obj) + 190.0))
    else
        local count = 0
		repeat
			local rotation = GetEntityHeading(obj) + 0.17
			SetEntityHeading(obj, rotation)
			count = count + 1
			Citizen.Wait(1)
		until count == 800
		FreezeEntityPosition(obj, true)
    end
end