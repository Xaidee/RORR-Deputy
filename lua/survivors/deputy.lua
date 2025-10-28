---@type table<Sprite>
local sprites = {
	loadout = Sprite.new("survivor/deputy/loadout", "~/resources/sprites/survivors/deputy/loadout.png", 4, 28, 0),
	--title = Sprite.new("survivor/deputy/title", "~/resources/sprites/survivors/deputy/title.png"),
	idle = Sprite.new("survivor/deputy/idle", "~/resources/sprites/survivors/deputy/idle.png", 1, 12, 17),
	idle_half = Sprite.new("survivor/deputy/idle_half", "~/resources/sprites/survivors/deputy/idle_half.png", 1, 12, 17),
	walk = Sprite.new("survivor/deputy/walk", "~/resources/sprites/survivors/deputy/walk.png", 8, 14, 18),
	--jump = Sprite.new("survivor/deputy/jump", "~/resources/sprites/survivors/deputy/jump.png"),
	--jump_peak = Sprite.new("survivor/deputy/jump_peak", "~/resources/sprites/survivors/deputy/jump_peak.png"),
	--fall = Sprite.new("survivor/deputy/fall", "~/resources/sprites/survivors/deputy/fall.png"),
	--climb = Sprite.new("survivor/deputy/climb", "~/resources/sprites/survivors/deputy/climb.png"),
	--death = Sprite.new("survivor/deputy/death", "~/resources/sprites/survivors/deputy/death.png"),
	portrait = Sprite.new("survivor/deputy/portrait", "~/resources/sprites/survivors/deputy/portrait.png", 3),
	portrait_small = Sprite.new("survivor/deputy/portrait_small", "~/resources/sprites/survivors/deputy/portrait_small.png"),
	--palette = Sprite.new("survivor/deputy/palette", "~/resources/sprites/survivors/deputy/palette.png"),
	--portrait_palette = Sprite.new("survivor/deputy/portrait_palette", "~/resources/sprites/survivors/deputy/portrait_palette.png"),
	--loadout_palette = Sprite.new("survivor/deputy/loadout_palette", "~/resources/sprites/survivors/deputy/loadout_palette.png"),
	credits = Sprite.new("survivor/deputy/credits", "~/resources/sprites/survivors/deputy/credits.png"),
	skills = Sprite.new("survivor/deputy/skills", "~/resources/sprites/survivors/deputy/skills.png", 7),
	--shootZ = Sprite.new("survivor/deputy/skills", "~/resources/sprites/survivors/deputy/shoot.png", 10, 10, 17),
	shootZa = Sprite.new("survivor/deputy/shootZa", "~/resources/sprites/survivors/deputy/shoot_a.png", 5, 10, 17),
	shootZb = Sprite.new("survivor/deputy/shootZb", "~/resources/sprites/survivors/deputy/shoot_b.png", 5, 10, 17),
	--shootZ_half = Sprite.new("survivor/deputy/shootZ_half", "~/resources/sprites/survivors/deputy/shoot_half.png", 10, 10, 17),
	shootZa_half = Sprite.new("survivor/deputy/shootZa_half", "~/resources/sprites/survivors/deputy/shoot_a_half.png", 5, 10, 17),
	shootZb_half = Sprite.new("survivor/deputy/shootZb_half", "~/resources/sprites/survivors/deputy/shoot_b_half.png", 5, 10, 17),
	--decoy = Sprite.new("survivor/deputy/decoy", "~/resources/sprites/survivors/deputy/decoy.png")
	drone_idle = Sprite.new("survivor/deputy/drone", "~/resources/sprites/survivors/deputy/drone.png", 5, 15, 13),
	--drone_shoot = Sprite.new("survivor/deputy/drone_shoot", "~/resources/sprites/survivors/deputy/drone_shoot.png", 5, 33, 13),
	hot_pursuit = Sprite.new("effect/hot_pursuit", "~/resources/sprites/effects/hot_pursuit.png", 5, 12, 12)
}
---@type table<Sound>
local sounds = {
	--select = Sound.new("survivor/deputy/select", "~/resources/sounds/survivors/deputy/select.ogg"),
	shoot = Sound.new("survivor/deputy/shoot", "~/resources/sounds/survivors/deputy/shoot.ogg"),
	--kick = Sound.new("survivor/deputy/kick", "~/resources/sounds/survivors/deputy/kick.ogg"),
	--ricochet = Sound.new("survivor/deputy/ricochet", "~/resources/sounds/survivors/deputy/ricochet.ogg"),
}

