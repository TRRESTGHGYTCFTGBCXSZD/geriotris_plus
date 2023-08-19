function createpieceset(image,dividerwidth,dividerheight)
	local piecetypedata = {}
	local crop = love.image.newImageData(image:getWidth()/dividerwidth,image:getHeight()/dividerheight)
	for dividy = 0,dividerheight-1 do
	for dividx = 0,dividerwidth-1 do
	crop:paste(image,0,0,dividx*(image:getWidth()/dividerwidth),dividy*(image:getHeight()/dividerheight))
	table.insert(piecetypedata,love.graphics.newImage(crop))
	end
	end
	return piecetypedata
end
function LoadImageFromTetris(...)
	succ,dors = pcall(function(...) return love.graphics.newImage(...) end, ...)
	if not succ then return love.graphics.newImage("data/graphics/common/error.png") end
	return dors
end
--function love.errorhandler(msg)
--	return 1
--end
function reportErrorAndRestart(err)
	local errHandler  = love.errorhandler or love.errhand
	local errMainLoop = errHandler(err)

	repeat until errMainLoop() -- Repeat until the callback returns an exit code.

	-- We can restart the game now.
	love.load()
end
	local discordRPC = require("data.scripts.discordRPC")
	howtoplay_normal_keyinput = require("data.howto.normal")
	RotationSys = {}
	RotationSys.SRS = require("data.rotationsystem.SRS")
	RotationSys.ARS = require("data.rotationsystem.ARS")
	RotationSys.CSARS = require("data.rotationsystem.CS-ARS")
	RotationSys.TP2ARS = require("data.rotationsystem.TP2-ARS")
	frames = 0
	frameticks = 0
	blockframeticks1 = 0
	blockframeticks2 = 0
	didnaplay = true
	scene="battle_normal"
	bit32 = require("bit")
	love.graphics.setBackgroundColor(0, 0, 0, 0)
	tetrisplusassets = {}
	tetrisplusassets.common = {}
	tetrisplusassets.blocks = {}
	local rr = love.image.newImageData("data/graphics/gameplay/blocks/tgm.png")
	tetrisplusassets.blocks.tgm = createpieceset(rr,4,2)
	tetrisplusassets.blocks.tgm.refassets = {["G"]=1,["Z"]=2,["L"]=3,["O"]=4,["S"]=5,["I"]=6,["J"]=7,["T"]=8,}
	rr:release()
	local rr = love.image.newImageData("data/graphics/gameplay/blocks/tgm_guideline.png")
	tetrisplusassets.blocks.tgmglow = createpieceset(rr,4,2)
	tetrisplusassets.blocks.tgmglow.refassets = {["G"]=1,["Z"]=2,["L"]=3,["O"]=4,["S"]=5,["I"]=6,["J"]=7,["T"]=8,}
	rr:release()
	local rr = love.image.newImageData("data/graphics/gameplay/blocks/t99_git.png")
	tetrisplusassets.blocks.bombliss = createpieceset(rr,4,2)
	tetrisplusassets.blocks.bombliss.refassets = {["G"]=1,["I"]=2,["L"]=3,["O"]=4,["Z"]=5,["T"]=6,["J"]=7,["S"]=8,}
	rr:release()
	tetrisplusassets.playfields = {}
	tetrisplusassets.playfields.normal = {}
	tetrisplusassets.playfields.normal.borderleft = LoadImageFromTetris("data/graphics/gameplay/playfields/normal_left.png")
	tetrisplusassets.playfields.normal.borderleft:setFilter("nearest", "nearest")
	tetrisplusassets.playfields.normal.borderright = LoadImageFromTetris("data/graphics/gameplay/playfields/normal_right.png")
	tetrisplusassets.playfields.normal.borderright:setFilter("nearest", "nearest")
	local rr = love.image.newImageData("data/graphics/gameplay/playfields/normal_glowie.png")
	tetrisplusassets.playfields.normal.glowie = createpieceset(rr,2,8)
	tetrisplusassets.playfields.taisen = {}
	tetrisplusassets.playfields.taisen.normborderleft = LoadImageFromTetris("data/graphics/gameplay/playfields/vs_normleft.png")
	tetrisplusassets.playfields.taisen.normborderright = LoadImageFromTetris("data/graphics/gameplay/playfields/vs_normright.png")
	rr:release()
	tetrisplusassets.attract = {}
	tetrisplusassets.attract.mainmusic = love.audio.newSource("data/music/attract_main.mp3", "stream")
	tetrisplusassets.attract.howtoplaymusic = love.audio.newSource("data/music/attract_howto.mp3", "stream")
	tetrisplusassets.attract.howtoplaymusic:setLooping(true)
	tetrisplusassets.attract.logo = LoadImageFromTetris("data/graphics/attract_main/logo.png")
	tetrisplusassets.attract.assileft = LoadImageFromTetris("data/graphics/attract_main/assi_front.png")
	tetrisplusassets.attract.assileft:setFilter("nearest", "nearest")
	tetrisplusassets.attract.assiglow = LoadImageFromTetris("data/graphics/attract_main/assi_effect.png")
	tetrisplusassets.attract.assiglow:setFilter("nearest", "nearest")
	tetrisplusassets.attract.assiright = LoadImageFromTetris("data/graphics/attract_main/assi_right.png")
	tetrisplusassets.attract.assiright:setFilter("nearest", "nearest")
	tetrisplusassets.attract.proftop = LoadImageFromTetris("data/graphics/attract_main/prof_front.png")
	tetrisplusassets.attract.proftop:setFilter("nearest", "nearest")
	tetrisplusassets.attract.profglow = LoadImageFromTetris("data/graphics/attract_main/prof_effect.png")
	tetrisplusassets.attract.profglow:setFilter("nearest", "nearest")
	tetrisplusassets.attract.profbottom = LoadImageFromTetris("data/graphics/attract_main/prof_bottom.png")
	tetrisplusassets.attract.profbottom:setFilter("nearest", "nearest")
	tetrisplusassets.attract.normalmodetext = LoadImageFromTetris("data/graphics/attract_main/normal_text.png")
	tetrisplusassets.attract.normalmodeleft = LoadImageFromTetris("data/graphics/attract_main/normal_leftbox.png")
	tetrisplusassets.attract.normalmodeleft:setFilter("nearest", "nearest")
	tetrisplusassets.attract.normalmoderight = LoadImageFromTetris("data/graphics/attract_main/normal_rightbox.png")
	tetrisplusassets.attract.normalmoderight:setFilter("nearest", "nearest")
	tetrisplusassets.attract.puzzlemodetext = LoadImageFromTetris("data/graphics/attract_main/puzzle_text.png")
	tetrisplusassets.attract.puzzlemodeleft = LoadImageFromTetris("data/graphics/attract_main/puzzle_leftbox.png")
	tetrisplusassets.attract.puzzlemodeleft:setFilter("nearest", "nearest")
	tetrisplusassets.attract.puzzlemoderight = LoadImageFromTetris("data/graphics/attract_main/puzzle_rightbox.png")
	tetrisplusassets.attract.puzzlemoderight:setFilter("nearest", "nearest")
	tetrisplusassets.attract.vsmodetext = LoadImageFromTetris("data/graphics/attract_main/vs_text.png")
	tetrisplusassets.attract.vsmode = LoadImageFromTetris("data/graphics/attract_main/vs_tallbox.png")
	tetrisplusassets.attract.vsmode:setFilter("nearest", "nearest")
	tetrisplusassets.taisen = {}
	tetrisplusassets.taisen.music = love.audio.newSource("data/music/game_vs.ogg", "stream")
	tetrisplusassets.taisen.music:setLooping(true)
	tetrisplusassets.taisen.bg = LoadImageFromTetris("data/graphics/gameplay/background/taisen_wide.png")
