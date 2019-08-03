	local M = {}
	local function addPlatforms()
	parms = {}
	
	parms.isVisible = true
	parms.doPhysics = true


	parms.x = 5
	parms.y = 350
	platforms["pl1"]= platform:new(parms)
	table.insert(platforms, platforms["pl1"])

parms.x = -175
	parms.y = 350
	platforms["pl2"]= platform:new(parms)
	table.insert(platforms, platforms["pl2"])

	end
	M.addPlatforms = addPlatforms
return M