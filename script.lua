-- \\ you need to have miss sounds on mods/sounds
-- \\ you also need a character that has miss sprites
nps = 9

-- \\ the fun part
function onCreate()
    --Iterate over all notes
    for i = 0, getProperty("unspawnNotes.length") - 1 do
        if math.random(1, (32 / (nps / 4))) == 1 then
            setPropertyFromGroup("unspawnNotes", i, "ignoreNote", true) --Miss has no penalties
        end
    end
end

function onBeatHit()
    if nps ~= 0 then
        nps = nps - 1
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if math.random(1, (32 / (nps / 4))) == 1 then
        if not isSustainNote then
            if getProperty("health") > 0.001 then
                setProperty("health", getProperty("health") + 0.03)
            end
            if direction == 0 then
                characterPlayAnim("dad", "singLEFTmiss", true)
            elseif direction == 1 then
                characterPlayAnim("dad", "singDOWNmiss", true)
            elseif direction == 2 then
                characterPlayAnim("dad", "singUPmiss", true)
            elseif direction == 3 then
                characterPlayAnim("dad", "singRIGHTmiss", true)
            end
            stopAnimTimer = 0
            targetTime = stepCrochet * 0.001 * getProperty("dad.singDuration")
            if math.random(1, 3) == 1 then
                playSound("missnote1", 0.5)
            elseif math.random(1, 3) == 2 then
                playSound("missnote2", 0.5)
            elseif math.random(1, 3) == 3 then
                playSound("missnote3", 0.5)
            end
        end
    else
        if getProperty("health") > 0.001 then
            setProperty("health", getProperty("health") - 0.03)
        end
        nps = nps + 1
    end
end
