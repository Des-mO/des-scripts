-- Define a variable to store the previous health of each vehicle
local previousHealth = {}

-- Function to calculate collision damage based on velocity
function CalculateCollisionDamage(velocity)
    -- Retrieve the configuration values from the configuration file
    local minimumCollisionVelocity = Config.MinimumCollisionVelocity
    local collisionDamageMultiplier = Config.CollisionDamageMultiplier

    -- Calculate the collision damage based on the velocity and the configured multiplier
    local collisionDamage = velocity * collisionDamageMultiplier
    return collisionDamage
end

-- Function to handle vehicle damage
function HandleVehicleDamage(attacker, weaponHash, damageAmount, damageType, entity)
    if IsEntityAVehicle(entity) then
        local vehicle = Entity(entity)
        local currentHealth = vehicle:GetHealth()

        -- Check if the vehicle has previous health recorded
        if previousHealth[entity] ~= nil then
            local previous = previousHealth[entity]

            -- Compare the current health with previous health to determine the damage type
            if currentHealth < previous then
                -- Vehicle has taken damage

                -- Collision damage
                if damageType == 1 then
                    -- Calculate the collision velocity
                    local collisionVelocity = #(previous - currentHealth)

                    -- Check if collision velocity exceeds the minimum threshold
                    if collisionVelocity > Config.MinimumCollisionVelocity then
                        local collisionDamage = CalculateCollisionDamage(collisionVelocity)

                        -- Handle collision damage here
                        print("Vehicle collided with an object. Damage: " .. collisionDamage)
                    end
                end

                -- Bullet damage
                if weaponHash == GetHashKey("WEAPON_PISTOL") or weaponHash == GetHashKey("WEAPON_SMG") then
                    -- Handle bullet damage here
                    print("Vehicle was shot by a player. Damage: " .. damageAmount)
                end
            end
        end

        -- Update previous health with current health for next iteration
        previousHealth[entity] = currentHealth
    end
end

-- Event handler for vehicle damage
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()

        -- Check if the player is aiming at a vehicle
        if IsPlayerFreeAiming(playerPed) then
            local isAiming, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())

            -- Check if the entity being aimed at is a vehicle
            if isAiming and IsEntityAVehicle(entity) then
                local vehicle = Entity(entity)

                -- Store the initial health of the vehicle for comparison
                previousHealth[entity] = vehicle:GetHealth()
            end
        end
    end
end)

-- Register the vehicle damage event
AddEventHandler("entitydamaged", HandleVehicleDamage)
