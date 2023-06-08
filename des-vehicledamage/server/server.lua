local previousHealth = {}

function CalculateCollisionDamage(velocity)
    local collisionDamageMultiplier = Config.CollisionDamageMultiplier
    return velocity * collisionDamageMultiplier
end

function HandleVehicleDamage(attacker, weaponHash, damageAmount, damageType, entity)
    if IsEntityAVehicle(entity) then
        local vehicle = Entity(entity)
        local currentHealth = vehicle:GetHealth()

        if previousHealth[entity] then
            if currentHealth < previousHealth[entity] then
                if damageType == 1 then
                    local collisionVelocity = #(previousHealth[entity] - currentHealth)
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

        previousHealth[entity] = currentHealth
    end
end

AddEventHandler("entitydamaged", function(attacker, weaponHash, damageAmount, damageType, entity)
    HandleVehicleDamage(attacker, weaponHash, damageAmount, damageType, entity)
end)

AddEventHandler("playerTargetEntity", function(entity)
    if IsEntityAVehicle(entity) then
        previousHealth[entity] = Entity(entity):GetHealth()
    end
end)
