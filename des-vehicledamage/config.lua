Config = {}

-- Minimum collision velocity required to cause damage
Config.MinimumCollisionVelocity = 5.0 -- Adjust this value as desired

-- Collision damage multiplier based on velocity
Config.CollisionDamageMultiplier = 0.2 -- Adjust this value as desired

-- Damage modifiers for different weapon types
-- Modify these values to adjust the damage multipliers for specific weapon types
Config.WeaponDamageModifiers = {
    [GetHashKey("WEAPON_PISTOL")] = 1.0, -- Pistol damage modifier
    [GetHashKey("WEAPON_SMG")] = 1.5 -- SMG damage modifier
}
