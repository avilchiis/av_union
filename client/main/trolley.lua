currentTrolley = nil
local busy = false
function isTrolley()
    local res = false
    local pos = GetEntityCoords(PlayerPedId())
    if not currentTrolley then
        currentTrolley = GetClosestObjectOfType(pos.x, pos.y, pos.z, 3.0, `hei_prop_hei_cash_trolly_01`, false, false, false)
    end
    if currentTrolley and currentTrolley ~= 0 then
        if Entity(currentTrolley).state and Entity(currentTrolley).state.available then
            res = true
        end
    else
        currentTrolley = nil
    end
    return res
end

RegisterNetEvent('av_union:money', function()
    if not currentTrolley then return end
    if busy then return end
    local netId = NetworkGetNetworkIdFromEntity(currentTrolley)
    if not netId or netId == 0 then return end
    busy = true
    local available = lib.callback.await('av_union:validTrolley', math.random(10,500), netId)
    if available then
        inAnimation = true
        lib.hideTextUI()
        Grab2clear = false
        Grab3clear = false
        Money = currentTrolley
        local ped = PlayerPedId()
        local function grabMoney()
            local pedCoords = GetEntityCoords(ped)
            lib.requestModel('hei_prop_heist_cash_pile')
            local cashPile = CreateObject(`hei_prop_heist_cash_pile`, pedCoords, true)
            FreezeEntityPosition(cashPile, true)
            SetEntityInvincible(cashPile, true)
            SetEntityNoCollisionEntity(cashPile, ped)
            SetEntityVisible(cashPile, false, false)
            AttachEntityToEntity(cashPile, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
            local startedGrabbing = GetGameTimer()
            Citizen.CreateThread(function()
                while GetGameTimer() - startedGrabbing < 37000 do
                    Citizen.Wait(1)
                    DisableControlAction(0, 73, true)
                    if HasAnimEventFired(ped, `CASH_APPEAR`) then
                        if not IsEntityVisible(cashPile) then
                            SetEntityVisible(cashPile, true, false)
                        end
                    end
                    if HasAnimEventFired(ped, `RELEASE_CASH_DESTROY`) then
                        if IsEntityVisible(cashPile) then
                            SetEntityVisible(cashPile, false, false)                   
                        end
                    end
                end
                DeleteObject(cashPile)
                TriggerServerEvent("union:MakeItRain")
                currentTrolley = nil
            end)
        end
        if IsEntityPlayingAnim(Money, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
            return
        end
        lib.requestModel('hei_p_m_bag_var22_arm_s')
        lib.requestModel('hei_prop_hei_cash_trolly_03')
        lib.requestAnimDict('anim@heists@ornate_bank@grab_cash')
        while not NetworkHasControlOfEntity(Money) do
            Citizen.Wait(1)
            NetworkRequestControlOfEntity(Money)
        end
        GrabBag = CreateObject(`hei_p_m_bag_var22_arm_s`, GetEntityCoords(PlayerPedId()), true, false, false)
        Grab1 = NetworkCreateSynchronisedScene(GetEntityCoords(Money), GetEntityRotation(Money), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, Grab1, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(GrabBag, Grab1, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
        SetPedComponentVariation(ped, 5, 0, 0, 0)
        NetworkStartSynchronisedScene(Grab1)
        Citizen.Wait(1500)
        grabMoney()
        if not Grab2clear then
            Grab2 = NetworkCreateSynchronisedScene(GetEntityCoords(Money), GetEntityRotation(Money), 2, false, false, 1065353216, 0, 1.3)
            NetworkAddPedToSynchronisedScene(ped, Grab2, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(GrabBag, Grab2, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
            NetworkAddEntityToSynchronisedScene(Money, Grab2, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
            NetworkStartSynchronisedScene(Grab2)
            Citizen.Wait(37000)
        end
        if not Grab3clear then
            Grab3 = NetworkCreateSynchronisedScene(GetEntityCoords(Money), GetEntityRotation(Money), 2, false, false, 1065353216, 0, 1.3)
            NetworkAddPedToSynchronisedScene(ped, Grab3, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(GrabBag, Grab3, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
            NetworkStartSynchronisedScene(Grab3)
            TriggerServerEvent('av_union:deleteTrolley', netId)
        end
        Citizen.Wait(1800)
        if DoesEntityExist(GrabBag) then
            DeleteEntity(GrabBag)
        end
        SetPedComponentVariation(ped, 5, 45, 0, 0)
    end
    inAnimation = false
    busy = false
end)