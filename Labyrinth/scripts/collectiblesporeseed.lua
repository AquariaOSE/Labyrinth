if not v then v = {} end

-- song cave collectible

--dofile("scripts/include/collectibletemplate.lua")
dofile(appendUserDataPath("_mods/Labyrinth/scripts/collectibletemplate.lua"))

function init(me)
	v.commonInit(me, "Collectibles/sporeseed", FLAG_COLLECTIBLE_SPORESEED)
end

function update(me, dt)
	v.commonUpdate(me, dt)
end

function enterState(me, state)
	v.commonEnterState(me, state)
	if entity_isState(me, STATE_COLLECTEDINHOUSE) then
		createEntity("SporePlant", "", entity_x(me)+50, entity_y(me))
	end	
end

function exitState(me, state)
	v.commonExitState(me, state)
end
