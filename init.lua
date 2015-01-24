local load_time_start = os.clock()

local change_fire = true
local change_lavacooling = false

local function action_allowed(pos)
	return not minetest.is_protected(pos, " ")
end

if change_fire then
	local fire_allowed = fire.flame_should_extinguish
	function fire.flame_should_extinguish(pos)
		if action_allowed(pos) then
			return fire_allowed(pos)
		end
		return true
	end
end

if change_lavacooling then
	for _,i in pairs({"flowing", "source"}) do
		local cool = default["cool_lava_"..i]
		default["cool_lava_"..i] = function(pos)
			if action_allowed(pos) then
				cool(pos)
			end
		end
	end
end

minetest.log("info", string.format("[fire_and_lavacooling__protection] loaded after ca. %.2fs", os.clock() - load_time_start))
