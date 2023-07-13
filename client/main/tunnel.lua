local busy = false

RegisterNetEvent('av_union:plantC4', function()
    if busy then return end
    if not enoughCops() then
        TriggerEvent('av_union:notification',Lang['not_enough_cops'],'error')
        return
    end
    if hasItem(Config.NeededItems['c4'], 1) then
        busy = true
        lib.hideTextUI()
        removeItem(Config.NeededItems['c4'], 1)
        lib.requestAnimDict('anim@heists@ornate_bank@thermal_charge')
        lib.requestModel('hei_p_m_bag_var22_arm_s')
        local playerPed = PlayerPedId()
        SetEntityCoords(playerPed, 6.40, -658.52, 15.20)
        SetEntityHeading(playerPed, 344.31)
        FreezeEntityPosition(playerPed, true)
        local rot, pos = GetEntityRotation(playerPed), GetEntityCoords(playerPed)
        SetPedComponentVariation(playerPed, 5, -1, 0, 0)
        local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pos.x, pos.y, pos.z,  true,  true, false)
        local scene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, 2, 0, 0, 1065353216, 0, 1.3)
        SetEntityCollision(bag, 0, 1)
        NetworkAddPedToSynchronisedScene(playerPed, scene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(bag, scene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
        NetworkStartSynchronisedScene(scene)
        Wait(1500)
        pos = GetEntityCoords(playerPed)
        c4 = CreateObject(`ch_prop_ch_explosive_01a`, pos.x, pos.y, pos.z + 0.2, 1, 1, 1)
        SetEntityCollision(c4, 0, 1)
        AttachEntityToEntity(c4, playerPed, GetPedBoneIndex(playerPed, 28422), 0, 0, 0, 0, 0, 180.0, 1, 1, 0, 1, 1, 1)
        Wait(4000)
        DeleteEntity(bag)
        SetPedComponentVariation(playerPed, 5, 45, 0, 0)
        DetachEntity(c4, 1, 1)
        FreezeEntityPosition(c4, 1)
        SetEntityCollision(c4, 0, 1)
        FreezeEntityPosition(playerPed, false)
        NetworkStopSynchronisedScene(scene)
        while busy do
            if not lib.isTextUIOpen() then
                lib.showTextUI(Lang['use_c4'])
            end
            if #(GetEntityCoords(playerPed) - vector3(6.4984, -659.1194, 16.1308)) > 50 then
                TriggerEvent('av_union:notification', Lang['lost_signal'], "error")
                DeleteEntity(c4)
                busy = false
                lib.hideTextUI()
            end
            if IsControlJustPressed(0,38) and busy then
                TriggerServerEvent('av_union:triggerC4')
                DeleteEntity(c4)
                busy = false
                lib.hideTextUI()
            end
            Wait(0)
        end
    else
        TriggerEvent('av_union:notification',Lang['no_item'],'error')
    end
end)

RegisterNetEvent('av_union:c4explosion', function()
    if #(GetEntityCoords(PlayerPedId()) - vector3(6.324, -659.62, 16.13)) < 100 then
        local handle = GetRayfireMapObject(7.25, -656.98, 17.14, 50.0, "des_finale_tunnel")
        local handle2 = GetRayfireMapObject(7.25, -656.98, 17.14, 50.0, "des_finale_vault")
        SetStateOfRayfireMapObject(handle, 4)
        SetStateOfRayfireMapObject(handle2, 4)
        Wait(100)
		RequestNamedPtfxAsset('scr_josh3')
		while not HasNamedPtfxAssetLoaded('scr_josh3') do
			Wait(1)
		end	
		UseParticleFxAssetNextCall('scr_josh3')
        AddExplosionWithUserVfx(6.60, -658.55, 15.38, 26, `EXP_VFXTAG_TRN4_DYNAMITE`, 100000.0, true, false, 1)
        PlaySoundFromCoord(-1, "MAIN_EXPLOSION_CHEAP", 6.60, -658.55, 15.38, 0, 0, 0, 0)
        StartParticleFxNonLoopedAtCoord("scr_josh3_explosion", 6.60, -658.55, 15.38, 0.0, 0.0, 0.0, 7.0, false, false, false, 0)
		SetStateOfRayfireMapObject(handle, 6) 
		SetStateOfRayfireMapObject(handle2, 6)
		Citizen.CreateThread(function()
			Wait(10)
			while GetRayfireMapObjectAnimPhase(handle) > 0.0 do
				Wait(0)
			end
			while GetRayfireMapObjectAnimPhase(handle2) > 0.0 do
				Wait(0)
			end
		end)
	end
end)