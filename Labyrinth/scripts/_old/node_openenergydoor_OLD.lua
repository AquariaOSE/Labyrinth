if not v then v = {} end
if not AQUARIA_VERSION then dofile("scripts/entities/entityinclude.lua") end

function init(me)
	node_setCursorActivation(me, false)
end

function activate(me)	
	local energyOrb = node_getNearestEntity(me, "EnergyOrb")
	if energyOrb ~= 0 and entity_isState(energyOrb, STATE_CHARGED) then		
		local door = node_getNearestEntity(me, "EnergyDoor")
		if door ~= 0 then
			entity_setState(door, STATE_OPEN)
		end
	end
end

function update(me, dt)
end