--[[	bg = LoadImageFromTetris("bg.png")
	board = LoadImageFromTetris("board.png")
	music = love.audio.newSource("music.ogg", "stream")
	music:setLooping(true)
	music:play()
	pieceimagetype = {}
	pieceimagetype.I = LoadImageFromTetris("piece_t.png")
	pieceimagetype.O = LoadImageFromTetris("piece_o.png")
	pieceimagetype.T = LoadImageFromTetris("piece_s.png")
	pieceimagetype.J = LoadImageFromTetris("piece_j.png")
	pieceimagetype.L = LoadImageFromTetris("piece_l.png")
	pieceimagetype.Z = LoadImageFromTetris("piece_i.png")
	pieceimagetype.S = LoadImageFromTetris("piece_z.png")
	pieceimagetype.G = LoadImageFromTetris("piece_garbage.png")
	pieceimagetype.Active = LoadImageFromTetris("piece_active.png")
	pieceimagetype.ActiveDark = LoadImageFromTetris("piece_activedark.png")
	pieceimagetype.ActiveHold = LoadImageFromTetris("piece_activehold.png")
	garbageimagetype = {}
	garbageimagetype.red = LoadImageFromTetris("garbagebar_red.png")
	garbageimagetype.yellow = LoadImageFromTetris("garbagebar_yellow.png")
	garbageimagetype.white = LoadImageFromTetris("garbagebar_white.png")
	boardwin = LoadImageFromTetris("boardwin.png")
	boardlose = LoadImageFromTetris("boardlose.png")
	boarddraw = LoadImageFromTetris("boarddraw.png")
	perfectclearboard = LoadImageFromTetris("boardpc.png")
	floored = love.audio.newSource("sakura/floor.ogg", "static")
	lock = love.audio.newSource("sakura/sonic.ogg", "static")
	move = love.audio.newSource("sakura/move.ogg", "static")
	rotate = love.audio.newSource("sakura/rotate.ogg", "static")
	prerotate = love.audio.newSource("sakura/prerotate.ogg", "static")
	prehold = love.audio.newSource("prehold.wav", "static")
	garbagekick = love.audio.newSource("rowraise.wav", "static")
	lineclear = love.audio.newSource("lineclear.wav", "static")
	dead = love.audio.newSource("smack.wav", "static")
	vanishdead = love.audio.newSource("doublebonk.wav", "static")
	tspinnotify = love.audio.newSource("tspin.ogg", "static")
	softlock = love.audio.newSource("sakura/lock.ogg", "static")
	lineclearsingle = love.audio.newSource("linesingle.wav", "static")
	linecleardouble = love.audio.newSource("linedouble.wav", "static")
	linecleartriple = love.audio.newSource("linetriple.wav", "static")
	lineclearquad = love.audio.newSource("linequad.wav", "static")
	finish = love.audio.newSource("finish.wav", "static")
	finishdraw = love.audio.newSource("finishdraw.wav", "static")
	finish1p = love.audio.newSource("p1win.wav", "static")
	finish2p = love.audio.newSource("p2win.wav", "static")
	finishdrawcom = love.audio.newSource("drawgame.wav", "static")
	
	selected = love.audio.newSource("keyselect.wav", "static")
	decided = love.audio.newSource("keyok.wav", "static")
	
	controls = {["P1Left"]={"kbd","left"},["P1Right"]={"kbd","right"},["P1SoftDrop"]={"kbd","down"},["P1HardDrop"]={"kbd","up"},["P1CCW"]={"kbd","z"},["P1CW"]={"kbd","x"},["P1Hold"]={"kbd","space"},
	["P2Left"]={"none","none"},["P2Right"]={"none","none"},["P2SoftDrop"]={"none","none"},["P2HardDrop"]={"none","none"},["P2CCW"]={"none","none"},["P2CW"]={"none","none"},["P2Hold"]={"none","none"},}
	controleating = false
	whatcontroleating = nil--]]
	entrydl = 10
	timepassed = 10
	piecetype={
	["I"]={
	[0]={
	{0,0,0,0},
	{1,1,1,1},
	{0,0,0,0},
	{0,0,0,0},
	},
	[1]={
	{0,0,1,0},
	{0,0,1,0},
	{0,0,1,0},
	{0,0,1,0},
	},
	[2]={
	{0,0,0,0},
	{0,0,0,0},
	{1,1,1,1},
	{0,0,0,0},
	},
	[3]={
	{0,1,0,0},
	{0,1,0,0},
	{0,1,0,0},
	{0,1,0,0},
	},
	},
	["O"]={
	[0]={
	{0,1,1,0},
	{0,1,1,0},
	{0,0,0,0},
	{0,0,0,0},
	},
	[1]={
	{0,1,1,0},
	{0,1,1,0},
	{0,0,0,0},
	{0,0,0,0},
	},
	[2]={
	{0,1,1,0},
	{0,1,1,0},
	{0,0,0,0},
	{0,0,0,0},
	},
	[3]={
	{0,1,1,0},
	{0,1,1,0},
	{0,0,0,0},
	{0,0,0,0},
	},
	},
	["T"]={
	[0]={
	{0,1,0,0},
	{1,1,1,0},
	{0,0,0,0},
	{0,0,0,0},
	},
	[1]={
	{0,1,0,0},
	{0,1,1,0},
	{0,1,0,0},
	{0,0,0,0},
	},
	[2]={
	{0,0,0,0},
	{1,1,1,0},
	{0,1,0,0},
	{0,0,0,0},
	},
	[3]={
	{0,1,0,0},
	{1,1,0,0},
	{0,1,0,0},
	{0,0,0,0},
	},
	},
	["J"]={
	[0]={
	{1,0,0,0},
	{1,1,1,0},
	{0,0,0,0},
	{0,0,0,0},
	},
	[1]={
	{0,1,1,0},
	{0,1,0,0},
	{0,1,0,0},
	{0,0,0,0},
	},
	[2]={
	{0,0,0,0},
	{1,1,1,0},
	{0,0,1,0},
	{0,0,0,0},
	},
	[3]={
	{0,1,0,0},
	{0,1,0,0},
	{1,1,0,0},
	{0,0,0,0},
	},
	},
	["L"]={
	[0]={
	{0,0,1,0},
	{1,1,1,0},
	{0,0,0,0},
	{0,0,0,0},
	},
	[1]={
	{0,1,0,0},
	{0,1,0,0},
	{0,1,1,0},
	{0,0,0,0},
	},
	[2]={
	{0,0,0,0},
	{1,1,1,0},
	{1,0,0,0},
	{0,0,0,0},
	},
	[3]={
	{1,1,0,0},
	{0,1,0,0},
	{0,1,0,0},
	{0,0,0,0},
	},
	},
	["Z"]={
	[0]={
	{1,1,0,0},
	{0,1,1,0},
	{0,0,0,0},
	{0,0,0,0},
	},
	[1]={
	{0,0,1,0},
	{0,1,1,0},
	{0,1,0,0},
	{0,0,0,0},
	},
	[2]={
	{0,0,0,0},
	{1,1,0,0},
	{0,1,1,0},
	{0,0,0,0},
	},
	[3]={
	{0,1,0,0},
	{1,1,0,0},
	{1,0,0,0},
	{0,0,0,0},
	},
	},
	["S"]={
	[0]={
	{0,1,1,0},
	{1,1,0,0},
	{0,0,0,0},
	{0,0,0,0},
	},
	[1]={
	{0,1,0,0},
	{0,1,1,0},
	{0,0,1,0},
	{0,0,0,0},
	},
	[2]={
	{0,0,0,0},
	{0,1,1,0},
	{1,1,0,0},
	{0,0,0,0},
	},
	[3]={
	{1,0,0,0},
	{1,1,0,0},
	{0,1,0,0},
	{0,0,0,0},
	},
	},
	}
	boardencode = {["E"]="_",["I"]="i",["O"]="o",["T"]="t",["J"]="j",["L"]="l",["Z"]="z",["S"]="s",["G"]="#",}
	boarddecode = {["_"]="E",["i"]="I",["o"]="O",["t"]="T",["j"]="J",["l"]="L",["z"]="Z",["s"]="S",["#"]="G",}
	p1 = {}
	p2 = {}
	renderstage = love.graphics.newCanvas(640,480)
	
	
function love.load()
	initplayer(p1)
	initplayer(p2)
		discordRPC.initialize("1130462892190351441", true)
		local now = os.time(os.date("*t"))
		presence = {
			state = "In Menu",
			details = "Attract",
			largeImageKey = "menu",
			--startTimestamp = now,
			--endTimestamp = now + 60,
			--partyId = "party id",
			--partyMax = 2,
			--matchSecret = "match secret",
			--joinSecret = "join secret",
			--spectateSecret = "spectate secret",
		}

    nextPresenceUpdate = 0
end

function discordRPC.ready(userId, username, discriminator, avatar)
    print(string.format("Discord: ready (%s, %s, %s, %s)", userId, username, discriminator, avatar))
end

function discordRPC.disconnected(errorCode, message)
    print(string.format("Discord: disconnected (%d: %s)", errorCode, message))
end

function discordRPC.errored(errorCode, message)
    print(string.format("Discord: error (%d: %s)", errorCode, message))
end

function discordRPC.joinGame(joinSecret)
    print(string.format("Discord: join (%s)", joinSecret))
end

function discordRPC.spectateGame(spectateSecret)
    print(string.format("Discord: spectate (%s)", spectateSecret))
end

function discordRPC.joinRequest(userId, username, discriminator, avatar)
    print(string.format("Discord: join request (%s, %s, %s, %s)", userId, username, discriminator, avatar))
    discordRPC.respond(userId, "yes")
