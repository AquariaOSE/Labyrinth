if not v then v = {} end

-- abyss collectible: teen costume

--dofile("scripts/include/collectiblecostumetemplate.lua")
dofile(appendUserDataPath("_mods/Labyrinth/scripts/collectiblecostumetemplate.lua"))

function init(me)
	v.commonInit2(me, "Collectibles/teen-costume", FLAG_COLLECTIBLE_TEENCOSTUME, "TEEN")
end
