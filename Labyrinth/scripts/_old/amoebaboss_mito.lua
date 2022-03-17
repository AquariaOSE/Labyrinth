
if not v then v = {} end
if not AQUARIA_VERSION then dofile("scripts/entities/entityinclude.lua") end


function init(me)
	setupEntity(me)
	entity_setEntityType(me, ET_NEUTRAL)
    
    entity_setTexture(me, "amb-mito")
    entity_scale(me, 0.3, 0.3)
    
    esetv(me, EV_LOOKAT, false)
	
	entity_setAllDamageTargets(me, false)
    entity_setUpdateCull(me, -1)
	
	entity_setCollideRadius(me, 40)
	
	entity_setCanLeaveWater(me, false)
end



function postInit(me)
end

function update(me, dt)
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

