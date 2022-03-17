if not v then v = {} end
if not AQUARIA_VERSION then dofile("scripts/entities/entityinclude.lua") end

dofile(appendUserDataPath("_mods/Labyrinth/scripts/flags.lua"))

v.n = 0

function init(me)
	v.n = getNaija()
end


function update(me, dt)

	--Display once if Naija enters
	if isFlag(MINEOCTOBOSS_DONE, 0) and isFlag(EXCUSE_ME, 0) and node_isEntityIn(me, v.n) then
		setFlag(EXCUSE_ME, 1)
		setControlHint("Простите, я видела, что у вас дверь открыта. Ай! Хорошо, я уже ухожу!", 0, 0, 0, 10)
	end 

end