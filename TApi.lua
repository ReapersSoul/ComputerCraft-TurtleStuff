local x,y,z,dir=0,0,0,0

local sx,sy,sz,sdir=0,0,0,0

StringToDir = {}

StringToDir["+y"] = 0
StringToDir["+x"] = 1
StringToDir["-y"] = 2
StringToDir["-x"] = 3

DirToString = {}

DirToString[0] = "+y"
DirToString[1] = "+x"
DirToString[2] = "-y"
DirToString[3] = "-x"

function GetX()
	print("Called: GetX")
	return x
end

function GetY()
	print("Called: GetY")
	return y
end

function GetZ()
	print("Called: GetZ")
	return z
end

function GetDir()
	print("Called: GetDir")
	return DirToString[dir]
end

function Forward()
	print("Called: Forward")
	if(dir==0)then
		y= y+1
	end
	if(dir==1)then
		x= x+1
	end
	if(dir==2)then
		y= y-1
	end
	if(dir==3)then
		x= x-1
	end
	print("Forward: ",turtle.forward())
end

function Back()
	print("Called: Back")
	if(dir==0)then
		y= y-1
	end
	if(dir==1)then
		x= x-1
	end
	if(dir==2)then
		y= y+1
	end
	if(dir==3)then
		x= x+1
	end
	turtle.back()
end

function Up()
	print("Called: Up")
	print(turtle.up())
	z=z+1
end

function Down()
	print("Called: Down")
	z=z-1
	turtle.down()
end

function TurnRight()
	print("Called: TurnRight")
	if(dir==3){
		dir=0
	else
		dir+1
	}
	turtle.turnRight()
end

function TurnLeft()
	print("Called: TurnLeft")
	if(dir==0){
		dir=3
	else
		dir-1
	}
	turtle.turnLeft()
end

function FaceDir(direction)
	print("Called: FaceDir")
	if(StringToDir[direction]==dir)then
		return
	end
	if(StringToDir[direction]==0) then
		
	end



end

function MoveDir(direction)
	print("Called: MoveDir")
	print("MoveDir: dir before:",dir)
	FaceDir(direction)
	print("MoveDir: dir after:",dir)
	Forward()
end

function DigDir(direction)
	print("Called: DigDir")
	FaceDir(direction)
	turtle.dig()
	return "tried to dig"
end

function SelectItem(item)
	print("Called: SelectItem")
    for s=1,16 do
        turtle.select(s)
        data =turtle.getItemDetail()
        if data~=nil then
        if data.name == item then
            print("found: ",item)
            return true
        end
        else
        print("no item in slot: ",s)
        end
    end
    print("could not find: ",item)
	return false
end

function InspectDown(item)
	print("Called: InspectDown")
     local suc, d = turtle.inspectDown()
     if suc then
         print(d.name)
         if d.name == item then return true end
     else
        print("failed inspect")
     end
     return false
end

function InspectUp(item)
	print("Called: InspectUp")
     local suc, d = turtle.inspectUp()
     if suc then
         print(d.name)
         if d.name == item then return true end
     else
        print("failed inspect")
     end
     return false
end

function InspectForward(item)
	print("Called: InspectForward")
     local suc, d = turtle.inspect()
     if suc then
         print(d.name)
         if d.name == item then return true end
     else
        print("failed inspect")
     end
     return false
end

function InspectBack(item)
	print("Called: InspectBack")
	turtle.turnRight()
	turtle.turnRight()
     local suc, d = turtle.inspect()
     if suc then
         print(d.name)
         if d.name == item then
			 turtle.turnLeft()
			 turtle.turnLeft()
		 return true
		 end
     else
        print("failed inspect")
     end
	 turtle.turnLeft()
	 turtle.turnLeft()
     return false
end

function InspectRight(item)
	print("Called: InspectRight")
	turtle.turnRight()
     local suc, d = turtle.inspect()
     if suc then
         print(d.name)
         if d.name == item then
			 turtle.turnLeft()
		 return true
		 end
     else
        print("failed inspect")
     end
	 turtle.turnLeft()
     return false
end