---@type Color
local primary_color = Color(0xE1C100) -- RGB: 225, 193, 0

---@type Survivor
local survivor = Survivor.new("deputy")

survivor.sprite_loadout = sprites.loadout
--survivor.select_sound_id = sounds.select

survivor.sprite_portrait = sprites.portrait
survivor.sprite_portrait_small = sprites.portrait_small

survivor.sprite_title = sprites.walk

survivor.sprite_idle = sprites.idle

--survivor.sprite_credits = sprites.credits

survivor.primary_color = primary_color

--- x_offset, y_offset,
--- y_offset_climbing, x_offset_climbing
survivor.cape_offset = Array.new({
	0, -8,
	0, -5,
})

local stats = {
	base = {
		health = 100,
		damage = 12,
		regen = 0.3,
	},
	level = {
		health = 32,
		damage = 3,
		regen = 0.06,
		armor = 2,
	},
}
survivor:set_stats_base(stats.base)
survivor:set_stats_level(stats.level)

---@param actor Survivor
Callback.add(survivor.on_init, function(actor)
	-- Set sprites
	actor.sprite_idle = sprites.idle
	actor.sprite_walk = sprites.walk
	--actor.sprite_walk_last
	--actor.sprite_jump
	--actor.sprite_jump_peak
	--actor.sprite_fall
	--actor.sprite_climb
	--actor.sprite_death
	--actor.sprite_decoy
	actor.sprite_drone_idle = sprites.drone_idle
	--actor.sprite_drone_shoot
	--actor.sprite_climb_hurt
	--actor.sprite_palette
	actor.sprite_idle_half		= Array.new({sprites.idle,		sprites.idle_half, 0})
	--actor.sprite_walk_half		= Array.new({sprites.walk,		sprites.walk_half, 0, sprites.walk_back})
	--actor.sprite_jump_half		= Array.new({sprites.jump,		sprites.jump_half, 0})
	--actor.sprite_jump_peak_half	= Array.new({sprites.jump_peak,	sprites.jump_peak_half, 0})
	--actor.sprite_fall_half		= Array.new({sprites.fall,		sprites.fall_half, 0})

	--actor:survivor_util_init_half_sprites()

end)
---[
--- SKINS
---]

---[
--- HOT PURSUIT
---
--- A stacking movement buff represented as a fun star/performance rating!
---]
local max_stars = 5
local progress_per_star = 10
local pHmax_per_progress = 0.1

local buff = Buff.new("hot_pursuit")
buff.show_icon = true
buff.icon_sprite = sprites.hot_pursuit
buff.icon_subimage = 0
buff.icon_stack_subimage = 1
buff.draw_stack_number = true
buff.max_stack = 200

---@param actor Actor
RecalculateStats.add(function(actor)
	if not actor:buff_count(buff) then return end
	local stack = actor:buff_count(buff)
	actor.pHmax = actor.pHmax + stack * pHmax_per_progress
end)

---@param actor Actor
Callback.add(survivor.on_init, function(actor)
	local data = Instance.get_data(actor)
	if not data.hot_pursuit then
		data.hot_pursuit = 0
	end
end)

---@param actor Actor
Callback.add(survivor.on_step, function(actor)
	local data = Instance.get_data(actor)
	if data.hot_pursuit > 0 then
		local stack = data.hot_pursuit
		actor:buff_apply(buff, 60 * 3, stack)
		data.hot_pursuit = data.hot_pursuit - 1
	end
end)



---[
--- SKILLS
---]
--- Trigger Tap (Primary/Z)
local skillZ = Skill.new("deputyZ") -- survivor:get_default_skill(Skill.Slot.PRIMARY)

skillZ.sprite = sprites.skills
skillZ.subimage = 0

