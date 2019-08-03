local M = {}
local function addWalls()parms = {x=940, y = 160, img="wall_left.png", ssWidth =120 , ssHeight = 590 , ssNumFrames = 1, doPhysics= true}
parms.img = "wall_left.png"

table.insert(walls, wall:new(parms))
parms = {x=390, y=90, ssWidth =365 , ssHeight = 50 , ssNumFrames = 1, doPhysics= true}
parms.img = "wall_top.png"

table.insert(walls, wall:new(parms))

end
M.addWalls = addWalls
return M