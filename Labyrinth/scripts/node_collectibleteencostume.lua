if not v then v = {} end

--dofile("scripts/include/nodecollectibletemplate.lua")
dofile(appendUserDataPath("_mods/Labyrinth/scripts/nodecollectibletemplate.lua"))

function init(me)
	v.commonInit(me, "CollectibleTeenCostume", FLAG_COLLECTIBLE_TEENCOSTUME)
end

function update(me, dt)
end
