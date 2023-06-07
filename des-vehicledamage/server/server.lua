-- Define a variable to store the previous health of each vehicle
local previousHealth = {}

-- Damage modifiers for different types of damage
local damageModifiers = {
    [1] = 0.5, -- Collision damage modifier
    [GetHashKey("WEAPON_PISTOL")] = 1.0, -- Bullet damage modifier for pistol
    [GetHashKey("WEAPON_SMG")] = 1.5, -- Bullet damage modifier for SMG
}

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

                local damageModifier = 1.0 -- Default damage modifier

                -- Check if a specific damage modifier exists for the damage type
                if damageModifiers[damageType] ~= nil then
                    damageModifier = damageModifiers[damageType]
                elseif damageModifiers[weaponHash] ~= nil then
                    damageModifier = damageModifiers[weaponHash]
                end

                -- Apply the damage modifier to the damage amount
                local modifiedDamage = damageAmount * damageModifier

                -- Handle the modified damage here based on the type of damage
                if damageType == 1 then
                    -- Collision damage
                    print("Vehicle collided with an object. Damage: " .. modifiedDamage)
                elseif weaponHash == GetHashKey("WEAPON_PISTOL") or weaponHash == GetHashKey("WEAPON_SMG") then
                    -- Bullet damage
                    print("Vehicle was shot by a player. Damage: " .. modifiedDamage)
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
