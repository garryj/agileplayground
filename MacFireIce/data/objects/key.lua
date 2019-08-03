--key.lua
local key = {}
local key_mt = {__index=enemy}

function key:new(parms) 

bindTrick = {funct="disappear"}
parms.name = "key"
parms.img = "key.png"
parms.ss_height=45
parms.ss_width=94
parms.ss_frames = 1
parms.gravity="static"
parms.sensor = true
parms.soundTouch = "keycollect.wav"
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
return key


 