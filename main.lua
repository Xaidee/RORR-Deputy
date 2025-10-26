---@module 'Deputy'
---@author Xaidee
mods["ReturnsAPI-ReturnsAPI"].auto{
	namespace = "deputy",
	mp = true,
}

PATH = _ENV["!plugins_mod_folder_path"]

local init = function()
	require("mod_options")
	-- Require all files in content folders
	local folders = {
		"survivors",
		"items",
		--"equipment",
	}
	for _, folder in ipairs(folders) do
		local names = path.get_files(PATH .. "/lua/" .. folder)
		for _, name in ipairs(names) do
			require(name)
		end
	end

	-- once we have loaded everything, enable hot/live reloading. remember set to false if not in a dev environment
	-- this variable may be used by content code to make sure it behaves correctly when hotloading
	HOTLOADED = true
end
Initialize.add(init)

if HOTLOADED then
	init()
end
