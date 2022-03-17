if not v then v = {} end

-- mithalas collectible: crab costume

--dofile("scripts/include/collectiblecostumetemplate.lua")
dofile(appendUserDataPath("_mods/Labyrinth/scripts/collectiblecostumetemplate.lua"))

function init(me)
	v.commonInit2(me, "Collectibles/Jelly-Costume", FLAG_COLLECTIBLE_JELLYCOSTUME, "jelly")
end