skillZ.is_primary = true
skillZ.cooldown = 3
skillZ.damage = 1.5
skillZ.require_key_press = false
skillZ.disable_aim_stall = true
--skillZ.does_change_activity_state = true
skillZ.required_interrupt_priority = ActorState.InterruptPriority.ANY

local stateZ = ActorState.new("deputy/skillZa")

Callback.add(skillZ.on_activate, function(actor, skill, slot)
	actor:set_state(stateZ) --- Network??
end)
Callback.add(stateZ.on_enter, function(actor, data)
	data.fired = 0
	actor.image_index = 0

	if not data.attack_side then
		data.attack_side = 0
	end

	actor:actor_animation_set(sprites.shootZa, 0.2)
	if data.attack_side == 1 then
		actor:actor_animation_set(sprites.shootZb, 0.2)
	end

	--actor:skill_util_strafe_init()
	--actor:skill_util_strafe_turn_init()
end)
Callback.add(stateZ.on_step, function(actor, data)
	--actor.sprite_index2 = sprites.shootZa_half
	if data.attack_side == 1 then
		--actor.sprite_index2 = sprites.shootZb_half
	end

	--actor:skill_util_strafe_update(0.22 * actor.attack_speed, 0.5)
	--actor:skill_util_strafe_turn_update()

	--[[-- adjust vertical offset so the upper body bobs up and down depending on the leg animation
	if actor.sprite_index == actor.sprite_walk_half[2] then
		local walk_offset = 0
		local leg_frame = math.floor(actor.image_index)
		if leg_frame == 1 or leg_frame == 5 then
			walk_offset = 1
		elseif leg_frame == 3 or leg_frame == 7 then
			walk_offset = -1
		end
		actor.ydisp = walk_offset -- ydisp controls upper body offset
	end]]--

	if data.fired == 0 then
		data.fired = 1
		actor:sound_play(sounds.shoot, 1, 0.9 - data.attack_side * 0.1 + math.random() * 0.2)
		data.attack_side = (data.attack_side + 1) % 2
		--if actor:is_authority() then
			local damage = actor:skill_get_damage(skillZ)
			local dir = actor:skill_util_facing_direction()

			--if not GM.skill_util_update_heaven_cracker(actor, damage, actor.image_xscale) then
				--for i=0, actor:buff_stack_count(buffShadowClone) do
					local attack = actor:fire_bullet(actor.x, actor.y, 1000, dir, damage, nil, gm.constants.sSparks1, Tracer.COMMANDO1)
				--end
			--end
		--end
	end

	actor:skill_util_exit_state_on_anim_end()
end)
Callback.add(stateZ.on_exit, function(actor, data)
	--actor:skill_util_strafe_exit()
end)
Callback.add(stateZ.on_get_interrupt_priority, function(actor, data)

end)

--- Gun Sling (Secondary/X)
local skillX = Skill.new("deputyX")

skillX.sprite = sprites.skills
skillX.subimage = 1
skillX.cooldown = 8 * 60
skillX.max_stock = 2
skillX.start_with_stock = true

local gun = Object.new("deputy_gun")
gun.obj_sprite = sprites.gun
gun.obj_depth = 2

Callback.add(gun.on_create, function(inst)
	local data = Instance.get_data(inst)

	data.timer = 0
	data.life = 300
	data.fired = 0
end)
Callback.add(gun.on_step, function(inst)
	local data = Instance.get_data(inst)
	local parent = data.parent

	if parent.dead then
		data.life = 0
	end

	if parent and Instance.exists(parent) then
		-- Look for nearby enemies
		local range = 5
	end

	if data.life > 0 then
		data.life = data.life - 1
	else
		inst:fire_explosion(inst.x, inst.y, 64, 64, parent.damage * skillX.damage, nil, nil)
		inst:destroy()
	end
end)

--- Roundhouse Kick (NEW Alt Seconary/X)
local skillXAlt = Skill.new("deputyXAlt")

--- Shooting Star (Utility/C)
local skillC = Skill.new("deputyC")

skillC.sprite = sprites.skills
skillC.subimage = 2

--- Crashing Comet (Special/V)
local skillV = Skill.new("deputyV")

skillV.sprite = sprites.skills
skillV.subimage = 3

