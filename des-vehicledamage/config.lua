Config = {}

-- Collision damage
Config.CollisionDamageMultiplier = 0.2 -- Multiplier for collision damage (adjust as needed)
Config.MinimumCollisionVelocity = 5.0 -- Minimum collision velocity to cause damage (adjust as needed)

-- Weapon damage modifiers
Config.WeaponDamageModifiers = {
    [GetHashKey("WEAPON_PISTOL")] = 0.5, -- Pistol damage modifier (adjust as needed)
    [GetHashKey("WEAPON_SMG")] = 0.8, -- SMG damage modifier (adjust as needed)
    [GetHashKey("WEAPON_RIFLE")] = 1.2 -- Rifle damage modifier (adjust as needed)
}
