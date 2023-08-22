QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('billing:client:open', function()
    local PlayerJob = QBCore.Functions.GetPlayerData().job.name
    local vm = {
        {
            header = "開單系統",
            isMenuHeader = true,
        },
        {
            header = "進入選單",
            txt = "點擊進入開單選單系統",
            params = {
                event = "billing:client:menu",
                args = {
                    type = PlayerJob
                }
            }
        }
    }
    exports['qb-menu']:openMenu(vm)
end)

RegisterNetEvent('billing:client:menu', function(Data)
    local job = Data.type
    local billing = {
        {
            header = "開單選單",
            isMenuHeader = true,
        }
    }
    for i, k in pairs(Config.Items[job]) do
        billing[#billing + 1] = {
            header = k.name,
            txt = "$"..k.price,
            params = {
                event = "billing:client:action",
                args = {
                    name = k.name,
                    reason = k.reason,
                    price = k.price
                }
            }
        }
    end
    exports['qb-menu']:openMenu(billing)
end)

RegisterNetEvent('billing:client:action', function(Data)
    local name, price, reason = Data.name, Data.price, Data.reason
    local target = QBCore.Functions.GetClosestPlayer()
    TriggerServerEvent('QBCore:CallCommand', 'billing', GetPlayerServerId(target), tonumber(price), reason)
end)
