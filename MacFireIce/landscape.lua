--Landscape
local ls = {}

function ls.start() 
	
	return ls.create()
end

function ls.create() 
	lsCnt=lsCnt + 1
	ls.img = IMG_DIR.."ground.png"
	ls.width = GROUND_WIDTH
	ls.height = GROUND_HEIGHT
	ls.name = "bg"..bgCnt
	ls.speed = 1
	ls.name="landscape"
	return ls
end

function ls.add()
	ls.display = display.newImageRect(ls.img, ls.width,ls.height)
	ls.display.x = display.contentCenterX
	ls.display.y = display.contentHeight
	ls.display.name = ls.name
	physics.addBody(ls.display, "static")
	moveable[ls.name] = ls
end

return ls