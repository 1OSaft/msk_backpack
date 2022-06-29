ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

if Config.BagInventory:match('secondary') then
    RegisterCommand('openbag', function()
        for k,v in pairs(Config.Bags) do
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                if not IsPlayerDead(PlayerId()) then
                    if skin.bags_1 == v then
                        ESX.TriggerServerCallback('inventory:getUserData', function(name, identifier)
                            --print('name: '..name)
                            --print('identifier: '..identifier)
                            OpenInventory({
                                id = identifier, -- id = identifier .. ':' .. skin.bags_1
                                type = 'bag',
                                title = '🎒 '.. name,
                                weight = Config.BagWeight,
                                save = true
                            })
                        end)
                    else
                        TriggerEvent('inventory:notify', 'Du benötigst eine Tasche dafür!', 'error') 
                    end
                else
                    TriggerEvent('inventory:notify', 'Du bist Tot also wieso öffnest du deine Tasche?', 'error')
                end
            end)
        end
    end)

    if Config.Rob then
        RegisterCommand('stealbag', function()
            local player, playerDistance = ESX.Game.GetClosestPlayer()

            if player ~= -1 and playerDistance <= 3.0 then
                local playerPed = GetPlayerPed(player)
                
                if DoesEntityExist(playerPed) then
                    for k,v in pairs(Config.Bags) do
                        ESX.TriggerServerCallback('inventory:getPlayerSkin', function(skin)
                            if skin.bags_1 == v then
                                ESX.TriggerServerCallback('inventory:getTargetData', function(name, identifier)
                                    if IsEntityDead(playerPed) then
                                        TriggerServerEvent('inventory:updateStealInventoryBag', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
                                        
                                        OpenInventory({
                                            id = identifier,
                                            type = 'bag',
                                            title = '🎒 '.. name,
                                            weight = Config.BagWeight,
                                            delay = Config.RobTimeout
                                        })

                                        LoadAnimDict("random@mugging5", function()
                                            TaskPlayAnim(PlayerPedId(), "random@mugging5", "ig_1_guy_handoff", 8.0, 8.0, -1, 50, 0, false, false, false)
                                            Wait(2000)
                                            ClearPedTasks(PlayerPedId())
                                        end) 
                                    else 
                                        if IsEntityPlayingAnim(playerPed, "missminuteman_1ig_2", "handsup_enter", 3) then
                                            TriggerServerEvent('inventory:updateStealInventoryBag', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
                                            
                                            OpenInventory({
                                                id = identifier,
                                                type = 'bag',
                                                title = '🎒 '.. name,
                                                weight = Config.BagWeight,
                                                delay = Config.RobTimeout
                                            })

                                            LoadAnimDict("random@mugging5", function()
                                                TaskPlayAnim(PlayerPedId(), "random@mugging5", "ig_1_guy_handoff", 8.0, 8.0, -1, 50, 0, false, false, false)
                                                Wait(2000)
                                                ClearPedTasks(PlayerPedId())
                                            end) 
                                        else
                                            TriggerEvent('inventory:notify', 'Spieler hat sich noch nicht ergeben', 'error') 
                                        end 
                                    end
                                end, GetPlayerServerId(player))
                            else
                                TriggerEvent('inventory:notify', 'Der Spieler hat keine Tasche!', 'error') 
                            end
                        end, GetPlayerServerId(player))
                    end

                    while true do 
                        Wait(1)
                        player, playerDistance = ESX.Game.GetClosestPlayer()

                        if playerDistance > 3.0 then 
                            SendNUIMessage({
                                type = 'close'
                            })    
                            break
                        end
                    end
                end
            else 
                TriggerEvent('inventory:notify', Locales.noPlayersFound, 'error') 
            end
        end)
    end
end

RegisterNetEvent('inventory:openBagViaMenu', function ()
    ExecuteCommand('openbag')
end)

RegisterNetEvent('inventory:openStealBagViaMenu', function ()
    ExecuteCommand('stealbag')
end)