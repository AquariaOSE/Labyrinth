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

-- FG: improved door that supports also diagonal opening (each direction)

if not v then v = {} end
if not AQUARIA_VERSION then dofile("scripts/entities/entityinclude.lua") end

dofile(appendUserDataPath("_mods/Labyrinth/scripts/inc_util.lua")) -- for vector functions

-- DOOR COMMON
v.init_x = 0
v.init_y = 0

v.dist = 700
v.delay = 0

v.effectRange = 1800

v.sound = ""

function v.commonInit(me, tex, snd, sz, flipDir)
	setupEntity(me, tex, -2)
	entity_scale(me, sz, sz)
	entity_setActivationType(me, AT_NONE)
	entity_setFillGrid(me, true)
	v.sound = snd
	loadSound(v.sound)
    entity_setAllDamageTargets(me, false)
	if flipDir ~= 0 then
		v.dist = -v.dist
	end
end

function postInit(me)
	v.init_x = entity_x(me)
	v.init_y = entity_y(me)
end

v.ret = 0
function v.commonUpdate(me, dt)
	if entity_getState(me)==STATE_OPEN then
		--v.ret = v.ret + dt
		v.delay = v.delay + dt
		if v.delay > 0.2 then
			reconstructEntityGrid()
			v.delay = 0
		end
		if not entity_isInterpolating(me) then
			if entity_isEntityInRange(me, getNaija(), v.effectRange) then
				shakeCamera(4, 1)
			end
			entity_setState(me, STATE_OPENED)
            spawnParticleEffect("rockhit", entity_x(me), entity_y(me) - 70)
            spawnParticleEffect("rockhit", entity_x(me), entity_y(me))
            spawnParticleEffect("rockhit", entity_x(me), entity_y(me) + 70)
		else
		--[[
			if v.ret > 1 then
				reconstructEntityGrid()
				v.ret = 0
			end
			]]--
		end
	end
	if entity_getState(me)==STATE_CLOSE then
		if not entity_isInterpolating(me) then
			entity_setState(me, STATE_CLOSED)
			shakeCamera(4, 1)
            spawnParticleEffect("rockhit", entity_x(me), entity_y(me) - 70)
            spawnParticleEffect("rockhit", entity_x(me), entity_y(me))
            spawnParticleEffect("rockhit", entity_x(me), entity_y(me) + 70)
		end
	end
end

local function getOpenPos(me)
    local dx, dy = v.vector_fromDeg(entity_getRotation(me), v.dist)
    return v.init_x + dx, v.init_y + dy
end

function enterState(me)
	if entity_isState(me, STATE_OPEN) then
		if entity_isEntityInRange(me, getNaija(), v.effectRange) then
			playSfx(v.sound)
		end
        
        local dx, dy = getOpenPos(me)
        entity_interpolateTo(me, dx, dy, 2)
        
	elseif entity_isState(me, STATE_CLOSE) then
		playSfx(v.sound)
		local oldx = entity_x(me)
		local oldy = entity_y(me)
		entity_setPosition(me, v.init_x, v.init_y)
		reconstructEntityGrid()
		entity_setPosition(me, oldx, oldy)
		entity_interpolateTo(me, v.init_x, v.init_y, 2)
	elseif entity_isState(me, STATE_CLOSED) then
		entity_setPosition(me, v.init_x, v.init_y)
		reconstructEntityGrid()
	elseif entity_isState(me, STATE_OPENED) then
		--entity_setColor(me, 1, 0, 0)
		local dx, dy = getOpenPos(me)
        entity_setPosition(me, dx, dy)
		reconstructEntityGrid()		
	end
end

function exitState(me)
end

function hitSurface(me)
end

function damage(me)
    return false
end
