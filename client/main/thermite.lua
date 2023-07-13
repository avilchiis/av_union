local doorOffsets = {
    ['R1'] = {1.35, -0.05, 0.05, 95.0},
    ['R2'] = {1.35, -0.05, 0.05, 95.0},
    ['L1'] = {1.35, 0.05, 0.05, -90.0},
    ['L2'] = {1.35, 0.05, 0.05, -90.0},
}

RegisterNetEvent('av_union:door', function(door)
    if inAnimation then return end
    if Config.Doors[door]['locked'] then
        if hasItem(Config.NeededItems['thermite'],1) then
            inAnimation = true
            lib.hideTextUI()
            lib.requestAnimDict('anim@heists@ornate_bank@thermal_charge')
            lib.requestModel('hei_p_m_bag_var22_arm_s')
            local playerPed = PlayerPedId()
            local fwd, _, _, pos = GetEntityMatrix(playerPed)
            local np = (fwd * 0.5) + pos
            SetEntityCoords(playerPed, np.xy, np.z - 1)
            local rot, pos = GetEntityRotation(playerPed), GetEntityCoords(playerPed)
            SetPedComponentVariation(playerPed, 5, -1, 0, 0)
            local doorObject = GetClosestObjectOfType(pos.x, pos.y, pos.z, 3.0, `v_ilev_fingate`, false, false, false)
            local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pos.x, pos.y, pos.z,  true,  true, false)
            local scene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, 2, false, false, 1065353216, 0, 1.3)
            SetEntityCollision(bag, 0, 1)
            NetworkAddPedToSynchronisedScene(playerPed, scene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(bag, scene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
            SetPedComponentVariation(playerPed, 5, 45, 0, 0)
            NetworkStartSynchronisedScene(scene)
            Wait(1500)
            local x, y, z = table.unpack(GetEntityCoords(playerPed))
            local thermite = CreateObject(`hei_prop_heist_thermite`, x, y, z + 0.2,  true,  true, true)
            SetEntityCollision(thermite, false, true)
            AttachEntityToEntity(thermite, playerPed, GetPedBoneIndex(playerPed, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
            Wait(700)
            DetachEntity(thermite, 1, 1)
            FreezeEntityPosition(thermite,true)
            AttachEntityToEntity(thermite, doorObject, 1, doorOffsets[door][1], doorOffsets[door][2], doorOffsets[door][3], doorOffsets[door][4], 0.0, 0.0, true, true, false, false, 1, true)
            Wait(3300)
            DeleteObject(bag)
            NetworkStopSynchronisedScene(scene)
            local res = ThermiteMinigame()
            if res then
                TriggerServerEvent('av_union:thermiteFx', NetworkGetNetworkIdFromEntity(thermite), GetEntityCoords(thermite))
                TaskPlayAnim(playerPed, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
                TaskPlayAnim(playerPed, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 6000, 49, 1, 0, 0, 0)
                Wait(4000)
                ClearPedTasks(ped)
                Wait(2000)
                TriggerServerEvent('av_union:updateDoor',door)
            else
                DeleteEntity(thermite)
            end
            Wait(1000)
            inAnimation = false
        end
    end
end)

RegisterNetEvent('av_union:thermiteFx', function(netId,coords)
    if #(GetEntityCoords(PlayerPedId()) - coords) < 40.0 then
        local thermite = NetworkGetEntityFromNetworkId(netId)
        if not DoesEntityExist(thermite) then return end
        RequestNamedPtfxAsset("scr_ornate_heist")
        while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
            Wait(1)
        end
        SetPtfxAssetNextCall("scr_ornate_heist")
        local rot = GetEntityRotation(thermite)
        local Effect = StartParticleFxLoopedOnEntity("scr_heist_ornate_thermal_burn", thermite, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
        Wait(8000)
        StopParticleFxLooped(Effect, 0)
        if DoesEntityExist(thermite) then
            DeleteEntity(thermite)
        end
    end
end)