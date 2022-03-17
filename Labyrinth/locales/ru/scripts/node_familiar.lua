if not v then v = {} end
if not AQUARIA_VERSION then dofile("scripts/entities/entityinclude.lua") end

dofile(appendUserDataPath("_mods/Labyrinth/scripts/flags.lua"))

v.n = 0

function init(me)
	v.n = getNaija()
end


function update(me, dt)

	--Display once if Naija enters
	if isFlag(FAMILIAR_PLACE, 0) and hasSong(SONG_FISHFORM) and node_isEntityIn(me, v.n) then
		setFlag(FAMILIAR_PLACE, 1)
		setControlHint("Вроде, мне знакомо это место... Ах да, я могу приплыть отсюда домой! И, может быть, Ли уже вернулся!", 0, 0, 0, 10)
	end 

end
