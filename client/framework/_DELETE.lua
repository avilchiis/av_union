local sin, cos, atan2, abs, rad, deg = math.sin, math.cos, math.atan2, math.abs, math.rad, math.deg
local test_object

function SpawnTestObj(name)
    if not name then return end
    while DoesEntityExist(test_object) do
        DeleteEntity(test_object)
        Wait(50)
    end
    test_object = nil
    local model = GetHashKey(name)
    lib.requestModel(model, 5000)
    local myCoords = GetEntityCoords(PlayerPedId())
    test_object = CreateObject(model, myCoords.x, myCoords.y, myCoords.z, false, false, false)
    SetEntityCollision(test_object,false,false)
    SetEntityAlpha(test_object,125)
end

local textUI = {}

function Marker(data)
	local opciones = data
    local player = PlayerPedId()
	while true do
		local hit, pos, entity, _ = RayCastGamePlayCamera(opciones['distance'], opciones['type'])
		local x, y, z = table.unpack(pos)
        local xdist = x
        local ydist = y
        local zdist = z
        local text = ""
        if not test_object then
            local player_heading = (GetEntityHeading(test_shell) - GetEntityHeading(player))
            text = "~b~X: ~w~"..xdist.." ~b~Y: ~w~"..ydist.." ~b~Z: ~w~"..zdist.." ~b~Heading: ~w~"..player_heading
        else
            local obj_heading = (GetEntityHeading(test_shell) - GetEntityHeading(test_object))
            text = "~b~X: ~w~"..xdist.." ~b~Y: ~w~"..ydist.." ~b~Z: ~w~"..zdist.." ~b~Heading: ~w~"..obj_heading
        end
		DrawText3D(x, y, z + 0.5, text)
		Marca(pos, opciones['radius'], 0, 0, 255, 35)
		if hit == 1 then
			Marca(pos, opciones['radius'], 0, 255, 0, 35)
		end
		if IsControlJustPressed(0,opciones['keyExit']) then
            lib.hideTextUI()
            return
		end
		if IsControlPressed(0,73) and test_object then
			while DoesEntityExist(test_object) do
                DeleteEntity(test_object)
                Wait(10)
            end
            test_object = nil
		end
		if IsControlPressed(0,175) and test_object then
			SetEntityHeading(test_object, GetEntityHeading(test_object) + 0.15)
		end
		if IsControlPressed(0,174) and test_object then
			SetEntityHeading(test_object, GetEntityHeading(test_object) - 0.15)
		end
		if IsControlJustPressed(0,172) then
			opciones['distance'] = opciones['distance'] + 0.25
		end
		if IsControlJustPressed(0,173) then
			opciones['distance'] = opciones['distance'] - 0.25
		end
		Citizen.Wait(0)
	end
end

function Marca(pos, radius, r, g, b, a)
	DrawMarker(1, pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, radius, radius, 0.15, r, g, b, a, false, false, 2, nil, nil, false)
    if test_object then
        SetEntityCoords(test_object, pos.x, pos.y, pos.z, false, false, false, false)
    end
end

function RayCastGamePlayCamera(dist, tipo)
    local camRot = GetGameplayCamRot()
    local camPos = GetGameplayCamCoord()
    local dir = RotationToDirection(camRot)
    local dest = camPos + (dir * dist)
    local ray = StartExpensiveSynchronousShapeTestLosProbe(camPos, dest, tipo, PlayerPedId(), 0)
    local _, hit, endPos, surfaceNormal, entityHit = GetShapeTestResult(ray)
    if hit == 0 then endPos = dest end
    return hit, endPos, entityHit, surfaceNormal
end

function RotationToDirection(rot)
    local rotZ = rad(rot.z)
    local rotX = rad(rot.x)
    local cosOfRotX = abs(cos(rotX))
    return vector3(-sin(rotZ) * cosOfRotX, cos(rotZ) * cosOfRotX, sin(rotX))
end

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function Round(value, numDecimalPlaces)
    if not numDecimalPlaces then return math.floor(value + 0.5) end
    local power = 10 ^ numDecimalPlaces
    return math.floor((value * power) + 0.5) / (power)
end

RegisterCommand('mark', function()
    local options = {
        type = 1,
        distance = 5,
        radius = 0.5,
        keySelect = 38,
        keyExit = 74,
        text3d = true,
        text = '~b~[H]~w~ Exit',
    }
    Marker(options)
end)