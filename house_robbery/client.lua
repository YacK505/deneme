local QBCore = exports['qb-core']:GetCoreObject()
local insideHouse = false
local currentHouseIndex = nil
local noiseLevel = 0

local function DrawNoiseBar()
    if not insideHouse then return end
    local x, y = 0.12, 0.95
    local w, h = 0.15, 0.02
    DrawRect(x, y, w, h, 0, 0, 0, 180)
    local progress = math.min(noiseLevel / Config.NoiseThreshold, 1.0)
    if progress > 0 then
        DrawRect(x - w/2 + (progress * w) / 2, y, progress * w, h, 255, 0, 0, 180)
    end
end


local function StartRobbery(index, house)
    local ped = PlayerPedId()
    SetEntityCoords(ped, house.interior.xyz)
    SetEntityHeading(ped, house.interior.w)
    insideHouse = true
    noiseLevel = 0
    currentHouseIndex = index
    exports['ox_lib']:notify({description = 'You entered the house. Search for valuables.', type = 'success'})
end

RegisterNetEvent('houseRobbery:useLockpick', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    for i, house in ipairs(Config.Houses) do
        if #(pos - house.entrance) < 1.5 then
            -- placeholder lockpick mini game
            local success = exports['ox_lib']:lockpick(2500)
            if success then
                StartRobbery(i, house)
            else
                exports['ox_lib']:notify({description = 'Lockpick failed', type = 'error'})
            end
            return
        end
    end
    exports['ox_lib']:notify({description = 'You are not at a house door', type = 'error'})
end)

-- handle loot spots when inside the house
CreateThread(function()
    while true do
        if insideHouse then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local show = false
            for i, lootPos in ipairs(Config.LootSpots) do
                if #(pos - lootPos) < 1.2 then
                    if not show then
                        exports['ox_lib']:showTextUI('[E] Search')
                        show = true
                    end
                    if IsControlJustReleased(0, 38) then
                        exports['ox_lib']:hideTextUI()
                        show = false
                        insideHouse = false
                        TriggerServerEvent('houseRobbery:lootSpot', currentHouseIndex, i)
                        if exports['ox_lib']:progressBar({duration = Config.SearchDuration, label = 'Searching...'}) then
                            insideHouse = true
                            noiseLevel = noiseLevel + Config.NoisePerSearch
                            if noiseLevel >= Config.NoiseThreshold then
                                TriggerServerEvent('houseRobbery:alertPolice', currentHouseIndex)
                                noiseLevel = Config.NoiseThreshold
                            end
                        else
                            insideHouse = true
                        end
                    end
                    break
                end
            end
            if not show then
                exports['ox_lib']:hideTextUI()
            end
            DrawNoiseBar()
        end
        Wait(0)
    end
end)
