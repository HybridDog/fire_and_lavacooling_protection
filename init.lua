local load_time_start = os.clock()

local function cooling_allowed(pos)
	return not minetest.is_protected(pos, " ")
end

for _,i in pairs({"flowing", "source"}) do
	local cool = default["cool_lava_"..i]
	default["cool_lava_"..i] = function(pos)
		if cooling_allowed(pos) then
			cool(pos)
		end
	end
end

minetest.log("info", string.format("[lavacooling_protection] loaded after ca. %.2fs", os.clock() - load_time_start))
