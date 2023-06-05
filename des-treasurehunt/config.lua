

Config = {}

-- Quests configuration
Config.Quests = {
    {
        name = 'Quest 1',
        objective = 'Find the ancient artifact',
        reward = 'Ancient Artifact',
        clue = 'The treasure is hidden near the old oak tree.'
    },
    -- Add more quests here
}

-- Timer configuration (in seconds)
Config.ClueTimer = 60 -- Time interval to give clues to players
Config.EventTimer = 180 -- Time interval for events (e.g., treasure respawn)

-- Treasure configuration
Config.Treasures = {
    { x = 100.0, y = -200.0, z = 10.0 },
    -- Add more treasure locations here
}

-- Blip configuration
Config.BlipSprite = 476 -- Blip sprite (customize as needed)
Config.BlipColor = 5 -- Blip color (customize as needed)

-- Interaction key configuration
Config.InteractionKey = 38 -- Default: E (customize as needed)
