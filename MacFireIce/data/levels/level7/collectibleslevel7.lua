local M={}
local function addCollectibles()
parms = {x=485, y=187}
collectibles["exit"] = require ("data.objects.exit"):new(parms)
parms = {x=485, y=187}
collectibles["door"] = require ("data.objects.door"):new(parms)

parms = {x=445, y=725}
parms.bind = collectibles["door"]
collectibles["key"] = require ("data.objects.key"):new(parms)
parms = {x=195, y=510, name=="diamond1"}
collectibles["diamond1"] = require ("data.objects.diamond"):new(parms)
parms = {x=600, y=505, name=="diamond2"}
collectibles["diamond2"] = require ("data.objects.diamond"):new(parms)
end

M.addCollectibles = addCollectibles
return M