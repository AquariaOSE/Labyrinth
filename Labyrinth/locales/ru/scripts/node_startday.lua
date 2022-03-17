if not v then v = {} end
if not AQUARIA_VERSION then dofile("scripts/entities/entityinclude.lua") end

dofile(appendUserDataPath("_mods/Labyrinth/scripts/flags.lua"))

v.n = 0

function init(me)
	v.n = getNaija()
end


function update(me, dt)

	--Display once if Naija enters
	if isFlag(TEXT_START, 0) and node_isEntityIn(me, v.n) then
		setFlag(TEXT_START, 1)
		setControlHint("ћмм, что мне сделать этим утром? Ћи пребывает на поверхности и, возможно, вернетс€ не ранее, чем через несколько дней. ћожет, у мен€ получитс€ открыть тот заблокированный проход в старый лабиринт? Ќадо бы мне освежить знание песен и собрать побольше еды...", 0, 0, 0, 12)
	end 

end
