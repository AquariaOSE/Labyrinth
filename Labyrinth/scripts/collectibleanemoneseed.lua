
if not v then v = {} end

-- song cave collectible

--dofile("scripts/include/collectibletemplate.lua")
dofile(appendUserDataPath("_mods/Labyrinth/scripts/collectibletemplate.lua"))

function init(me)
	v.commonInit(me, "Collectibles/anemone-seed", FLAG_COLLECTIBLE_ANEMONESEED)
end

function update(me, dt)
	v.commonUpdate(me, dt)
end

function enterState(me, state)
	v.commonEnterState(me, state)
	if entity_isState(me, STATE_COLLECTEDINHOUSE) then
		createEntity("Anemone", "", entity_x(me)+150, entity_y(me)+70)
		createEntity("Anemone", "", entity_x(me)+230, entity_y(me)+100)
		createEntity("Anemone", "", entity_x(me)+60, entity_y(me)+120)
	end	
end

function exitState(me, state)
	v.commonExitState(me, state)
end
