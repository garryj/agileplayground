
local M = {}
local function addWalls()
	print "Adding walls"

		parms = {x=-300, y = 300, img="wall_left.png", ssWidth =49 , ssHeight = 703 , ssNumFrames = 1, doPhysics= true}
	

	
	--table.insert(walls, wall:new(parms))
	
	parms.x = pw-350
	parms.y = 350
	table.insert(walls, wall:new(parms))

	parms.x = -100
	parms.y = 1020
	walls["wallhatch"]=wall:new(parms)
	--table.insert(walls, wall:new(parms))

	
parms.x = -300
	parms.y = 1020
	table.insert(walls, wall:new(parms))

	


	parms.img = "wall_top.png"
	parms.ssWidth = 703
	parms.ssHeight = 49
	parms.x = 260
	parms.y = 680 
	table.insert(walls, wall:new(parms))

	-- top near exit
	parms.x = 360
	parms.y = 200
	table.insert(walls, wall:new(parms))



	parms.x = 700
	parms.y = 900
	table.insert(walls, wall:new(parms))
end
M.addWalls = addWalls
return M