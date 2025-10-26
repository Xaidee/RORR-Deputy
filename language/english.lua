---@type { [table]: string|table }
return {
	survivor = {
		deputy = {
			name = "Deputy",
			nameUpper = "DEPUTY",
			description = "The <y>Deputy</c> is an extremely mobile run-and-gun <y>speed demon</c> who whittles enemies down with her revolvers before finishing them off with a massive burst damage from her signature <y>Crashing Comet</c>.",
			endQuote = "..and so she left, .",
			story = "<ul>Passanger Details:</c>\n",
			id = "Travel ID: ",
			departure = "<y>Departure:</c>\n",
			arrival = "<y>Destination:</c>\n",
		},
	},
	skill = {
		deputyZ = {
			name = "Trigger Tap",
			description = "Fire mid-range revolvers for <y>150% damage</c>\nHitting enemies with your skills increases <y>Hot Pursuit</c>, increasing <b>movement speed</c>.",
		},
		deputyX = {
			name = "Gun Sling",
			description = "Throw a revolver that shoots nearby enemies for <y>3x100% damage</c>, then explode for <y>400% damage</c>.",
		},
		deputyXAlt = {
			name = "Roundhouse Kick",
			description = "",
		},
		deputyC = {
			name = "Shooting Star",
			description = "<y>Stunning</c>. Leap forward and shoot an enemy below you for <y>4x150% damage</c>.",
		},
		deputyV = {
			name = "Crashing Comet",
			description = "<b>Dash</c> forward and bounce off an enemy, dealing <y>800% damage</y>\n<b>Kills reset the cooldown of your utility</b>.",
		},
		deputyVBoosted = {
			name = "Devastating Meteor",
			description = "",
		},
		deputyVAlt = {
			name = "Bullet Heaven",
			description = "Jump high into the air, then widly fire bullets downwards for <y>150% damage</c> each. The number of shots scales with attack speed.",
		},
		deputyVAltBoosted = {
			name = "",
			description = "",
		},
	},
	item = {
		rose_buckler = {
			name = "Rose Buckler",
			pickup = "Reduce incoming damage while moving.",
			description = "<g>Increase armor</c> by <g>24 <c_stack>(+24 per stack)</c> while <g>moving</c>.",
			destination = "",
			date = "",
			story = "",
			priority = "<g>Priority</c>"
		}
	},
	achievement = {
		deputy = {
			name = "Speed Demon",
			description = "",
			milestone_stages = {
				--name = "",
				--description = "",
				description2 = "Complete 25 stages as Deputy."
			}
		},
		rose_buckler = {
			--name = "",
			description = "Deputy: do something..."
		}
	},
}
