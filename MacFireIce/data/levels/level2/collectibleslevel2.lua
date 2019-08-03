	local M = {}
local function addCollectibles()


	--Invisible exit collision bit
	bindTrick = nil
	parms = {name="exit", img = "exit.png", ss_height=116, ss_width=114, ss_frames = 1, x=pw-285, y= ph - 100, gravity="static", sensor = true, soundTouch = "exit.wav", doPhysics = true}
	colExit = collectible:new(parms)


	--exit door
	bindTrick = {funct="disappear"}
	parms = {name="door", img = "door.png", ss_height=160, ss_width=101, ss_frames = 1, x=pw-355, y= ph - 100, gravity="static", sensor = false, soundTouch = "dooropen.wav", bindTrick = bindTrick, doPhysics = true}
	print ("Adding door")
	colDoor = collectible:new(parms)

	if openExit ==true then
	  colDoor.display.x = offScreenX 
	end
 
 
	bindTrick = {funct="disappear"}
	parms = {name="key", img = "key.png", ss_height=45, ss_width=94, ss_frames = 1, x=410, y= 510, gravity="static", sensor = true, soundTouch = "keycollect.wav", bindTrick = bindTrick, doPhysics = true}
	parms.bind = colDoor
	colKey = collectible:new(parms)


parms = {name="exitsign", img = "exitSign.png", ss_height=67, ss_width=98, ss_frames = 1, x=paw - 40, y= pah - 40, gravity="static", sensor = true, doPhysics = false}
	colExitSign = collectible:new(parms)
	
	
	collectibles["key"] = colKey
	collectibles["exit"]= colExit
	collectibles["door"]= colDoor

	
end

M.addCollectibles = addCollectibles
return M
