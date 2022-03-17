if not v then v = {} end
if not AQUARIA_VERSION then dofile("scripts/entities/entityinclude.lua") end

dofile(appendUserDataPath("_mods/Labyrinth/scripts/flags.lua"))

v.n = 0

function init(me)
	v.n = getNaija()
end


function update(me, dt)

	--Display once if Naija enters
	if isFlag(KUIRLIN_MYTH, 0) and node_isEntityIn(me, v.n) then
		setFlag(KUIRLIN_MYTH, 6)
		setControlHint("Это должны быть керлины! Я считала, что они - лишь выдумка. А они явно не слишком дружелюбны!", 0, 0, 0, 10)
	end 

end
