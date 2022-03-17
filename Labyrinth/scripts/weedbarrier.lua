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

v.n = 0

function init(me)
    setupEntity(me, "barrier", 1)
    entity_setActivationType(me, AT_NONE)
    entity_setHealth(me, 1)
    entity_setDamageTarget(me, DT_AVATAR_ENERGYBLAST, true)
    entity_setDeathParticleEffect(me, "tinyredexplode")
    entity_setCollideRadius(me, 150)
end

function postInit(me)   
    v.n = getNaija()
    if entity_isFlag(me, 1) then
        entity_delete(me)
    end
end

local function pushback(me, e)
    local x, y = entity_getVectorToEntity(me, e)
    vector_setLength(x, y, 20000*dt)
    entity_clearVel(e)
    entity_addVel(e, x, y)
    entity_addVel2(e, x, y)
    entity_warpLastPosition(e)
end

function update(me, dt)
    entity_handleShotCollisions(me)
    if entity_touchAvatarDamage(me, entity_getCollideRadius(me), 0) then
        pushback(me, v.n)
        local ride = entity_getRiding(v.n)
        if ride ~= 0 then
            pushback(me, ride)
        end
    end
end

function enterState(me)
    if entity_isState(me, STATE_DEAD) then
        entity_setFlag(me, 1)
    end
end

function damage(me, attacker, bone, damageType, dmg)
    -- HACK: this should be sufficient to only react to urchin costume damage
    if attacker == v.n and damageType == DT_AVATAR_ENERGYBLAST and dmg < 0.5
       and avatar_isBursting() then -- need to burst, though
        entity_changeHealth(me, -99)
        return true
    end
    return false
end

function exitState(me)
end

function hitSurface(me)
end