end
function lerp(a,b,t) return a * (1-t) + b * t end
function getgravityforlevel(level)
	return (1/60)/((.8-((level-1)*.007))^(level-1))
end
	function tablltablltabllcontains(list, x)
		for _, v in pairs(list) do
			if v == x then return true end
		end
		return false
	end
	function tablltablltabllelsecontains(list, x)
		for _, v in pairs(list) do
			if v ~= x then return true end
		end
		return false
	end
	function deepCopy(original)
		local copy = {}
		for k, v in pairs(original) do
			if type(v) == "table" then
				v = deepCopy(v)
			end
			copy[k] = v
		end
		return copy
	end
	function readboard(spacing,memlocation,yspacing,globalyspacing,writeinreverse)
		local boardlist = {}
		for _ = 1, 20 do
			for _, h in pairs(spacing.board[memlocation]) do
				if writeinreverse then
					table.insert(boardlist,1,h)
				else
					table.insert(boardlist,h)
				end
			end
			memlocation=memlocation+1
		end
		return boardlist
	end
	function writeboard(spacing,memlocation,yspacing,globalyspacing,input,readinreverse)
		local boardlist = deepCopy(input)
		if readinreverse then
			for h = 20, 1, -1 do
				assistant = {}
				assistant[1] = boardlist[(h*10)-9]
				assistant[2] = boardlist[(h*10)-8]
				assistant[3] = boardlist[(h*10)-7]
				assistant[4] = boardlist[(h*10)-6]
				assistant[5] = boardlist[(h*10)-5]
				assistant[6] = boardlist[(h*10)-4]
				assistant[7] = boardlist[(h*10)-3]
				assistant[8] = boardlist[(h*10)-2]
				assistant[9] = boardlist[(h*10)-1]
				assistant[10] = boardlist[(h*10)]
				spacing.board[h] = assistant
			end
		else
			for h = 1, 20 do
				assistant = {}
				assistant[1] = boardlist[(h*10)-9]
				assistant[2] = boardlist[(h*10)-8]
				assistant[3] = boardlist[(h*10)-7]
				assistant[4] = boardlist[(h*10)-6]
				assistant[5] = boardlist[(h*10)-5]
				assistant[6] = boardlist[(h*10)-4]
				assistant[7] = boardlist[(h*10)-3]
				assistant[8] = boardlist[(h*10)-2]
				assistant[9] = boardlist[(h*10)-1]
				assistant[10] = boardlist[(h*10)]
				spacing.board[h] = assistant
			end
		end
	end
	function encodeboard(boardlist,reftable)
		local encoding = ""
		for _,h in pairs(boardlist) do
			encoding = encoding .. reftable[h]
		end
		return encoding
	end
	function decodeboard(boardstring,reftable)
		local decoding = {}
		for h = 1, string.len(boardstring) do
			decoding[h] = reftable[string.sub(boardstring,h,h)]
		end
		return decoding
	end
function initplayer(player)
	player.board=
	{
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	{"E","E","E","E","E","E","E","E","E","E",},
	}
	player.pieceactive=false
	player.piecex=0
	player.piecey=0
	player.piecerotation=0
	player.piececurrent="E"
	player.piecequeue=sevenbag()
	player.attackincoming=0
	player.linecleartrigger=false
	player.lineclears=0
	player.dead=false
	player.ccwinput=false
	player.ccwlock=false
	player.cwinput=false
	player.cwlock=false
	player.holdinput=false
	player.holdlock=false
	player.holdpiece="E"
	player.tspin="no"
	player.btbs=-1
	player.combo=-1
	player.perfectclear=false
	player.leftinput=false
	player.leftdas=10
	player.rightinput=false
	player.rightdas=10
	player.sdinput=false
	player.hdinput=false
	player.donotnext=false
	player.stillholding=false
	player.amisafe=true
	player.downwardtime=0
	player.movereset=15
	player.rotreset=15
	player.locktime=30
	player.perfectclearframes=0
	player.are=0
	player.gravity=0
	player.playsound={["land"]=false,["rotateleft"]=false,["rotateright"]=false,["harddrop"]=false,["harddropfloor"]=false,["lock"]=false,["moveleft"]=false,["moveright"]=false,["hold"]=false,["prerotate"]=false,["prehold"]=false,["sonic"]=false,["lockout"]=false,["blockout"]=false,["row40out"]=false,["lineclear"]=false,["professor"]=false,}
	player.professor={["x"]=0,["y"]=0,["state"]="idle",["falling"]="notyet",["climbing"]="notyet",["climbingheight"]=0,["sleeping"]="notyet",["frames"]=0,["specialframes"]=0,}
	player.spikey=0
end
function collidetest(board,x,y)
	local clipping = false
	if x <= 0 or x >= 11 or (y <= 0 and (x <= 0 or x >= 11)) or y >= 41 then
		clipping = true
	else
		if y >= 1 then
			if board[y][x] ~= "E" then
				clipping = true
			end
		end
	end
	return clipping
end
function ShuffleInPlace(t)
    for i = #t, 2, -1 do
        local j = love.math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end
function sevenbag()
	local bag = {"I","O","T","J","L","Z","S",}
	ShuffleInPlace(bag)
	return bag
end
function onKeypressed(key, scancode, isrepeat)
	if key == "r" then
		love.event.quit( "restart" )
	end
