	local M = {}
local function addCollectibles()

bindTrick = {funct="disappear"}
	parms = {name="lever1", img = "leverpull.png", ss_height=46, ss_width=50, ss_frames = 3, x=260, y= 650, gravity="static", sensor = true, soundTouch = "lever_pull.wav", bind = platforms["pl2"], bindTrick = bindTrick}
	

	parms.doPhysics = true
	col1 = collectible:new(parms)

	-- parms.x = 500
	-- parms.y = ph-40
	-- parms.name = "lever2"


	-- col2 = collectible:new(parms)

	-- parms.img="leverpullleft.png"
	-- parms.ss_width = 46
	-- parms.ss_height = 50
	-- parms.x = pw - 390
	-- parms.y = 300
	-- parms.name = "lever3"
	-- parms.bind = platforms["pl1"]
	-- parms.bindTrick = {funct="moveRight"}
	-- col3 = collectible:new(parms) 


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
	parms = {name="key", img = "key.png", ss_height=45, ss_width=94, ss_frames = 1, x=310, y= 510, gravity="static", sensor = true, soundTouch = "keycollect.wav", bindTrick = bindTrick, doPhysics = true}
	parms.bind = colDoor
	colKey = collectible:new(parms)


	
	parms = {name="exitsign", img = "exitSign.png", ss_height=67, ss_width=98, ss_frames = 1, x=paw - 40, y= pah - 40, gravity="static", sensor = true, doPhysics = false}
	colExitSign = collectible:new(parms)

	bindTrick = {funct="disappear"}
	parms = {name="diamond1", img = "diamondspinning.png", ss_height=30, ss_width=30, ss_frames = 7, x=paw - 40, y= pah - 170, gravity="static",soundTouch = "diamondcollect.wav",  sensor = true, doPhysics = true, score = 40, bindTrick = bindTrick}
	
	colDiamond1 = collectible:new(parms)
	

	table.insert(collectibles, col1)
	table.insert(collectibles, col2)
	table.insert(collectibles, col3)
	collectibles["key"] = colKey
	collectibles["exit"]= colExit
	collectibles["door"]= colDoor
	collectibles["exitsign"]= colExitSign
	collectibles["diamond1"]= colDiamond1

end

M.addCollectibles = addCollectibles
return M

