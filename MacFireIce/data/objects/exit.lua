--exit.lua

local exit = {}


function exit:new(parms) 

	bindTrick = nil

	if parms.name then
	else
		parms.name = "exit"
	end
	parms.img = "portal.png"
	parms.ss_height=90
	parms.ss_width=100
	parms.ss_frames = 1
	parms.gravity="static"
	parms.sensor = true
	parms.soundTouch = "exit.wav"
	parms.bindTrick = bindTrick
	parms.doPhysics = true

	instance = collectible:new(parms)

	

	return instance
end
return exit 