end
--[[function love.keypressed(key, scancode, isrepeat)
	if controleating then
	controls[whatcontroleating][1] = "kbd"
	controls[whatcontroleating][2] = key
	controleating = false
	love.audio.stop(decided)
	love.audio.play(decided)
	else
	if controls.P1CCW[1] == "kbd" and key == controls.P1CCW[2] then
		p1.ccwinput=true
	end
	if controls.P1CW[1] == "kbd" and key == controls.P1CW[2] then
		p1.cwinput=true
	end
	if controls.P1Left[1] == "kbd" and key == controls.P1Left[2] then
		p1.leftinput=true
	end
	if controls.P1Right[1] == "kbd" and key == controls.P1Right[2] then
		p1.rightinput=true
	end
	if controls.P1SoftDrop[1] == "kbd" and key == controls.P1SoftDrop[2] then
		p1.sdinput=true
	end
	if controls.P1HardDrop[1] == "kbd" and key == controls.P1HardDrop[2] then
		p1.hdinput=true
	end
	if controls.P1Hold[1] == "kbd" and key == controls.P1Hold[2] then
		p1.holdinput=true
	end
	if controls.P2CCW[1] == "kbd" and key == controls.P2CCW[2] then
		p2.ccwinput=true
	end
	if controls.P2CW[1] == "kbd" and key == controls.P2CW[2] then
		p2.cwinput=true
	end
	if controls.P2Left[1] == "kbd" and key == controls.P2Left[2] then
		p2.leftinput=true
	end
	if controls.P2Right[1] == "kbd" and key == controls.P2Right[2] then
		p2.rightinput=true
	end
	if controls.P2SoftDrop[1] == "kbd" and key == controls.P2SoftDrop[2] then
		p2.sdinput=true
	end
	if controls.P2HardDrop[1] == "kbd" and key == controls.P2HardDrop[2] then
		p2.hdinput=true
	end
	if controls.P2Hold[1] == "kbd" and key == controls.P2Hold[2] then
		p2.holdinput=true
	end
	end
end
function love.keyreleased(key)
	if controls.P1CCW[1] == "kbd" and key == controls.P1CCW[2] then
		p1.ccwinput=false
	end
	if controls.P1CW[1] == "kbd" and key == controls.P1CW[2] then
		p1.cwinput=false
	end
	if controls.P1Left[1] == "kbd" and key == controls.P1Left[2] then
		p1.leftinput=false
	end
	if controls.P1Right[1] == "kbd" and key == controls.P1Right[2] then
		p1.rightinput=false
	end
	if controls.P1SoftDrop[1] == "kbd" and key == controls.P1SoftDrop[2] then
		p1.sdinput=false
	end
	if controls.P1HardDrop[1] == "kbd" and key == controls.P1HardDrop[2] then
		p1.hdinput=false
	end
	if controls.P1Hold[1] == "kbd" and key == controls.P1Hold[2] then
		p1.holdinput=false
	end
	if controls.P2CCW[1] == "kbd" and key == controls.P2CCW[2] then
		p2.ccwinput=false
	end
	if controls.P2CW[1] == "kbd" and key == controls.P2CW[2] then
		p2.cwinput=false
	end
	if controls.P2Left[1] == "kbd" and key == controls.P2Left[2] then
		p2.leftinput=false
	end
	if controls.P2Right[1] == "kbd" and key == controls.P2Right[2] then
		p2.rightinput=false
	end
	if controls.P2SoftDrop[1] == "kbd" and key == controls.P2SoftDrop[2] then
		p2.sdinput=false
	end
	if controls.P2HardDrop[1] == "kbd" and key == controls.P2HardDrop[2] then
		p2.hdinput=false
	end
	if controls.P2Hold[1] == "kbd" and key == controls.P2Hold[2] then
		p2.holdinput=false
	end
end
function love.gamepadpressed(control, key)
	if controleating then
	controls[whatcontroleating][1] = control
	controls[whatcontroleating][2] = key
	controleating = false
	love.audio.stop(decided)
	love.audio.play(decided)
	else
	if controls.P1CCW[1] == control and key == controls.P1CCW[2] then
		p1.ccwinput=true
	end
	if controls.P1CW[1] == control and key == controls.P1CW[2] then
		p1.cwinput=true
	end
	if controls.P1Left[1] == control and key == controls.P1Left[2] then
		p1.leftinput=true
	end
	if controls.P1Right[1] == control and key == controls.P1Right[2] then
		p1.rightinput=true
	end
	if controls.P1SoftDrop[1] == control and key == controls.P1SoftDrop[2] then
		p1.sdinput=true
	end
	if controls.P1HardDrop[1] == control and key == controls.P1HardDrop[2] then
		p1.hdinput=true
	end
	if controls.P1Hold[1] == control and key == controls.P1Hold[2] then
		p1.holdinput=true
	end
	if controls.P2CCW[1] == control and key == controls.P2CCW[2] then
		p2.ccwinput=true
	end
	if controls.P2CW[1] == control and key == controls.P2CW[2] then
		p2.cwinput=true
	end
	if controls.P2Left[1] == control and key == controls.P2Left[2] then
		p2.leftinput=true
	end
	if controls.P2Right[1] == control and key == controls.P2Right[2] then
		p2.rightinput=true
	end
	if controls.P2SoftDrop[1] == control and key == controls.P2SoftDrop[2] then
		p2.sdinput=true
	end
	if controls.P2HardDrop[1] == control and key == controls.P2HardDrop[2] then
		p2.hdinput=true
	end
	if controls.P2Hold[1] == control and key == controls.P2Hold[2] then
		p2.holdinput=true
	end
	end
end
function love.gamepadreleased(control, key)
	if controls.P1CCW[1] == control and key == controls.P1CCW[2] then
		p1.ccwinput=false
	end
	if controls.P1CW[1] == control and key == controls.P1CW[2] then
		p1.cwinput=false
	end
	if controls.P1Left[1] == control and key == controls.P1Left[2] then
		p1.leftinput=false
	end
	if controls.P1Right[1] == control and key == controls.P1Right[2] then
		p1.rightinput=false
	end
	if controls.P1SoftDrop[1] == control and key == controls.P1SoftDrop[2] then
		p1.sdinput=false
	end
	if controls.P1HardDrop[1] == control and key == controls.P1HardDrop[2] then
		p1.hdinput=false
	end
	if controls.P1Hold[1] == control and key == controls.P1Hold[2] then
		p1.holdinput=false
	end
	if controls.P2CCW[1] == control and key == controls.P2CCW[2] then
		p2.ccwinput=false
	end
	if controls.P2CW[1] == control and key == controls.P2CW[2] then
		p2.cwinput=false
	end
	if controls.P2Left[1] == control and key == controls.P2Left[2] then
		p2.leftinput=false
	end
	if controls.P2Right[1] == control and key == controls.P2Right[2] then
		p2.rightinput=false
	end
	if controls.P2SoftDrop[1] == control and key == controls.P2SoftDrop[2] then
		p2.sdinput=false
	end
	if controls.P2HardDrop[1] == control and key == controls.P2HardDrop[2] then
		p2.hdinput=false
	end
	if controls.P2Hold[1] == control and key == controls.P2Hold[2] then
		p2.holdinput=false
	end
end
function love.gamepadaxis(control, key, activation)
	if controleating and activation >= 0.5 then
	controls[whatcontroleating][1] = control
	controls[whatcontroleating][2] = key
	love.audio.stop(decided)
	love.audio.play(decided)
	else
	if controls.P1CCW[1] == control and key == controls.P1CCW[2] then
		p1.ccwinput=activation >= 0.5
	end
	if controls.P1CW[1] == control and key == controls.P1CW[2] then
		p1.cwinput=activation >= 0.5
	end
	if controls.P1Left[1] == control and key == controls.P1Left[2] then
		p1.leftinput=activation >= 0.5
	end
	if controls.P1Right[1] == control and key == controls.P1Right[2] then
		p1.rightinput=activation >= 0.5
	end
	if controls.P1SoftDrop[1] == control and key == controls.P1SoftDrop[2] then
		p1.sdinput=activation >= 0.5
	end
	if controls.P1HardDrop[1] == control and key == controls.P1HardDrop[2] then
		p1.hdinput=activation >= 0.5
	end
	if controls.P1Hold[1] == control and key == controls.P1Hold[2] then
		p1.holdinput=activation >= 0.5
	end
	if controls.P2CCW[1] == control and key == controls.P2CCW[2] then
		p2.ccwinput=activation >= 0.5
	end
	if controls.P2CW[1] == control and key == controls.P2CW[2] then
		p2.cwinput=activation >= 0.5
	end
	if controls.P2Left[1] == control and key == controls.P2Left[2] then
		p2.leftinput=activation >= 0.5
	end
	if controls.P2Right[1] == control and key == controls.P2Right[2] then
		p2.rightinput=activation >= 0.5
	end
	if controls.P2SoftDrop[1] == control and key == controls.P2SoftDrop[2] then
		p2.sdinput=activation >= 0.5
	end
	if controls.P2HardDrop[1] == control and key == controls.P2HardDrop[2] then
		p2.hdinput=activation >= 0.5
	end
	if controls.P2Hold[1] == control and key == controls.P2Hold[2] then
		p2.holdinput=activation >= 0.5
	end
	end
end
function love.mousepressed( x, y, button, istouch, presses )
	if button ~= 1 then return end
	if controleating then
		love.audio.stop(dead)
		love.audio.play(dead)
		controleating = false
	elseif y < 16*torturey then
		if 0 <= x and x < 16*torturex then
			love.audio.stop(selected)
			love.audio.play(selected)
			controleating = true
			whatcontroleating = "P1CCW"
		end
		if 16*torturex <= x and x < 32*torturex then
			love.audio.stop(selected)
			love.audio.play(selected)
			controleating = true
			whatcontroleating = "P1CW"
		end
		if 32*torturex <= x and x < 48*torturex then
			love.audio.stop(selected)
			love.audio.play(selected)
			controleating = true
			whatcontroleating = "P1Left"
		end
		if 48*torturex <= x and x < 64*torturex then
			love.audio.stop(selected)
			love.audio.play(selected)
			controleating = true
			whatcontroleating = "P1Right"
		end
		if 64*torturex <= x and x < 80*torturex then
			love.audio.stop(selected)
			love.audio.play(selected)
			controleating = true
			whatcontroleating = "P1SoftDrop"
		end
		if 80*torturex <= x and x < 96*torturex then
			love.audio.stop(selected)
			love.audio.play(selected)
			controleating = true
			whatcontroleating = "P1HardDrop"
		end
		if 96*torturex <= x and x < 112*torturex then
			love.audio.stop(selected)
			love.audio.play(selected)
			controleating = true
			whatcontroleating = "P1Hold"
		end
		if 128*torturex <= x and x < 144*torturex then
			love.audio.stop(selected)
			love.audio.play(selected)
			controleating = true
			whatcontroleating = "P2CCW"
		end
		if 144*torturex <= x and x < 160*torturex then
			love.audio.stop(selected)
			love.audio.play(selected)
			controleating = true
			whatcontroleating = "P2CW"
		end
		if 160*torturex <= x and x < 176*torturex then
			love.audio.stop(selected)
			love.audio.play(selected)
			controleating = true
			whatcontroleating = "P2Left"
		end
		if 176*torturex <= x and x < 192*torturex then
			love.audio.stop(selected)
			love.audio.play(selected)
			controleating = true
			whatcontroleating = "P2Right"
		end
		if 192*torturex <= x and x < 208*torturex then
			love.audio.stop(selected)
			love.audio.play(selected)
			controleating = true
			whatcontroleating = "P2SoftDrop"
		end
		if 208*torturex <= x and x <= 224*torturex then
			love.audio.stop(selected)
			love.audio.play(selected)
			controleating = true
			whatcontroleating = "P2HardDrop"
		end
		if 224*torturex <= x and x <= 240*torturex then
			love.audio.stop(selected)
			love.audio.play(selected)
			controleating = true
			whatcontroleating = "P2Hold"
		end
	end
end--]]
function piececollidetest(board,piecetyperr,rotation,x,y)
	clipping = false
	for pies2 = 1 ,4 do
		for pies1 = 1 ,4 do
			if piecetype[piecetyperr][rotation][pies2][pies1] == 1 then
				if collidetest(board,x+pies1-1,y+pies2-1) == true then
					clipping = true
				end
			end
		end
	end
	return clipping
