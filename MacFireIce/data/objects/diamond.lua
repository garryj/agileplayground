--diamond

local diamond = {}


function diamond:new(parms) 

bindTrick = {funct="disappear"}
if parms.name then
else
	parms.name = "diamond"
end

parms.img = "diamondspinning.png"
parms.ss_height=30
parms.ss_width=30
parms.ss_frames = 7
if parms.gravity then
else
	parms.gravity = "static"
end

parms.sensor = true
parms.soundTouch = "diamondcollect.wav"
parms.bindTrick = bindTrick
parms.doPhysics = true

if parms.score then
else
	parms.score = 40
end


	
	instance = collectible:new(parms)

	

	return instance
end
return diamond