function InspectLeft(item)
	print("Called: InspectLeft")
	turtle.turnLeft()
     local suc, d = turtle.inspect()
     if suc then
         print(d.name)
         if d.name == item then
			 turtle.turnRight()
		 return true
		 end
     else
        print("failed inspect")
     end
	 turtle.turnRight()
     return false
end

function InspectDir(item,direction)
	print("Called: InspectDir")
	tmpdir=dir
	FaceDir(direction)
     local suc, d = turtle.inspect()
     if suc then
         print(d.name)
         if d.name == item then
		 FaceDir(tmpdir)
		 return true
		 end
     else
        print("failed inspect")
     end
	 FaceDir(tmpdir)
     return false
end

function DetectDown()
	print("Called: DetectDown")
	return turtle.detectDown()
end

function DetectUp()
	print("Called: DetectUp")
	return turtle.detectUp()
end

function DetectForward()
	print("Called: DetectForward")
	return turtle.detect()
end

function DetectBack()
	print("Called: DetectBack")
	turtle.turnRight()
	turtle.turnRight()
	ret = turtle.detect()
	turtle.turnLeft()
	turtle.turnLeft()
    return ret
end

function DetectRight()
	print("Called: DetectRight")
	turtle.turnRight()
	ret = turtle.detect()
	turtle.turnLeft()
    return ret
end

function DetectLeft()
	print("Called: DetectLeft")
	turtle.turnLeft()
	ret = turtle.detect()
	turtle.turnRight()
    return ret
end

function DetectDir(direction)
	print("Called: DetectDir")
	tmpdir =dir
	FaceDir(direction)
	tmpdet= turtle.detect()
	FaceDir(tmpdir)
	return tmpdet
end

function HomeX()
	print("Called: HomeX")
	if x>0 then
		if(not DetectDir("-x")) then
			while x ~= 0 do
				MoveDir("-x")
			end
		end
	else
		if(not DetectDir("+x")) then
			while x~=0 do
				MoveDir("+x")
			end
		end
	end
end
function HomeY()
	print("Called: HomeY")
	if y>0 then
		if(not DetectDir("-y")) then
			while y ~= 0 do
				MoveDir("-y")
			end
		end
	else
		if(not DetectDir("+y")) then
			while y~=0 do
				MoveDir("+y")
			end
		end
	end
end
function HomeZ()
	print("Called: HomeZ")
	if z>0 then
		if(not DetectDown()) then
			while z ~= 0 do
				Down()
			end
		end
	else
		if(not DetectUp()) then
			while z~=0 do
				Up()
			end
		end
	end
end

function HomeAll()
	print("Called: HomeAll")
	while x~=0 and y~=0 and z~=0 do
		HomeX()
		HomeY()
		HomeZ()
	end
	FaceDir("+y")
end

function GoX(dx)
	print("Called: GoX")
	if x>dx then
		if(not DetectDir("-x")) then
			while x ~= dx do
				MoveDir("-x")
			end
		end
	else
		if(not DetectDir("+x")) then
			while x~=dx do
				MoveDir("+x")
			end
		end
	end
end

function GoY(dy)
	print("Called: GoY")
	if y>dy then
		if(not DetectDir("-y")) then
			while y ~= dy do
				MoveDir("-y")
			end
		end
	else
		if(not DetectDir("+y")) then
			while y~=dy do
				MoveDir("+y")
			end
		end
	end
end

function GoZ(dz)
	print("Called: GoZ")
	if z>dz then
		if(not DetectDown()) then
			while z ~= dz do
				Down()
			end
		end
	else
		if(not DetectUp()) then
			while z~=dz do
				Up()
			end
		end
	end
end

function GoTo(dx,dy,dz)
	print("Called: GoTO")
		while x~=0 and y~=0 and z~=0 do
		GoX()
		GoY()
		GoZ()
	end
end

function SavePosRot()
	print("Called: SavePosRot")
	sx,sy,sz,sdir=x,y,z,dir
end

function RestorePosRot()
	print("Called: RestorePosRot")
	GoTo(sx,sy,sz)
	FaceDir(sdir)
end

function InventoryFull()
	print("Called: InventoryFull")
	local NES=0
	for s=1,16 do
		turtle.select(s)
		if turtle.getItemDetail()~= nil then
			NES = NES+1
		end
	end
	if NES==16 then
		return true
	else
		return false
	end
end