end
function modmod(a,b)return a-math.floor(a/b)*b end
------------------------------------------------------------------------
------------------------------------------------------------------------
--                            GAME  UPDATE                            --
------------------------------------------------------------------------
------------------------------------------------------------------------
function updateplayernormal(player,RotationSystem)
	player.perfectclearframes=player.perfectclearframes-1
	player.are = player.are - 1
	if player.pieceactive == false and player.dead == false and player.are > 0 then
		if (not player.leftinput) or (player.leftinput and player.rightinput) then
			player.leftdas = 10
		end
		if player.leftinput and (not(player.leftinput and player.rightinput)) then
			player.leftdas = player.leftdas - 1
		end
		if (not player.rightinput) or (player.leftinput and player.rightinput) then
			player.rightdas = 10
		end
		if player.rightinput and (not(player.leftinput and player.rightinput)) then
			player.rightdas = player.rightdas - 1
		end
	elseif player.pieceactive == false and player.dead == false and player.are <= 0 then
		player.pieceactive = true
		if not player.donotnext then
			player.piececurrent = table.remove(player.piecequeue,1)
			if #player.piecequeue < 6 then
				for _, h in pairs(sevenbag()) do
					table.insert(player.piecequeue,h)
				end
			end
		end
		player.piecex = 4
		player.piecey = 19
		player.piecerotation = 0
		RotationSystem.InitPosRot(player)
		player.downwardtime = 1
		player.locktime = 30
		player.movereset = 15
		player.rotreset = 15
		player.ccwlock = false
		player.cwlock = false
		player.holdlock = false
		player.tspin = "no"
		if player.ccwinput and player.cwinput then
		player.ccwlock = true
		player.cwlock = true
		end
		if player.ccwinput ~= player.cwinput then
			if player.ccwinput then
				RotationSystem:PreCCW(player)
				player.ccwlock = true
			end
			if player.cwinput then
				if not piececollidetest(player.board,player.piececurrent,1,4,19) then
				player.playsound.prerotate = true
				player.piecerotation = 1
				end
				player.cwlock = true
			end
		end
		if (player.holdinput or player.stillholding) and (not player.donotnext) then
			player.playsound.prehold = true
		end
		if (player.holdinput or player.stillholding) then
			player.holdlock = true
			player.donotnext = false
			player.stillholding = false
			if player.holdpiece == "E" then
				player.holdpiece = player.piececurrent
				player.piececurrent = table.remove(player.piecequeue,1)
				if #player.piecequeue < 6 then
					for _, h in pairs(sevenbag()) do
						table.insert(player.piecequeue,h)
					end
				end
			else
				player.holdpiece, player.piececurrent = player.piececurrent, player.holdpiece
			end
		end
		if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
			player.dead = true
			player.playsound.topout = true
		end
	end
	if player.pieceactive == true and player.dead == false then
		
		player.downwardtime=player.downwardtime+player.gravity
		
		if (not player.leftinput) or (player.leftinput and player.rightinput) then
			player.leftdas = 10
		end
		
		if player.leftinput and (not(player.leftinput and player.rightinput)) then
			if player.leftdas == 10 or player.leftdas < 0 then
				ishemoving = true
				player.piecex = player.piecex - 1
				if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
					ishemoving = false
					player.piecex = player.piecex + 1
				end
				if ishemoving then
				player.playsound.moveleft = true
				end
				if player.locktime < 30 and ishemoving then
					player.locktime = 30
					player.movereset = player.movereset - 1
					player.tspin = "no"
				end
			end
			player.leftdas = player.leftdas - 1
		end
		
		if (not player.rightinput) or (player.leftinput and player.rightinput) then
			player.rightdas = 10
		end
		
		if player.rightinput and (not(player.leftinput and player.rightinput)) then
			if player.rightdas == 10 or player.rightdas < 0 then
				ishemoving = true
				player.piecex = player.piecex + 1
				if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
					ishemoving = false
					player.piecex = player.piecex - 1
				end
				if ishemoving then
				player.playsound.moveright = true
				end
				if player.locktime < 30 and ishemoving then
					player.locktime = 30
					player.movereset = player.movereset - 1
					player.tspin = "no"
				end
			end
			player.rightdas = player.rightdas - 1
		end
		
		if not player.ccwinput then
			player.ccwlock = false
		end
		
		if player.ccwinput and (not player.ccwlock) then
			player.ccwlock = true
			RotationSystem.CCW(player)
		end
		
		if not player.cwinput then
			player.cwlock = false
		end
		
		if player.cwinput and (not player.cwlock) then
			player.cwlock = true
			RotationSystem.CW(player)
		end
		
		if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey+1) then
			if player.locktime == 30 then
				player.playsound.land = true
			end
			player.downwardtime=0
			player.locktime=player.locktime-1
		else
			--player.locktime=30
		end
		
		if player.sdinput or player.downwardtime >= 1 then
			if player.sdinput and player.downwardtime < 1 then
				player.downwardtime = 1
			end
			while piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) == false and player.downwardtime >= 1 do
				player.piecey = player.piecey+1
				player.locktime=30
				player.downwardtime = player.downwardtime - 1
			end
			if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
				player.piecey = player.piecey-1
			end
		end
		
		if player.locktime <= 0 or player.movereset <= 0 or player.rotreset <= 0 and (not (player.hdinput or player.holdinput)) then
			while piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) == false do
				player.piecey = player.piecey+1
			end
			player.piecey = player.piecey-1
			player.pieceactive = false
			player.amisafe = false
			for pies2 = 1 ,4 do
				for pies1 = 1 ,4 do
					if (piecetype[player.piececurrent][player.piecerotation][pies2][pies1] == 1) and (player.piecey+pies2-1 >= 1) then
						player.board[player.piecey+pies2-1][player.piecex+pies1-1] = player.piececurrent
						if player.piecey+pies2 >= 22 then
							player.amisafe = true
						end
					end
				end
			end
				player.playsound.lock = true
		end
		
		if player.hdinput then
			while piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) == false do
				player.piecey = player.piecey+1
			end
			player.piecey = player.piecey-1
			player.pieceactive = false
			player.hdinput = false
			player.amisafe = false
			for pies2 = 1 ,4 do
				for pies1 = 1 ,4 do
					if (piecetype[player.piececurrent][player.piecerotation][pies2][pies1] == 1) and (player.piecey+pies2-1 >= 1) then
						player.board[player.piecey+pies2-1][player.piecex+pies1-1] = player.piececurrent
						if player.piecey+pies2 >= 22 then
							player.amisafe = true
						end
					end
				end
			end
				player.playsound.harddrop = true
		end
		
		if player.holdinput and (not (player.holdlock or player.hdinput)) then
			player.pieceactive = false
			player.donotnext = true
			player.stillholding = true
				player.playsound.hold = true
		end
	end
	if player.pieceactive == false and (not player.stillholding) and player.dead == false and player.are <= 0 then
		player.lastpieceplacedglow=20
		player.lastpieceplacedx=player.piecex
		player.lastpieceplacedy=player.piecey
		player.lastpieceplaced=player.piececurrent
		player.linecleartrigger = true
		player.are = entrydl
		player.lineclears = 0
		local pccheck = true
		for ita = 1,40 do
			if not tablltablltabllcontains(player.board[ita],"E") then
				table.remove(player.board,ita)
				table.insert(player.board,1,{"E","E","E","E","E","E","E","E","E","E",})
				player.lineclears = player.lineclears + 1
			end
			for ite = 1,10 do
				if player.board[ita][ite] ~= "E" then
					pccheck = false
				end
			end
		end
		player.perfectclear = pccheck
		if pccheck then
			player.perfectclearframes=120
		end
		if player.lineclears > 0 then
			player.amisafe=true
				player.playsound.lineclear = true
			if player.tspin == "full" then
			end
		end
		if not player.amisafe then
			player.dead = true
				player.playsound.topout = true
		end
	end
end
------------------------------------------------------------------------