--- Devestating Meteor (Boosted Special/V)
local skillVBoosted = Skill.new("deputyVBoosted")

skillVBoosted.sprite = sprites.skills
skillVBoosted.subimage = 4
skillV.upgrade_skill = skillVBoosted.value

--- Bullet Heaven (Alt Special/V)
local skillVAlt = Skill.new("deputyVAlt")

skillVAlt.sprite = sprites.skills
skillVAlt.subimage = 5

---
local skillVAltBoosted = Skill.new("deputyVAltBoosted")

skillVAltBoosted.sprite = sprites.skills
skillVAltBoosted.subimage = 6
skillVAlt.upgrade_skill = skillVAltBoosted.value

survivor:add_skill(Skill.Slot.PRIMARY, skillZ)
survivor:add_skill(Skill.Slot.SECONDARY, skillX)
survivor:add_skill(Skill.Slot.SECONDARY, skillXAlt)
survivor:add_skill(Skill.Slot.UTILITY, skillC)
survivor:add_skill(Skill.Slot.SPECIAL, skillV)
survivor:add_skill(Skill.Slot.SPECIAL, skillVAlt)

local log = SurvivorLog.new_from_survivor(survivor)

local achievements = {
	unlock_deputy = Achievement.new("unlock_deputy"),
	unlock_rose_buckler = Achievement.new("unlock_rose_buckler"),
	unlock_deputy_x2 = Achievement.new("unlock_deputy_x2"),
	unlock_deputy_c2 = Achievement.new("unlock_deputy_c2"),
	unlock_deputy_v2 = Achievement.new("unlock_deputy_v2"),
}

print("Milestone Stages = "..survivor.milestone_stages_1)
print("Milestone Kills = "..survivor.milestone_kills_1)
print("Milestone Items = "..survivor.milestone_items_1)

local parent_id = achievements.unlock_deputy.value
achievements.unlock_deputy.group = Achievement.Group.CHARACTER
achievements.unlock_deputy.unlock_kind = Achievement.Kind.SURVIVOR
achievements.unlock_deputy:set_unlock_survivor(survivor)

achievements.unlock_rose_buckler.parent_id = parent_id
achievements.unlock_rose_buckler.unlock_kind = Achievement.Kind.ITEM

local rose_buckler = Item.find("rose_buckler")
if (rose_buckler ~= nil) then
	achievements.unlock_rose_buckler:set_unlock_item(rose_buckler)
end

---@enum
local Milestone = {
	KILLS = 0,
	ITEMS = 1,
	STAGES = 2,
}

---@param achievement Achievement
---@param survivor_in Survivor
---@param milestone number
local function set_milestone(achievement, survivor_in, milestone)
	if (milestone == Milestone.KILLS) then
		survivor.milestone_kills_1 = Milestone.KILLS
		achievement.milestone_alt_unlock = survivor_in.milestone_kills_1
	elseif (milestone == Milestone.ITEMS) then
		survivor.milestone_items_1 = Milestone.ITEMS
		achievement.milestone_alt_unlock = survivor_in.milestone_items_1
	elseif (milestone == Milestone.STAGES) then
		survivor.milestone_stages_1 = Milestone.STAGES
		achievement.milestone_alt_unlock = survivor_in.milestone_stages_1
	end
	achievement.milestone_survivor = survivor_in.value
end

achievements.unlock_deputy_x2.parent_id = parent_id
achievements.unlock_deputy_x2.unlock_kind = Achievement.Kind.SURVIVOR_LOADOUT_UNLOCKABLE
set_milestone(achievements.unlock_deputy_x2, survivor, Milestone.STAGES)
achievements.unlock_deputy_x2:set_unlock_skill(skillXAlt)

achievements.unlock_deputy_c2.parent_id = parent_id
set_milestone(achievements.unlock_deputy_c2, survivor, Milestone.KILLS)

achievements.unlock_deputy_v2.parent_id = parent_id
achievements.unlock_deputy_v2.unlock_kind = Achievement.Kind.SURVIVOR_LOADOUT_UNLOCKABLE
set_milestone(achievements.unlock_deputy_v2, survivor, Milestone.ITEMS)
achievements.unlock_deputy_v2:set_unlock_skill(skillVAlt)
