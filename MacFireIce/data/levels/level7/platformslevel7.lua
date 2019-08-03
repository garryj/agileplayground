local M={}
local function addPlatforms()
parms={}

parms.isVisible = true

parms.doPhysics=true


parms = {x=170, y=220}

table.insert(platforms, platform:new(parms))
parms = {x=445, y=290}

table.insert(platforms, platform:new(parms))
parms = {x=120, y=550}

table.insert(platforms, platform:new(parms))
parms = {x=565, y=550}

table.insert(platforms, platform:new(parms))
parms = {x=170, y=695}

table.insert(platforms, platform:new(parms))
end
	M.addPlatforms = addPlatforms
return M