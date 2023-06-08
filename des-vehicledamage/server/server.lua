function CalculateCollisionDamage(velocity)
    local collisionDamageMultiplier = Config.CollisionDamageMultiplier
    return velocity * collisionDamageMultiplier
end

function HandleVehicleDamage(attacker, weaponHash, damageAmount, damageType, entity)
    if IsEntityAVehicle(entity) then
        local vehicle = Entity(entity)
        local currentHealth = GetVehicleBodyHealth(vehicle)

        if currentHealth < 1000 then
            if damageType == 1 then
                local collisionVelocity = (1000 - currentHealth) * 0.1
                if collisionVelocity > Config.MinimumCollisionVelocity then
                    local collisionDamage = CalculateCollisionDamage(collisionVelocity)
                    print("Vehicle collided with an object. Damage: " .. collisionDamage)
                end
            end

            local weaponDamageModifier = Config.WeaponDamageModifiers[weaponHash]
            if weaponDamageModifier then
                local modifiedDamage = damageAmount * weaponDamageModifier
                print("Vehicle was shot by a player. Damage: " .. modifiedDamage)
            end
        end
    end
end

RegisterNetEvent("vehicleDamage")
AddEventHandler("vehicleDamage", function(attacker, weaponHash, damageAmount, damageType, entity)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local playerPed = xPlayer.PlayerData.ped
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local entity = vehicle or playerPed

    HandleVehicleDamage(attacker, weaponHash, damageAmount, damageType, entity)
end)

RegisterCommand("damageVehicle", function(source, args, rawCommand)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local playerPed = xPlayer.PlayerData.ped
    local attacker = playerPed
    local weaponHash = GetSelectedPedWeapon(playerPed)
    local damageAmount = tonumber(args[1])
    local damageType = tonumber(args[2])
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local entity = vehicle or playerPed

    TriggerEvent("vehicleDamage", attacker, weaponHash, damageAmount, damageType, entity)
end)
