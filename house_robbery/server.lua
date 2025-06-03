local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('houseRobbery:lootSpot', function(houseIndex, spotIndex)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local loot = Config.LootItems[math.random(#Config.LootItems)]
    if loot.type == 'money' then
        local amount = math.random(loot.min, loot.max)
        Player.Functions.AddMoney(loot.account, amount)
        TriggerClientEvent('ox_lib:notify', src, {description = 'You found $' .. amount, type = 'success'})
    elseif loot.type == 'item' and QBCore.Shared.Items[loot.name] then
        local amount = math.random(loot.min, loot.max)
        if Player.Functions.AddItem(loot.name, amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[loot.name], 'add')
            TriggerClientEvent('ox_lib:notify', src, {description = 'You found ' .. amount .. 'x ' .. loot.name, type = 'success'})
        end
    end
end)

RegisterNetEvent('houseRobbery:alertPolice', function(houseIndex)
    for _, id in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(id)
        if Player and Player.PlayerData.job and Player.PlayerData.job.name == 'police' then
            TriggerClientEvent('ox_lib:notify', id, {description = 'House robbery reported!', type = 'error'})
        end
    end
end)
