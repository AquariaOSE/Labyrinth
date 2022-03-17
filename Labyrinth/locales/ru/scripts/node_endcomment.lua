if not v then v = {} end
if not AQUARIA_VERSION then dofile("scripts/entities/entityinclude.lua") end

dofile(appendUserDataPath("_mods/Labyrinth/scripts/inc_stats.lua"))

v.li = 0
v.isendcomment = false
v.incut = false


function init(me)
    --create Li on map
    -- DO NOT SET FLAG OR setLi() !!

    if hasSong(SONG_FISHFORM) then
    
        local oldli = getFlag(FLAG_LI)
        -- HACK: need this flag to make him show up without helmet when created.
        -- not changing the original Li script and copying it into the mod now
        -- because i'm a lazy bum -- FG
        setFlag(FLAG_LI, 100)
        local li = getEntity("Li")
        if li == 0 then
            v.li = createEntity("Li", "", node_x(me), node_y(me))
        else
            v.li = li
            if not isFlag(FLAG_ENDING, 2) then
                entity_setPosition(v.li, node_x(me), node_y(me))
            end
        end
        
        entity_fh(v.li)
        
        -- HACK: fix back
        setFlag(FLAG_LI, oldli)
    end

end


function update(me, dt)
	--Display once if learned fish song and Naija enters
    local n = getNaija()
	if not v.incut and isFlag(TEXT_END, 0) and hasSong(SONG_FISHFORM) and node_isEntityIn(me, n) and v.li ~= 0 then
        setFlag(TEXT_END, 1)
        
        v.incut = true
        setCutscene(1, 1)
        
        setControlHint("Ли, ты дома! Как я рада тебя видеть! Ты не поверишь, сколько всего я открыла под руинами старого лабиринта! Ну и денек!", 0, 0, 0, 10)
        wait(4) -- give the player time to swim nearby
        
        if not entity_isEntityInRange(n, v.li, 170) then
            entity_swimToPosition(n, entity_getPosition(v.li))
            while entity_isFollowingPath(n) do
                watch(FRAME_TIME)
            end
        end
        
        if not isForm(FORM_NORMAL) then
            changeForm(FORM_NORMAL)
        end
        
        setOverrideMusic("licave")
        updateMusic()
        
        entity_rotate(n, 0, 0.3) -- WTF
        watch(0.3)
        debugLog("reached Li")
        overrideZoom(1.4, 8)
        entity_msg(v.li, "forcehug")
        watch(7) -- there is already a watch while hugging, imho
        debugLog("hug done")
        
        v.showStats(true)
        
        overrideZoom(0)
        v.incut = false
        setCutscene(0)
        debugLog("endcomment done")
        
        fade2(0, 0)
        fade2(1, 4)
        watch(4)
        
        -- show credits roll, starts there.
        fade2(0, 3)
        learnSong(SONG_LI)
        setFlag(FLAG_LI, 100)
        setFlag(FLAG_ENDING, 1)
        -- disable scenes that make no sense anymore at this point
        setFlag(DRIFT_PEARL, 1)
        setFlag(LI_SUB, 1)
        
        loadMap("labyrinth_wheel")
	end 
end
