
-- NO LONGER USED

if not v then v = {} end
if not AQUARIA_VERSION then dofile("scripts/entities/entityinclude.lua") end

v.n = 0
v.myWeight = 0

function init(me, gfx, r)

	setupEntity(me, "driftpearldrop", -1)
	--entity_setProperty(me, EP_MOVABLE, true)
	--entity_setProperty(me, EP_BLOCKER, true)
	v.myWeight = 320
	entity_setCollideRadius(me, 45)
	entity_setBounce(me, 0.2)
	entity_setCanLeaveWater(me, true)
    
    entity_setMaxSpeed(me, 700)
	
	entity_setAllDamageTargets(me, false)
	
	--esetv(me, EV_TYPEID, EVT_ROCK)
    
    esetv(me, EV_LOOKAT, 0)
end

function postInit(me)
	v.n = getNaija()
end

function update(me, dt)
	
	--entity_updateCurrents(me)
	entity_updateMovement(me, dt)
	
	if entity_checkSplash(me) then
	end
	if not entity_isUnderWater(me) then
		if not entity_isBeingPulled(me) then
			entity_setWeight(me, v.myWeight*2)
			entity_setMaxSpeedLerp(me, 5, 0.1)
		end
	else
		entity_setMaxSpeedLerp(me, 1, 0.1)
		entity_setWeight(me, v.myWeight)
	end
	
	
	if not entity_isBeingPulled(me) then
		if entity_touchAvatarDamage(me, entity_getCollideRadius(me), 0) then
			if avatar_isBursting() and entity_setBoneLock(v.n, me) then
				-- yay!
			else
				--[[
				local x, y = entity_getVectorToEntity(me, v.n, 1000)
				entity_addVel(n, x, y)
				]]--
			end
		end
	else
        v.lastvel = 0
		if entity_getBoneLockEntity(v.n) == me then
			avatar_fallOffWall()
		end
	end
	
	entity_handleShotCollisions(me)
end

function damage(me, attacker, bone, damageType, dmg)
	return false
end

function enterState(me)
end

function exitState(me)
end

function hitSurface(me)
end

function activate(me)
end

function songNote(me, note)
end

function songNoteDone(me, note, t)
end

function song(me, s)
end
