if not v then v = {} end
if not AQUARIA_VERSION then dofile("scripts/entities/entityinclude.lua") end

dofile(appendUserDataPath("_mods/Labyrinth/scripts/flags.lua"))

v.showingStats = false

function v.countSongs()
    local c = 0
    if hasSong(SONG_BIND) then c = c + 1 end
    if hasSong(SONG_SHIELD) then c = c + 1 end
    if hasSong(SONG_ENERGYFORM) then c = c + 1 end
    if hasSong(SONG_BEASTFORM) then c = c + 1 end
    if hasSong(SONG_NATUREFORM) then c = c + 1 end
    if hasSong(SONG_SUNFORM) then c = c + 1 end
    if hasSong(SONG_FISHFORM) then c = c + 1 end
    if hasSong(SONG_SPIRITFORM) then c = c + 1 end
    if hasSong(SONG_DUALFORM) then c = c + 1 end
    return c
end

function v.countTreasures()
    return getFlag(FLAG_THINGS_COLLECTED)
end

function v.countDriftPearls()
    return getFlag(FLAG_DRIFTPEARLS_COLLECTED)
end

function v.countCostumes()
    return getFlag(FLAG_COSTUMES_COLLECTED)
end

function v.countVerseEggs()
    -- HACK: instead of using FLAG_HEALTHUPGRADES + x, use max health:
    local n = getNaija()
    local maxhp = entity_getHealth(n) / entity_getHealthPerc(n)
    maxhp = math.floor(maxhp + 0.1) -- against rounding errors
    return maxhp - 5 -- we start with 5 health, the rest is verse eggs
end

function v.showStats(ending)
    if v.showingStats then
        return
    end
    v.showingStats = true
    local func
    if ending then
        func = watch
    else
        func = wait
    end
    
    local t
    local txt
    if ending then
        txt = "Поздравляем! Вы нашли:"
        t = 3
    else
        txt = "Вы нашли следующие сокровища:"
        t = 1.5
    end
    setControlHint(txt, 0, 0, 0, 2, "collectibles/treasure-chest", nil, 0.3) func(2)
    setControlHint(v.countSongs() .. " из 7 песен,", 0, 0, 0, t, "song/songslot-4", nil, 0.9) func(t)
    setControlHint(v.countTreasures() .. " из 16 сокровищ,", 0, 0, 0, t, "collectibles/goldstar", nil, 0.7) func(t)
    setControlHint(v.countCostumes() .. " из 8 костюмов,", 0, 0, 0, t, "collectibles/energytemple") func(t)
    setControlHint(v.countVerseEggs() .. " из 5 яиц Песни,", 0, 0, 0, t, "healthupgrade/whole", nil, 0.65) func(t)
    setControlHint(v.countDriftPearls() .. " из 9 песенных камней.", 0, 0, 0, t, "driftpearl4", nil, 0.5) func(t)
    
    v.showingStats = false
end