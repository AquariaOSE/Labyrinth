
if not v then v = {} end
if not AQUARIA_VERSION then dofile("scripts/entities/entityinclude.lua") end

dofile(appendUserDataPath("_mods/Labyrinth/scripts/inc_util.lua"))

v.attractors = 0
v.rft = 0 -- random force timer
--v.origin = 0

v.perp = true
v.pt = 0

-- TODO: move perpendicular to nearest organelle in one direction.
-- that organelle has to push.


-- data = {attractDist, attractMulti, pushDist, pushMulti}
local function addAttractor(e, data)
    v.attractors[e] = data
end

local function checkAttractor(e)
    if entity_isName(e, "amoebaboss_mito") then
        addAttractor(e, { -1, 0, 200, -4} )
    elseif entity_isName(e, "amoebaboss_center") then
        addAttractor(e, { 1000, 0.75, 200, -6 } )
    end
end

local function findAttractors()
    v.attractors = {}
    v.forAllEntities(checkAttractor)
end

local function handlePhysics(me, e, data, dt)
    local vx, vy = entity_getVectorToEntity(me, e)
    local d = vector_getLength(vx, vy)
    
    local am = 1
    --if e == v.origin then
    --    am = 5
    --end
    
    if d < data[1] then -- attract
        local factor = d / data[1] -- attract more when nearer
        local m = dt * factor * data[2]
        entity_addVel(me, vx * m, vy * m)
    end    
    
    if d < data[3] then -- push away
        local factor = data[3] / d -- push more when nearer
        local m = dt * factor * data[4]
        entity_addVel(me, vx * m, vy * m)
    end
end

-- VERY CPU HUNGRY
--[[
local function handleSurfacingAgainst(e, me)
    if not entity_isName(e, "amoebaboss_membranepart") then
        return
    end
    
    if entity_isEntityInRange(me, e, 20) then
end
]]

-- VERY VERY CPU HUNGRY
local function handleSurfacing(me, dt)
    --v.forAllEntities(handleSurfacingAgainst, me)
    local MINDIST = 40
    local e = entity_getNearestEntity(me, "amoebaboss_membranepart", MINDIST)
    if e == 0 then
        return
    end
    local d = entity_getDistanceToEntity(me, e)

    local vx, vy = entity_getVectorToEntity(me, e)
    
    -- HACK: WTF
    if math.abs(vx) + math.abs(vy) < 6 then
        local offs = 45
        entity_setPosition(me, entity_x(me) + math.random(-offs, offs), entity_y(me) + math.random(-offs, offs))
        entity_setPosition(e, entity_x(e) + math.random(-offs, offs), entity_y(e) + math.random(-offs, offs))
        return
    end
    
    
    local factor = (MINDIST / d) * 30 * dt
    
    if v.perp then
        entity_addVel(e, -vy * factor, vx * factor)
        entity_addVel(me, vy * factor, -vx * factor)
    else
        factor = factor * 5
        entity_addVel(e, vx * factor, vy * factor)
        --entity_addVel(me, vx * factor, vy * factor)
    end
end

function init(me)
	setupEntity(me)
	entity_setEntityType(me, ET_NEUTRAL)
    
    entity_setTexture(me, "test/membranepart")
    --entity_scale(me, 0.4, 0.4)
    esetv(me, EV_LOOKAT, false)
	entity_setAllDamageTargets(me, false)
    entity_setDamageTarget(me, DT_AVATAR_ENERGYBLAST, true) -- that it can be injured with the urchin suit
    entity_setUpdateCull(me, -1)
	entity_setCollideRadius(me, 30)
	entity_setCanLeaveWater(me, false)
    entity_setMaxSpeed(me, 110)
    
    --v.origin = entity_getNearestEntity(me, "amoebaboss_mito")
end


function postInit(me)
    findAttractors()
end

function update(me, dt)
    for e, data in pairs(v.attractors) do
        handlePhysics(me, e, data, dt)
    end
    
    handleSurfacing(me, dt)
    
    
    entity_updateMovement(me, dt)
    
    --if v.rft >= 0 then
    --    v.rft = v.rft - dt
    --    if v.rft <= 0 then
    --        v.rft = 0.1
            entity_addRandomVel(me, 70 * dt)
    --    end
    --end
    
    
    --[[
    if v.pt >= 0 then
        v.pt = v.pt - dt
        if v.pt <= 0 then
            v.pt = 1
            v.perp = not v.perp
        end
    end
    ]]
end

function enterState(me)
end

function exitState(me)
end

function msg(me, msg)
end

function damage(me, attacker, bone, damageType, dmg)
	return false
end

function animationKey(me, key)
end

function hitSurface(me)
end

function songNote(me, note)
end

function songNoteDone(me, note)
end

function song(me, song)
end

function activate(me)
end

