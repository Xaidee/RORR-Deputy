---@type table<Sprite>
local sprites = {
	item = Sprite.new("item/rose_buckler", "~/resources/sprites/items/rose_buckler.png", 1, 16, 16),
	--effect = Sprite.new("buff/movement_shield", "~/resources/sprites/buffs/movement_shield.png", 1, 7, 9)
}

local item = Item.new("rose_buckler")
item:set_sprite(sprites.item)
item:set_tier(ItemTier.UNCOMMON)

item.loot_tags = Item.LootTag.CATEGORY_UTILITY

local log = ItemLog.new_from_item(item)
log.group = ItemLog.Group.COMMON_LOCKED

--- Purely visual buff to show when applying armor
local buff = Buff.new("movement_shield")
buff.max_stack = 1

---@param actor Actor
RecalculateStats.add(function(actor)
	local stack = actor:item_count(item)
	if stack <= 0 then return end

	if (math.abs(actor.pHspeed) >= actor.pHmax * 0.98) or actor.pVspeed ~= 0 then
		actor:buff_apply(buff, 2)
		--api.armor_add(24 * stack)
		actor.armor = actor.armor + 24 * stack
	else
		actor:buff_remove(buff)
	end
end)


