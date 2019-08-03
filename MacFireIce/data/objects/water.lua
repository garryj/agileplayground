--water.lua


local water = {}

local sequences = {
		
	{name = "default",
	        start = 1,
	        count = 62,
	        time = 8200,
	        loopCount = 500,
	        loopDirection = "forward"

	}
}

local sequenceOptions = 
{
	    width = 310,
	    height = 80,
	    numFrames = 63
}

function water:new(parms) 

	

	if parms.name then
	else
		parms.name = "water"
	end

	parms.img = "waterwave.png"
	parms.ss_height=32
	parms.ss_width=128
	parms.ss_frames = 2
	parms.gravity="static"
	parms.sensor = true
	parms.soundTouch = "drip.mp3"
	parms.doPhysics = true
	parms.sequences = sequences
	parms.sequenceOptions = sequenceOptions



	
	instance = collectible:new(parms)

	

	return instance
end
return water


