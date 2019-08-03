	local M = {}
	local function addPlatforms()
	parms = {}
	
	parms.isVisible = true
	parms.doPhysics = true

	parms.x = 5
	parms.y = 350
	platforms["pl1"]= platform:new(parms)
	table.insert(platforms, platforms["pl1"])

	parms.x = 1100
	parms.y = 520
	table.insert(platforms, platform:new(parms))
	parms.x = 1000
	parms.y = 600 
	--table.insert(platforms, platform:new(parms))
	platforms["pl2"]= platform:new(parms)
	parms.x = 1200
	parms.y = 460
	table.insert(platforms, platform:new(parms)) 


	parms.x = -200
	parms.y = 700
	platforms["plhatch"]= platform:new(parms) 


	parms.x = -175
	parms.y = 440
	table.insert(platforms, platform:new(parms))

	parms.x = -330
	parms.y = 350
	table.insert(platforms, platform:new(parms))


	parms.x = -20
	parms.y = 220 
	table.insert(platforms, platform:new(parms))
	-- parms.x = 580
	-- parms.y = 260
	-- table.insert(platforms, platform:new(parms) )

	end
M.addPlatforms = addPlatforms
return M