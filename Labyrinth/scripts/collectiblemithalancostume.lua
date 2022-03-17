if not v then v = {} end

-- mithalas collectible: mithalan costume

--dofile("scripts/include/collectiblecostumetemplate.lua")
dofile(appendUserDataPath("_mods/Labyrinth/scripts/collectiblecostumetemplate.lua"))

function init(me)
	v.commonInit2(me, "Collectibles/mithalan-costume", FLAG_COLLECTIBLE_MITHALANCOSTUME, "MITHALAN")
end
