
-- FG: not used in this mod... i think. Ah well.


if not v then v = {} end

dofile(appendUserDataPath("_mods/Labyrinth/scripts/inc_compat.lua"))

dofile("scripts/inc_cutscene.lua")

v._done = false
v._scene = ""
v._playing = false -- guard against call during watch()
v.delay = false -- supposed to store a number if there is really a delay
v.cutscene = 0
v.init = 0

function init(me)
    node_setCursorActivation(me, v.isDebug())
    v._scene = node_getContent(me)
    
    -- 1.1.1 compatibility -- NO WAIT THIS IS WRONG for 1.1.1
    if v._scene == "" then
        local seting = node_getNearestNode(me, "seting")
        if node_isPositionIn(seting, node_getPosition(me))
            v._scene = node_getContent(seting)
        end
    end
    
    v._done = not node_isFlag(me, 0)
    
    v.nodeDebugVis(me, "youngli/head-shock", 2) -- if it errors out below, this stays
    
    if not (v._scene and v._scene ~= "") then
        centerText("ERROR: node_cutsceneonce: missing scene to play!")
        v._done = true
        return
    end
    
    dofile("scripts/cutscene_" .. v._scene .. ".lua")
    
    if v.init ~= 0 then
        v.init(me)
    end
    
    v.nodeDebugVis(me, v._done, 2)
    
    -- HACK: running cutscenes instantly when the map is loaded in the first 0.5 seconds will prevent
    -- wait() and watch() from blocking, because the game is in its fade in state, and prevents nesting main() deeper.
    -- If it is an instant cutscene, it must be run in init to make it work (don't ask me why it actually works).
    -- (see end of Game::applyState())
    if v.delay and v.delay == 0 then
        fade(0, 0, 0, 0, 0) -- the screen is still black, remove that, so that the cutscene is visible
        debugLog("play once from init")
        v.onUpdate(me, 0) -- fake dt
    end
    
    if v.delay == false then
        v.delay = 0
    end
end

function update(me, dt)

    if v.delay < dt then
        v.delay = 0
        v.onUpdate(me, dt)
    else
        v.delay = v.delay - dt
    end
end

function v.onUpdate(me, dt)
    
    if v._done or v._playing then
        return
    end
    
    --debugLog("play cutscene once: " .. v._scene)
    
    -- return values:
    -- * true: register as played, finished.
    -- * false: do not try again for currently loaded map
    -- * nil: don't play now, but try again on next update
    v._playing = true
    local result = v.cutscene(false, dt)
    v._playing = false
    
    if result == true then
        debugLog("cutscene play once done")
        node_setFlag(me, 1)
        v._done = true
        v.nodeDebugVis(me, true, 2)
    elseif result == false then
        v._done = true
        v.nodeDebugVis(me, "cancel", 1.5)
    elseif result == nil then
        v._done = false
    else
        v._done = true
        debugLog("node_cutsceneonce: bad return for scene " .. v._scene)
        v.nodeDebugVis(me, "black", 1.5)
    end
end

function activate(me)
    if v.isDebug() then
        debugLog("debug play cutscene once: " .. v._scene)
        v._playing = true
        if v.cutscene(true, 0) == nil then
            v._done = false
        end
        v._playing = false
        debugLog("cutscene debug play done")
    end
end

function songNote(me, note)
end

function songNoteDone(me, note, done)
end
