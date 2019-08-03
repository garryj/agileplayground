--wall
local wall = {}


local sw = 49
local sh = 703
local fr = 1
local scw = 49
local sch = 703

local sequenceData = {
                { name="seq1", sheet=sheetWall, start=1, count=1, time=220, loopCount=0 }
                }
 
function wall.start(typ) 

	return wall.create(typ)
end

function wall.create(typ)
	
	wallCnt=wallCnt + 1
	wall.img = IMG_DIR.."wall_"..typ..".png"
	print ("creating wall "..wall.img) 
	print (wall.img)
	wall.name = "wall"..wallCnt 
	
	if typ =="left" then
		print "left"
		sw = 49
		sh = 703
		fr = 1
		scw = 49
		sch = 703
	end
	if typ =="top" then
		print "top"
		sw = 703
		sh = 49
		fr = 1
		scw = 703
		sch = 49
	end
	return ls
end

function wall.add(x, y)
	--wall.display = display.newImageRect(wall.img, wall.width,wall.height)
	local sheetDataWall = { width=sw, height=sh, numFrames=fr, sheetContentWidth=scw, sheetContentHeight=sch }
	local sheetWall = graphics.newImageSheet(wall.img, sheetDataWall )
	print (sheetWall) 
	wall.display = display.newSprite( sheetWall , sequenceData )
	wall.display.x = x
	wall.display.y = y
	wall.display:play()

	
	
	wall.display.name = wall.name
	physics.addBody(wall.display, "static")
	moveable[wall.name] = wall

	table.insert(walls, wall)
end

return wall