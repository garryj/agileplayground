
	local M = {}
local function addEnemies()

parms = {img="flame.png", ss_width=24, ss_height=24,ss_frames = 7, name = "flame", x=200, y=600, gravity ="dynamic",soundTouch = nil, sensor = false}

end

M.addEnemies = addEnemies
return M



-- parms.gravity="static"
-- 	for i = 1, 100 do 
-- 		parms["x"]=parms["x"]
-- 		parms["y"]=math.random( 300, ph )

-- 	  table.insert(enemies, enemy:new(parms))
-- 	end 