------------------------------------------------------------------------
------------------------------------------------------------------------
--                            GAME  UPDATE                            --
------------------------------------------------------------------------
------------------------------------------------------------------------
------------------------------------------------------------------------
--                             MAIN  LOOP                             --
------------------------------------------------------------------------
------------------------------------------------------------------------
resettime = 300
winner = "none"
function onUpdate(dt)
frames = frames + (dt*60)
    if nextPresenceUpdate < love.timer.getTime() then
        discordRPC.updatePresence(presence)
        nextPresenceUpdate = love.timer.getTime() + 2.0
    end
    discordRPC.runCallbacks()
	while frames > 1 do
		frameticks = frameticks + 1
		blockframeticks1 = blockframeticks1 + 1
		blockframeticks2 = blockframeticks2 + 1
		frames = frames - 1
		if scene == "attract_main" then
			presence.details = "In Menu"
			presence.state = "Attract"
			if didnaplay then
				tetrisplusassets.attract.mainmusic:play()
				didnaplay = false
			end
			if blockframeticks1 >= 72*14 then
				tetrisplusassets.attract.mainmusic:stop()
				blockframeticks1 = 0
				didnaplay = true
				p1.gravity = 1/60
				scene = "attract_howto"
			end
		end
		if scene == "attract_howto" then
			presence.details = "In Menu"
			presence.state = "How To Play"
			if didnaplay then
				initplayer(p1)
				p1.piecequeue={"I","T","S","Z","L","J","O", "L","O","T","J","Z","S","I", "S","J","L","O","Z","T","I", "J","Z","I","L","T","O","S", "S","Z","I","L","J","T","O", }
				tetrisplusassets.attract.howtoplaymusic:play()
				didnaplay = false
			end
			p1.gravity = 1/60
			if howtoplay_normal_keyinput[blockframeticks1] then
				if howtoplay_normal_keyinput[blockframeticks1].right ~= nil then
					p1.rightinput = howtoplay_normal_keyinput[blockframeticks1].right
				end
				if howtoplay_normal_keyinput[blockframeticks1].left ~= nil then
					p1.leftinput = howtoplay_normal_keyinput[blockframeticks1].left
				end
				if howtoplay_normal_keyinput[blockframeticks1].soft ~= nil then
					p1.sdinput = howtoplay_normal_keyinput[blockframeticks1].soft
				end
				if howtoplay_normal_keyinput[blockframeticks1].hard ~= nil then
					p1.hdinput = howtoplay_normal_keyinput[blockframeticks1].hard
				end
				if howtoplay_normal_keyinput[blockframeticks1].cw ~= nil then
					p1.cwinput = howtoplay_normal_keyinput[blockframeticks1].cw
				end
				if howtoplay_normal_keyinput[blockframeticks1].ccw ~= nil then
					p1.ccwinput = howtoplay_normal_keyinput[blockframeticks1].ccw
				end
				if howtoplay_normal_keyinput[blockframeticks1].hold ~= nil then
					p1.holdinput = howtoplay_normal_keyinput[blockframeticks1].hold
				end
			end
			updateplayernormal(p1,RotationSys.SRS)
			--if blockframeticks1 >= 72*14 then
			--	tetrisplusassets.attract.howtoplaymusic:stop()
			--	blockframeticks1 = 0
			--	didnaplay = true
			--	scene = "attract_howto"
			--end
		end
		if scene == "battle_normal" then
			presence.details = "On Battle"
			presence.state = ""
			if didnaplay then
				initplayer(p1)
				initplayer(p2)
				tetrisplusassets.taisen.music:play()
				didnaplay = false
			end
			p1.gravity = (1/60)+math.max(((blockframeticks1-7200)/60)/300,0)
			p2.gravity = (1/60)+math.max(((blockframeticks1-7200)/60)/300,0)
			p1.cwinput=not p1.cwinput
			p2.cwinput=not p2.cwinput
			p1.leftinput=true
			p2.leftinput=true
			updateplayernormal(p1,RotationSys.ARS)
			updateplayernormal(p2,RotationSys.TP2ARS)
			--if p1.playsound.lock then
			--	error("lmao",0)
			--end
			--if blockframeticks1 >= 72*14 then
			--	tetrisplusassets.attract.howtoplaymusic:stop()
			--	blockframeticks1 = 0
			--	didnaplay = true
			--	scene = "attract_howto"
			--end
		end
		--updateplayer(p2)
	end
end
------------------------------------------------------------------------
------------------------------------------------------------------------
--                             MAIN  LOOP                             --
------------------------------------------------------------------------
------------------------------------------------------------------------
------------------------------------------------------------------------
--                               PAINT                                --
------------------------------------------------------------------------
------------------------------------------------------------------------
function love.quit()
    discordRPC.shutdown()
end
function drawsprite(image,x,y,cx,cy,sx,sy,rt)
	love.graphics.push()
	love.graphics.translate( x, y)
	love.graphics.rotate(rt or 0)
	love.graphics.scale(sx, sy)
	love.graphics.draw(image or pieceimagetype.G, -cx, -cy)
	love.graphics.pop()
end
function drawpiece_queue(sprite,piecetyperr,rotation,x,y,size,dimx,dimy,centx,centy)
	if not piecetyperr then return end
	if piecetyperr == "E" then return end
	dimx = dimx or 16
	dimy = dimy or 16
	centx = centx or 8
	centy = centy or 8
	if piecetyperr == "I" then
		drawsprite(sprite, x+((1-1)*dimx*size), y+((2.5-1)*dimy*size),centx,centy,size,size)
		drawsprite(sprite, x+((2-1)*dimx*size), y+((2.5-1)*dimy*size),centx,centy,size,size)
		drawsprite(sprite, x+((3-1)*dimx*size), y+((2.5-1)*dimy*size),centx,centy,size,size)
		drawsprite(sprite, x+((4-1)*dimx*size), y+((2.5-1)*dimy*size),centx,centy,size,size)
	elseif piecetyperr == "O" then
		drawsprite(sprite, x+((2-1)*dimx*size), y+((2-1)*dimy*size),centx,centy,size,size)
		drawsprite(sprite, x+((3-1)*dimx*size), y+((2-1)*dimy*size),centx,centy,size,size)
		drawsprite(sprite, x+((2-1)*dimx*size), y+((3-1)*dimy*size),centx,centy,size,size)
		drawsprite(sprite, x+((3-1)*dimx*size), y+((3-1)*dimy*size),centx,centy,size,size)
	else
	for pies2 = 1 ,3 do
		for pies1 = 1 ,3 do
			if piecetype[piecetyperr][rotation][pies2][pies1] == 1 then
				drawsprite(sprite, x+((pies1-.5)*dimx*size), y+((pies2)*dimy*size),centx,centy,size,size)
			end
		end
	end
	end
end
function drawpiece(sprite,piecetyperr,rotation,x,y,size,dimx,dimy,centx,centy)
	if not piecetyperr then return end
	if piecetyperr == "E" then return end
	dimx = dimx or 16
	dimy = dimy or 16
	centx = centx or 8
	centy = centy or 8
	for pies2 = 1 ,4 do
		for pies1 = 1 ,4 do
			if piecetype[piecetyperr][rotation][pies2][pies1] == 1 then
				drawsprite(sprite, x+((pies1-1)*dimx*size), y+((pies2-1)*dimy*size),centx,centy,size,size)
			end
		end
	end
end
boarddrawable = love.graphics.newCanvas(320,960)
pieceglow = love.graphics.newCanvas(64,64)
function drawplayer_normalleft(player,x,y,size)
	local lastcanvas = love.graphics.getCanvas()
    love.graphics.setCanvas(boarddrawable)
	love.graphics.clear(0, 0, 0, 0)
	love.graphics.setBlendMode("alpha")
	if player.perfectclearframes > 0 then
		local sizexsize = 1
		if player.perfectclearframes > 90 then
			sizexsize = (120-player.perfectclearframes)/30
		end
		if player.perfectclearframes <= 30 then
			sizexsize = (player.perfectclearframes)/30
		end
		--drawsprite(perfectclearboard,160,240,80,160,sizexsize,sizexsize)
	end
	for boardgridy = 20,40 do
		for boardgridx = 1,10 do
			if player.board[boardgridy][boardgridx] ~= "E" then
				drawsprite(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.board[boardgridy][boardgridx]]], 160+(boardgridx*16)-(88), 240+(boardgridy*16)-((88+320+80)),8,8,1,1)
			end
		end
	end
	drawsprite(tetrisplusassets.playfields.normal.borderleft, 160, 240,48,117,2,2)
	drawpiece_queue(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.piecequeue[1]]],player.piecequeue[1],0,160-(24),240-(216),1)
	drawpiece_queue(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.piecequeue[2]]],player.piecequeue[2],0,160-(60),240-(200),.5)
	drawpiece_queue(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.piecequeue[3]]],player.piecequeue[3],0,160-(78),240-(186),.25)
	if player.pieceactive then
		if math.fmod(frameticks,2) == 0 then
			local fafjaeuo = player.piecey
			while piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,fafjaeuo) == false do
				fafjaeuo = fafjaeuo+1
			end
			fafjaeuo = fafjaeuo-1
			drawpiece(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.piececurrent]],player.piececurrent,player.piecerotation,160-(88)+(player.piecex*16),240-((88+320+80))+(fafjaeuo*16),1)
		end
		--local swgjrbjdrgbreh = pieceimagetype.Active
		if player.holdlock then
			--swgjrbjdrgbreh = pieceimagetype.ActiveHold
		end
		if math.fmod(frameticks,2) == 0 then
			--swgjrbjdrgbreh = pieceimagetype.ActiveDark
		end
		--drawpiece(swgjrbjdrgbreh,player.piececurrent,player.piecerotation,160-(88)+(player.piecex*16),240-((88+320+80))+(player.piecey*16),1,16,16,10,10)
		drawpiece(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.piececurrent]],player.piececurrent,player.piecerotation,160-(88)+(player.piecex*16),240-((88+320+80))+(player.piecey*16),1)
	end
    love.graphics.setCanvas(lastcanvas)
	love.graphics.setBlendMode("alpha", "premultiplied")
	drawsprite(boarddrawable,x,y,160,240,size,size)
	love.graphics.setBlendMode("alpha")
