-- A M O E B A     (based on dark jelly, parameciumexp)

if not v then v = {} end
if not AQUARIA_VERSION then dofile("scripts/entities/entityinclude.lua") end

v.blupTimer = 0
v.dirTimer = 0
v.blupTime = 3.0

v.sz = 1.0
v.dir = 0

local MOVE_STATE_UP = 0
local MOVE_STATE_DOWN = 1
local MOVE_STATE_AWAY = 2

v.moveState = 0
v.moveTimer = 0
v.velx = 0
v.waveDir = 1
v.waveTimer = 0
v.soundDelay = 0
v.glows = nil
v.laughed = false

v.n = 0

v.seen = false

local function doIdleScale(me)
	entity_scale(me, 1*v.sz, 1.05*v.sz)
	entity_scale(me, 1.1*v.sz, 0.95*v.sz, v.blupTime, -1, 1, 1)
end

function init(me)
	v.glows = {}

	setupBasicEntity(
	me,
	"",								-- texture
	20,								-- health
	2,								-- manaballamount
	2,								-- exp
	10,								-- money
	0,								-- collideRadius (for hitting entities + spells)
	STATE_IDLE,						-- initState
	512,							-- sprite width	
	256,							-- sprite height
	1,								-- particle "explosion" type, 0 = none
	0,								-- 0/1 hit other entities off/on (uses collideRadius)
	4000,							-- updateCull -1: disabled, default: 4000
	0
	)
	
	entity_initSkeletal(me, "amoeba")
	
	entity_setEntityType(me, ET_NEUTRAL)
	entity_setDamageTarget(me, false)
	
	entity_setEntityLayer(me, 0)
		
	doIdleScale(me)

   	 if chance(50) then
       	 	entity_rotate(me, 360, 20, -1, 1)
   	 else
        	entity_rotate(me, 360)
        	entity_rotate(me, 0, 20, -1, 1)
    	end
	
	entity_exertHairForce(me, 0, 400, 1)
		
	entity_setState(me, STATE_IDLE)
	--entity_setCullRadius(me, -3)
	entity_setCull(me, false)
	
	bone_setSegs(entity_getBoneByName(me, "front"), 4, 32, 0.6, 0.6, -0.028, 0, 0.75, 0)


	--[[
	for i=1,4 do
		glows[i] = entity_getBoneByName(me, string.format("Glow%d", i))
		bone_alpha(glows[i], 0.5)
		bone_alpha(glows[i], 1, 1, -1, 1, 1)
		bone_update(glows[i], i*0.25)
	end
	]]--

	entity_setDamageTarget(me, DT_AVATAR_BITE, false)
	entity_setCollideRadius(me, 100)
	entity_setInternalOffset(me, 0, 64)
	entity_generateCollisionMask(me)
    
    if chance(50) then
        entity_rotate(me, 360, 40, -1, 1)
    else
        entity_rotate(me, 360)
        entity_rotate(me, 0, 40, -1, 1)
    end
	
end

function postInit(me)
	entity_update(me, math.random(100)/100.0)
	v.n = getNaija()
end

function update(me, dt)
	--dt = dt * 1.5
	local sx,sy = entity_getScale(me)
		
	v.moveTimer = v.moveTimer - dt
	if v.moveTimer < 0 then
		if v.moveState == MOVE_STATE_DOWN then		
			v.moveState = MOVE_STATE_UP
			entity_setMaxSpeedLerp(me, 1.5, 0.2)
			--entity_scale(me, 0.75, 1, 1, 1, 1)
			v.moveTimer = 3 + math.random(200)/100.0
			--entity_sound(me, "JellyBlup")
		elseif v.moveState == MOVE_STATE_UP then
			v.velx = math.random(400)+100
			if math.random(2) == 1 then
				v.velx = -v.velx
			end
			v.moveState = MOVE_STATE_DOWN
			entity_setMaxSpeedLerp(me, 1, 1)
			v.moveTimer = 5 + math.random(200)/100.0 + math.random(3)
		else
			v.moveState = MOVE_STATE_DOWN
		end
	end
	
	v.waveTimer = v.waveTimer + dt
	if v.waveTimer > 2 then
		v.waveTimer = 0
		if v.waveDir == 1 then
			v.waveDir = -1
		else
			v.waveDir = 1
		end
	end

	if v.moveState == MOVE_STATE_UP then
		entity_addVel(me, v.velx*dt, -600*dt)
		--entity_rotateToVel(me, 8)
		
	elseif v.moveState == MOVE_STATE_DOWN then
		entity_addVel(me, 0, 50*dt)
		--entity_rotateTo(me, 0, 8)
		entity_exertHairForce(me, 0, 200, dt*0.6, -1)
		entity_doCollisionAvoidance(me, dt, 15, 1)
		--entity_doCollisionAvoidance(me, dt, 10, 0.5)
	elseif v.moveState == MOVE_STATE_AWAY then
		--entity_rotateTo(me, 0, 8)
	end

	entity_doCollisionAvoidance(me, dt, 12, 2)
	--[[
	entity_doEntityAvoidance(me, dt, 32, 1.0)
	entity_doCollisionAvoidance(me, 1.0, 8, 1.0)
	entity_updateCurrents(me, dt)
	]]--
	entity_updateMovement(me, dt)
	
	entity_handleShotCollisions(me)
	
	if entity_touchAvatarDamage(me, entity_getCollideRadius(me), 0) then
		if avatar_isBursting() and avatar_isLockable() and entity_setBoneLock(v.n, me) then
			-- yay!
		else
			local x, y = entity_getVectorToEntity(me, v.n, 1000)
			entity_addVel(v.n, x, y)
		end
	end
    
       
	-- HACK: entity_isInvincible() is for credits camera roll
	if not v.seen and entity_isEntityInRange(me, v.n, 512) and not entity_isInvincible(v.n) then
		emote(EMOTE_NAIJAWOW)
		v.seen = true
	end
end

function hitSurface(me)
end

function enterState(me)
	if entity_isState(me, STATE_IDLE) then
		entity_setMaxSpeed(me, 40)
		entity_animate(me, "idle", LOOP_INF)
	end
end

function damage(me, attacker, bone, damageType, dmg, hx, hy)
	if entity_getBoneLockEntity(v.n) == me then
		if not v.laughed or dmg >= 1 then
            v.laughed = true
			if chance(50) then
				emote(EMOTE_NAIJALAUGH)
			else
				emote(EMOTE_NAIJAGIGGLE)
			end
		end
	end
	entity_setHealth(me, 60)
	entity_setMaxSpeedLerp(me, 10)
	entity_setMaxSpeedLerp(me, 1, 10)
	
	v.moveState = MOVE_STATE_AWAY
	local vx = entity_x(me) - hx
	local vy = entity_y(me) - hy
	vx, vy = vector_setLength(vx, vy, 400)
	entity_addVel(me, vx, vy)
	
	--entity_rotateToVel(me, 2)
	return true
end

function exitState(me)
end
