-- Copyright (C) 2007, 2010 - Bit-Blot
--
-- This file is part of Aquaria.
--
-- Aquaria is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
--
-- See the GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

if not v then v = {} end
if not AQUARIA_VERSION then dofile("scripts/entities/entityinclude.lua") end

dofile(appendUserDataPath("_mods/Labyrinth/scripts/pullplantcommon.lua"))

function init(me)
	local n1 = getNearestNodeByType(entity_x(me), entity_y(me), PATH_SETING)
	if n1 ~= 0 and node_isEntityIn(n1, me) then
		v.commonInit(me, "", node_getContent(n1), node_getAmount(n1))
	else
		local n2 = getNearestNodeByType(entity_x(me), entity_y(me), PATH_SETENT)
		if n2 ~= 0 and node_isEntityIn(n2, me) then
			v.commonInit(me, node_getContent(n2), "", node_getAmount(n2))		
		else
			local d = false

			if not d then
				local s = randRange(1,100)
				if s == 1 then
					v.commonInit(me, "", "HealingPoultice")
				elseif s < 7 then
					v.commonInit(me, "", "LeafPoultice")
				else

				local r = randRange(1, 7)
				if r == 1 then
					if isMapName("forest04") then
						local t = randRange(1,8)
						if t == 1 then
							v.commonInit(me, "", "RainbowMushroom")
						else
							v.commonInit(me, "", "Mushroom")
						end
					else
						v.commonInit(me, "", "PlantBulb")
					end
				elseif r == 2 then
					if isMapName("labyrinth_wheel") then
           					v.commonInit(me, "purpwallshooter", "")						
					else
						v.commonInit(me, "Raspberry", "")
						
					end
				elseif r == 3 then
					v.commonInit(me, "", "PlantLeaf")
				elseif r == 4 then
					v.commonInit(me, "", "RedBerry")
				elseif r == 5 then
					v.commonInit(me, "", "SmallBone")
				else
					v.commonInit(me, "", "PlantLeaf")
				end

				end
			end
		end
	end
end
