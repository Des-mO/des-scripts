-- Client-side Treasure Hunt Script

local currentQuest = nil  -- Stores the current active quest for the player

-- Register event to start a quest
RegisterNetEvent('startQuest')
AddEventHandler('startQuest', function(questData)
    -- Handle starting the quest on the client-side
    -- Example: Display quest details in the UI or chat
    TriggerEvent('chat:addMessage', { args = { 'Treasure Hunt', 'A new quest has started!' } })
    TriggerEvent('chat:addMessage', { args = { 'Treasure Hunt', 'Quest: ' .. questData.name } })
    TriggerEvent('chat:addMessage', { args = { 'Treasure Hunt', 'Objective: ' .. questData.objective } })
end)


-- Event handler for completing a quest
RegisterNetEvent('completeQuest')
AddEventHandler('completeQuest', function()
    TriggerEvent('chat:addMessage', { args = { 'Treasure Hunt', 'Congratulations! You completed the quest!' } })
    TriggerEvent('chat:addMessage', { args = { 'Treasure Hunt', 'You found: ' .. currentQuest.reward } })
    currentQuest = nil
end)

-- Event handler for receiving a clue
RegisterNetEvent('receiveClue')
AddEventHandler('receiveClue', function(clue)
    TriggerEvent('chat:addMessage', { args = { 'Treasure Hunt', 'New clue received: ' .. clue } })
end)

-- Event handler for interaction with treasure
RegisterNetEvent('interactTreasure')
AddEventHandler('interactTreasure', function(treasure)
    TriggerEvent('chat:addMessage', { args = { 'Treasure Hunt', 'You found the treasure: ' .. treasure } })
end)

-- Example: Trigger events to simulate gameplay
Citizen.CreateThread(function()
    -- Simulate starting a quest
    TriggerEvent('startQuest', {
        name = 'Quest 1',
        objective = 'Find the ancient artifact',
        reward = 'Ancient Artifact'
    })

    -- Simulate receiving a clue
    TriggerEvent('receiveClue', 'The treasure is hidden near the old oak tree.')

    -- Simulate interacting with a treasure
    TriggerEvent('interactTreasure', 'Ancient Artifact')

    -- Simulate completing the quest
    TriggerEvent('completeQuest')
end)