end
function drawplayer_normalright(player,x,y,size)
	local lastcanvas = love.graphics.getCanvas()
    love.graphics.setCanvas(boarddrawable)
	love.graphics.clear(0, 0, 0, 0)
	love.graphics.setBlendMode("alpha")
	if player.perfectclearframes > 0 then
		local sizexsize = 1
		if player.perfectclearframes > 90 then
			sizexsize = (120-player.perfectclearframes)/30
		end
		if player.perfectclearframes <= 30 then
			sizexsize = (player.perfectclearframes)/30
		end
		--drawsprite(perfectclearboard,160,240,80,160,sizexsize,sizexsize)
	end
	for boardgridy = 20,40 do
		for boardgridx = 1,10 do
			if player.board[boardgridy][boardgridx] ~= "E" then
				drawsprite(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.board[boardgridy][boardgridx]]], 160+(boardgridx*16)-(88), 240+(boardgridy*16)-((88+320+80)),8,8,1,1)
			end
		end
	end
	drawsprite(tetrisplusassets.playfields.normal.borderright, 160, 240,48,117,2,2)
	drawpiece_queue(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.piecequeue[1]]],player.piecequeue[1],0,160-(24),240-(216),1)
	drawpiece_queue(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.piecequeue[2]]],player.piecequeue[2],0,160+(60-24),240-(200),.5)
	drawpiece_queue(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.piecequeue[3]]],player.piecequeue[3],0,160+(78-12),240-(186),.25)
	if player.pieceactive then
		if math.fmod(frameticks,2) == 0 then
			local fafjaeuo = player.piecey
			while piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,fafjaeuo) == false do
				fafjaeuo = fafjaeuo+1
			end
			fafjaeuo = fafjaeuo-1
			drawpiece(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.piececurrent]],player.piececurrent,player.piecerotation,160-(88)+(player.piecex*16),240-((88+320+80))+(fafjaeuo*16),1)
		end
		--local swgjrbjdrgbreh = pieceimagetype.Active
		if player.holdlock then
			--swgjrbjdrgbreh = pieceimagetype.ActiveHold
		end
		if math.fmod(frameticks,2) == 0 then
			--swgjrbjdrgbreh = pieceimagetype.ActiveDark
		end
		--drawpiece(swgjrbjdrgbreh,player.piececurrent,player.piecerotation,160-(88)+(player.piecex*16),240-((88+320+80))+(player.piecey*16),1,16,16,10,10)
		drawpiece(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.piececurrent]],player.piececurrent,player.piecerotation,160-(88)+(player.piecex*16),240-((88+320+80))+(player.piecey*16),1)
	end
    love.graphics.setCanvas(lastcanvas)
	love.graphics.setBlendMode("alpha", "premultiplied")
	drawsprite(boarddrawable,x,y,160,240,size,size)
	love.graphics.setBlendMode("alpha")
end


function drawplayer_battlenormalleft(player,x,y,size)
	local lastcanvas = love.graphics.getCanvas()
    love.graphics.setCanvas(boarddrawable)
	love.graphics.clear(0, 0, 0, 0)
	love.graphics.setBlendMode("alpha")
	if player.perfectclearframes > 0 then
		local sizexsize = 1
		if player.perfectclearframes > 90 then
			sizexsize = (120-player.perfectclearframes)/30
		end
		if player.perfectclearframes <= 30 then
			sizexsize = (player.perfectclearframes)/30
		end
		--drawsprite(perfectclearboard,160,240,80,160,sizexsize,sizexsize)
	end
	for boardgridy = 20,40 do
		for boardgridx = 1,10 do
			if player.board[boardgridy][boardgridx] ~= "E" then
				drawsprite(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.board[boardgridy][boardgridx]]], 160+(boardgridx*16)-(88), 240+(boardgridy*16)-((88+320+80)),8,8,1,1)
			end
		end
	end
	drawsprite(tetrisplusassets.playfields.taisen.normborderleft, 160, 240,88,240,1,1)
	drawpiece_queue(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.piecequeue[1]]],player.piecequeue[1],0,160-(24),240-(216),1)
	drawpiece_queue(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.piecequeue[2]]],player.piecequeue[2],0,160-(60),240-(200),.5)
	drawpiece_queue(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.piecequeue[3]]],player.piecequeue[3],0,160-(78),240-(186),.25)
	if player.pieceactive then
		if math.fmod(frameticks,2) == 0 then
			local fafjaeuo = player.piecey
			while piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,fafjaeuo) == false do
				fafjaeuo = fafjaeuo+1
			end
			fafjaeuo = fafjaeuo-1
			drawpiece(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.piececurrent]],player.piececurrent,player.piecerotation,160-(88)+(player.piecex*16),240-((88+320+80))+(fafjaeuo*16),1)
		end
		--local swgjrbjdrgbreh = pieceimagetype.Active
		if player.holdlock then
			--swgjrbjdrgbreh = pieceimagetype.ActiveHold
		end
		if math.fmod(frameticks,2) == 0 then
			--swgjrbjdrgbreh = pieceimagetype.ActiveDark
		end
		--drawpiece(swgjrbjdrgbreh,player.piececurrent,player.piecerotation,160-(88)+(player.piecex*16),240-((88+320+80))+(player.piecey*16),1,16,16,10,10)
		drawpiece(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.piececurrent]],player.piececurrent,player.piecerotation,160-(88)+(player.piecex*16),240-((88+320+80))+(player.piecey*16),1)
	end
    love.graphics.setCanvas(lastcanvas)
	love.graphics.setBlendMode("alpha", "premultiplied")
	drawsprite(boarddrawable,x,y,160,240,size,size)
	love.graphics.setBlendMode("alpha")
end
function drawplayer_battlenormalright(player,x,y,size)
	local lastcanvas = love.graphics.getCanvas()
    love.graphics.setCanvas(boarddrawable)
	love.graphics.clear(0, 0, 0, 0)
	love.graphics.setBlendMode("alpha")
	if player.perfectclearframes > 0 then
		local sizexsize = 1
		if player.perfectclearframes > 90 then
			sizexsize = (120-player.perfectclearframes)/30
		end
		if player.perfectclearframes <= 30 then
			sizexsize = (player.perfectclearframes)/30
		end
		--drawsprite(perfectclearboard,160,240,80,160,sizexsize,sizexsize)
	end
	for boardgridy = 20,40 do
		for boardgridx = 1,10 do
			if player.board[boardgridy][boardgridx] ~= "E" then
				drawsprite(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.board[boardgridy][boardgridx]]], 160+(boardgridx*16)-(88), 240+(boardgridy*16)-((88+320+80)),8,8,1,1)
			end
		end
	end
	drawsprite(tetrisplusassets.playfields.taisen.normborderright, 160, 240,88,240,1,1)
	drawpiece_queue(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.piecequeue[1]]],player.piecequeue[1],0,160-(24),240-(216),1)
	drawpiece_queue(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.piecequeue[2]]],player.piecequeue[2],0,160+(60-24),240-(200),.5)
	drawpiece_queue(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.piecequeue[3]]],player.piecequeue[3],0,160+(78-12),240-(186),.25)
	if player.pieceactive then
		if math.fmod(frameticks,2) == 0 then
			local fafjaeuo = player.piecey
			while piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,fafjaeuo) == false do
				fafjaeuo = fafjaeuo+1
			end
			fafjaeuo = fafjaeuo-1
			drawpiece(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.piececurrent]],player.piececurrent,player.piecerotation,160-(88)+(player.piecex*16),240-((88+320+80))+(fafjaeuo*16),1)
		end
		--local swgjrbjdrgbreh = pieceimagetype.Active
		if player.holdlock then
			--swgjrbjdrgbreh = pieceimagetype.ActiveHold
		end
		if math.fmod(frameticks,2) == 0 then
			--swgjrbjdrgbreh = pieceimagetype.ActiveDark
		end
		--drawpiece(swgjrbjdrgbreh,player.piececurrent,player.piecerotation,160-(88)+(player.piecex*16),240-((88+320+80))+(player.piecey*16),1,16,16,10,10)
		drawpiece(tetrisplusassets.blocks.tgm[tetrisplusassets.blocks.tgm.refassets[player.piececurrent]],player.piececurrent,player.piecerotation,160-(88)+(player.piecex*16),240-((88+320+80))+(player.piecey*16),1)
	end
    love.graphics.setCanvas(lastcanvas)
	love.graphics.setBlendMode("alpha", "premultiplied")
	drawsprite(boarddrawable,x,y,160,240,size,size)
	love.graphics.setBlendMode("alpha")
