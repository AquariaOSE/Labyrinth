if not v then v = {} end

--dofile("scripts/include/nodecollectibletemplate.lua")
dofile(appendUserDataPath("_mods/Labyrinth/scripts/nodecollectibletemplate.lua"))

function init(me)
	
end

function update(me, dt)
	v.commonUpdate(me, "CollectibleStoneHead", FLAG_COLLECTIBLE_STONEHEAD)
end