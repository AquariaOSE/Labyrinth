if not v then v = {} end
if not AQUARIA_VERSION then dofile("scripts/entities/entityinclude.lua") end

dofile(appendUserDataPath("_mods/Labyrinth/scripts/flags.lua"))

v.n = 0

function init(me)
	v.n = getNaija()
end


function update(me, dt)

	--Display once if Naija enters
	if isFlag(KUIRLIN_CHILDREN, 0) and node_isEntityIn(me, v.n) then
		setFlag(KUIRLIN_CHILDREN, 1)
		setControlHint("Even the children are carrying drift pearl. And they look disagreeable, too!", 0, 0, 0, 10)
	end 

end
