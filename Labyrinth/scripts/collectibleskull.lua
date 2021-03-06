if not v then v = {} end

-- song cave collectible

--dofile("scripts/include/collectibletemplate.lua")
dofile(appendUserDataPath("_mods/Labyrinth/scripts/collectibletemplate.lua"))

function init(me)
	v.commonInit(me, "Collectibles/skull", FLAG_COLLECTIBLE_SKULL)
end

function update(me, dt)
	v.commonUpdate(me, dt)
end

function enterState(me, state)
	v.commonEnterState(me, state)
	if entity_isState(me, STATE_COLLECTEDINHOUSE) then
		--ent = createEntity("PullPlantNormal", "", entity_x(me)-100, entity_y(me)+220)
		--entity_rotate(ent, entity_getRotation(ent)-35)
	end	
end

function exitState(me, state)
	v.commonExitState(me, state)
end
