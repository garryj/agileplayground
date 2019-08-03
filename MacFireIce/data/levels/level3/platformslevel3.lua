	local M = {}
	local function addPlatforms()
parms = {}
	parms.x = 200
	parms.y = 380
	parms.isVisible = true
	parms.doPhysics = true
	platforms["pl1"]= platform:new(parms)
	table.insert(platforms, platforms["pl1"])

parms.isVisible = true
	parms.x = 1100
	parms.y = 520
	table.insert(platforms, platform:new(parms))
	parms.x = 1000
	parms.y = 600
	table.insert(platforms, platform:new(parms))
	parms.x = 1200
	parms.y = 460
	table.insert(platforms, platform:new(parms))
	parms.x = 580
	parms.y = 260
	table.insert(platforms, platform:new(parms) )

	parms.isVisible = false
	parms.doPhysics = false
	parms.x = 900
	parms.y = 700
	platforms["pl2"]= platform:new(parms) 
	--table.insert(platforms, platform:new(parms) )

	
end
	M.addPlatforms = addPlatforms
return M