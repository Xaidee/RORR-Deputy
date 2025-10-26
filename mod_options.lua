local options = ModOptions.new()

local force_unlocks = {
	survivor = options:add_checkbox("force_unlock_survivor"),
	skills = options:add_checkbox("force_unlock_skills"),
	items = options:add_checkbox("force_unlock_items"),
}