end
tolecutscen = love.graphics.newCanvas(320,448)
widoecutscen = love.graphics.newCanvas(640,224)
torturex, torturey = 640,480
render_attract_main = function()
	love.graphics.setColor(1,1,1,1)
	if blockframeticks1 < 360 then
		drawsprite(tetrisplusassets.attract.normalmodetext, 160, 224+16,160,224,1,1)
		drawsprite(tetrisplusassets.attract.normalmoderight, 480, 224+16,80,112,2,2)
		if blockframeticks1 >= 72 then
			local tempa = math.min((blockframeticks1-72)/12,1)
			local tempb = math.max(lerp(640+256,288,((blockframeticks1-72)/42)^2),288)
			local lastcanvas = love.graphics.getCanvas()
			love.graphics.setCanvas(widoecutscen)
			drawsprite(tetrisplusassets.attract.profglow, 0+(math.fmod(frameticks*43,1280)), 112,0,56,2,2)
			drawsprite(tetrisplusassets.attract.profglow, -1280+(math.fmod(frameticks*43,1280)), 112,0,56,2,2)
			drawsprite(tetrisplusassets.attract.proftop, tempb, 112,128,56,2,2)
			love.graphics.setCanvas(lastcanvas)
			love.graphics.setBlendMode("alpha", "premultiplied")
			drawsprite(widoecutscen,320,128,320,112,tempa,1)
			love.graphics.setBlendMode("alpha")
		end
		if blockframeticks1 >= 84 then
			local tempa = math.min((blockframeticks1-84)/12,1)
			drawsprite(tetrisplusassets.attract.profbottom, 320, 336+16,160,56,tempa*2,2)
		end
		if blockframeticks1 >= 144 then
			local tempa = math.min((blockframeticks1-144)/12,1)
			drawsprite(tetrisplusassets.attract.puzzlemodetext, 480, 224+16,160,224,1,tempa)
		end
		if blockframeticks1 >= 156 then
			local tempa = math.min((blockframeticks1-156)/12,1)
			drawsprite(tetrisplusassets.attract.puzzlemodeleft, 160, 224+16,80,112,2,tempa*2)
		end
		if blockframeticks1 >= 216 then
			local tempa = math.min((blockframeticks1-216)/12,1)
			local tempb = math.min(lerp(0-352,352,((blockframeticks1-216)/42)^2),352)
			local lastcanvas = love.graphics.getCanvas()
			love.graphics.setCanvas(tolecutscen)
			drawsprite(tetrisplusassets.attract.assiglow, 160, -(math.fmod(frameticks*43,896)),80,0,2,2)
			drawsprite(tetrisplusassets.attract.assiglow, 160, 896-(math.fmod(frameticks*43,896)),80,0,2,2)
			drawsprite(tetrisplusassets.attract.assileft, 160, tempb,80,176,2,2)
			love.graphics.setCanvas(lastcanvas)
			love.graphics.setBlendMode("alpha", "premultiplied")
			drawsprite(tolecutscen,160,240,160,224,1,tempa)
			love.graphics.setBlendMode("alpha")
		end
		if blockframeticks1 >= 228 then
			local tempa = math.min((blockframeticks1-228)/12,1)
			drawsprite(tetrisplusassets.attract.assiright, 480, 224+16,80,112,2,tempa*2)
		end
		if blockframeticks1 >= 288 then
			local tempa = math.min((blockframeticks1-288)/12,1)
			drawsprite(tetrisplusassets.attract.vsmodetext, 320, 64+16,320,64,tempa,1)
		end
		if blockframeticks1 >= 300 then
			local tempa = math.min((blockframeticks1-300)/12,1)
			drawsprite(tetrisplusassets.attract.vsmode, 320, 288+16,160,80,tempa*2,2)
		end
	end
	if blockframeticks1 >= 360 then
		local tempa = ((blockframeticks1-360)/72)
		if blockframeticks1 < 432 then
		local tempc = 1/(4-(tempa*3))
		local tempb = lerp(336,112,((tempa*3)-2)^2)*tempc
		drawsprite(tetrisplusassets.attract.logo, 320, tempb+16,320,112,tempc,tempc)
		elseif blockframeticks1 < 452 then
		local tempa = ((blockframeticks1-432)/20)
		local tempb = 1.2-((((tempa*2)-1)^2)*.2)
		drawsprite(tetrisplusassets.attract.logo, 320, 112+16,320,112,tempb,tempb)
		else
		drawsprite(tetrisplusassets.attract.logo, 320, 112+16,320,112,1,1)
		end
		if blockframeticks1 < 384 then
			local tempa = math.max(-((blockframeticks1-384)/24),0)
			drawsprite(tetrisplusassets.attract.vsmodetext, 320, 64+16,320,64,1,tempa)
			drawsprite(tetrisplusassets.attract.vsmode, 320, 288+16,160,80,2,tempa*2)
		end
	end
	if blockframeticks1 < 12 then
		local tempa = 1-((blockframeticks1)/12)
		love.graphics.setColor(0,0,0,tempa)
		love.graphics.rectangle("fill", 0, 16, 640, 448)
		love.graphics.setColor(1,1,1,1)
	end
	if blockframeticks1 >= 996 then
		local tempa = ((blockframeticks1-996)/12)
		love.graphics.setColor(0,0,0,tempa)
		love.graphics.rectangle("fill", 0, 16, 640, 448)
		love.graphics.setColor(1,1,1,1)
	end
end
render_attract_howto = function()
	love.graphics.setColor(1,1,1,1)
	drawplayer_normalleft(p1,160,240+32,1)
	if blockframeticks1 < 12 then
		local tempa = 1-((blockframeticks1)/12)
		love.graphics.setColor(0,0,0,tempa)
		love.graphics.rectangle("fill", 0, 16, 640, 448)
		love.graphics.setColor(1,1,1,1)
	end
end
render_battle_normal = function()
	love.graphics.setColor(1,1,1,1)
	love.graphics.draw(tetrisplusassets.taisen.bg, -640, 0)
	drawplayer_battlenormalleft(p1,160,240+32,1)
	drawplayer_battlenormalright(p2,480,240+32,1)
	if blockframeticks1 < 12 then
		local tempa = 1-((blockframeticks1)/12)
		love.graphics.setColor(0,0,0,tempa)
		love.graphics.rectangle("fill", 0, 16, 640, 448)
		love.graphics.setColor(1,1,1,1)
	end
end
------------------------------------------------------------------------
------------------------------------------------------------------------
--                               PAINT                                --
------------------------------------------------------------------------
------------------------------------------------------------------------
------------------------------------------------------------------------
--                           GRAPHIC LOOP                             --
------------------------------------------------------------------------
------------------------------------------------------------------------
function onDraw()
	if scene == "attract_main" then
	render_attract_main()
	elseif scene == "attract_howto" then
	render_attract_howto()
	elseif scene == "battle_normal" then
	render_battle_normal()
	end
	love.graphics.setColor(0,0,0,1)
	love.graphics.rectangle("fill", 0, 0, 640, 16)
	love.graphics.rectangle("fill", 0, 464, 640, 16)
	love.graphics.setColor(1,1,1,1)
--[[	love.graphics.draw(bg, 0, 0)
	drawplayer(p1,160,240,1)
	drawplayer(p2,480,240,1)--]]
end
------------------------------------------------------------------------
------------------------------------------------------------------------
--                           GRAPHIC LOOP                             --
------------------------------------------------------------------------
------------------------------------------------------------------------
------------------------------------------------------------------------
--                       HANDLE SHITTY ERRORS                         --
------------------------------------------------------------------------
------------------------------------------------------------------------
function love.keypressed(...)  xpcall(onKeypressed, reportErrorAndRestart, ...)  end
function love.update    (...)  xpcall(onUpdate    , reportErrorAndRestart, ...)  end
function love.draw      (...)  xpcall(onDraw      , reportErrorAndRestart, ...)  end
------------------------------------------------------------------------
------------------------------------------------------------------------
--                       HANDLE SHITTY ERRORS                         --
------------------------------------------------------------------------
------------------------------------------------------------------------