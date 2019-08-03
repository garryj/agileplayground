	local M = {}
	local function addPlatforms()
	parms = {}
	
	parms.isVisible = true
	parms.doPhysics = true

 	parms.x = 5
	parms.y = 350

	table.insert(platforms, platform:new(parms))

	parms.x = 200 
	parms.y = 550

	table.insert(platforms, platform:new(parms))
	end
	M.addPlatforms = addPlatforms
return M