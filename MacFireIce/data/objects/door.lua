
local door = {}
local door_mt = {__index=enemy}

function door:new(parms) 

bindTrick = {funct="disappear"}
parms.name = "door"
parms.img = "door.png"
parms.ss_height=160
parms.ss_width=101
parms.ss_frames = 1
parms.gravity="static"
parms.sensor = false
parms.soundTouch = "dooropen.wav"
parms.bindTrick = bindTrick
parms.doPhysics = true

	-- parms = {name="door", img = "door.png", ss_height=160, ss_width=101, ss_frames = 1, x=100, y= 100, gravity="static", sensor = false, soundTouch = "dooropen.wav", bindTrick = bindTrick, doPhysics = true}
	-- print ("Adding door")
	instance = collectible:new(parms)

	if openExit ==true then
	  instance.display.x = offScreenX  
	end

	return instance
end
return door