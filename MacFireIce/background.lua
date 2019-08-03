-- Background file
local bg = {}

function bg.start() 
	print ("Starting background initiation for "..Game.." "..IMG_DIR)
	return bg.create()
end

function bg.create() 
	bgCnt=bgCnt + 1
	bg.img = IMG_DIR.."wall_bg.png"
	bg.width = BACKGROUND_WIDTH
	bg.height = BACKGROUND_HEIGHT
	bg.name = "bg"..bgCnt
	bg.speed = 1

	return bg
end

function bg.add()
	bg.display = display.newImageRect(bg.img, bg.width,bg.height)
	bg.display.name = bg.name
	moveable[bg.name] = bg
end

return bg