local M = {}
local function addWalls()
		parms = {x=-300, y = 300, img="wall_left.png", ssWidth =49 , ssHeight = 703 , ssNumFrames = 1, doPhysics= true}
	
	
	table.insert(walls, wall:new(parms))
	--local wall1 = wall:new(parms)
	parms.x = pw-350
	parms.y = 450
	table.insert(walls, wall:new(parms))

	parms.x = 0
	parms.y = 100
	table.insert(walls, wall:new(parms))

	



	parms.img = "wall_top.png"
	parms.ssWidth = 703
	parms.ssHeight = 49
	parms.x = 300
	parms.y = 700
	table.insert(walls, wall:new(parms))

	parms.x = 800
	parms.y = 900
	table.insert(walls, wall:new(parms))

	end
M.addWalls = addWalls
return M