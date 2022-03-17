if not v then v = {} end
if not AQUARIA_VERSION then dofile("scripts/entities/entityinclude.lua") end

dofile(appendUserDataPath("_mods/Labyrinth/scripts/flags.lua"))

v.n = 0

function init(me)
	v.n = getNaija()
end


function update(me, dt)

	--Display once if Naija enters
	if isFlag(MINEOCTOBOSS_DONE, 0) and isFlag(KUIRLIN_BABIES, 0) and node_isEntityIn(me, v.n) then
		setFlag(KUIRLIN_BABIES, 1)
		setControlHint("ќй, детска€! јй! ƒетки тут, как минимум, не гостеприимны. Ћучше € поплыву...", 0, 0, 0, 10)
	end 

end
