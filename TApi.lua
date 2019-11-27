local x,y,z=0,0,0

local sx,sy,sz,sdir=0,0,0,"+y"

local dir ="+y"

function GetX()
	return x
end

function GetY()
	return y
end

function GetZ()
	return z
end

function GetDir()
	return Dir
end

function Forward()
	if(dir=="+y")then
		y= y+1
	end
	if(dir=="-y")then
		y= y-1
	end
	if(dir=="+x")then
		x= x+1
	end
	if(dir=="-x")then
		x= x-1
	end
	turtle.forward()
end

function Back()
	if(dir=="+y")then
		y= y-1
	end
	if(dir=="-y")then
		y= y+1
	end
	if(dir=="+x")then
		x= x-1
	end
	if(dir=="-x")then
		x= x+1
	end
	turtle.back()
end

function Up()
	print("before: ",z)
	print(turtle.up())
	z=z+1
	print("after: ",z)
end
function Down()
	z=z-1
	turtle.down()
end

function TurnRight()
	if(dir=="+y")then
		dir="+x"
	end
	if(dir=="-y")then
		dir="-x"
	end
	if(dir=="+x")then
		dir="-y"
	end
	if(dir=="-x")then
		dir="+y"
	end
	turtle.turnRight()
end

function TurnLeft()
	if(dir=="+y")then
		dir="-x"
	end
	if(dir=="-y")then
		dir="+x"
	end
	if(dir=="+x")then
		dir="+y"
	end
	if(dir=="-x")then
		dir="-y"
	end
	turtle.turnLeft()
end

function FaceDir(direction)
	if(direction==dir)then
		return
	end
	if(dir=="+y")then
		if(direction=="-y")then
			TurnRight()
			TurnRight()
			return
		end
		if(direction=="+x")then
			TurnRight()
			return
		end
		if(direction=="-x")then
			TurnLeft()
			return
		end
	end
	if(dir=="-y")then
		if(direction=="+y")then
			TurnRight()
			TurnRight()
			return
		end
		if(direction=="+x")then
			TurnLeft()
			return
		end
		if(direction=="-x")then
			TurnRight()
			return
		end
	end
	if(dir=="+x")then
		if(direction=="+y")then
			TurnRight()
			return
		end
		if(direction=="-y")then
			TurnRight()
			return
		end
		if(dir=="-x")then
			TurnRight()
			TurnRight()
			return
		end
	end
	if(dir=="-x")then
		if(dir=="+y")then
			TurnRight()
			return
		end
		if(dir=="-y")then
			TurnLeft()
			return
		end
		if(dir=="+x")then
			TurnRight()
			TurnRight()
			return
		end
	end
end

function MoveDir(direction)
	print("dir before:",dir)
	FaceDir(direction)
	print("dir after:",dir)
	Forward()
end

function DigDir(direction)
	FaceDir(direction)
	turtle.dig()
	return "tried to dig"
end

function SelectItem(item)
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
    print("called inspect")
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
    print("called inspect")
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
    print("called inspect")
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
    print("called inspect")
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
    print("called inspect")
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
    print("called inspect")
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

function InspectForward(item,direction)
    print("called inspect")
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
    print("called Detect")
	return turtle.detectDown()
end

function DetectUp()
    print("called Detect")
	return turtle.detectUp()
end

function DetectForward()
    print("called Detect")
	return turtle.detect()
end

function DetectBack()
    print("called Detect")
	turtle.turnRight()
	turtle.turnRight()
	ret = turtle.detect()
	turtle.turnLeft()
	turtle.turnLeft()
    return ret
end

function DetectRight()
    print("called Detect")
	turtle.turnRight()
	ret = turtle.detect()
	turtle.turnLeft()
    return ret
end

function DetectLeft()
    print("called Detect")
	turtle.turnLeft()
	ret = turtle.detect()
	turtle.turnRight()
    return ret
end

function DetectDir(direction)
    print("called Detect")
	tmpdir =dir
	FaceDir(direction)
	tmpdet= turtle.detect()
	FaceDir(tmpdir)
	return tmpdet
end

function HomeX()
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
	while x~=0 and y~=0 and z~=0 do
		HomeX()
		HomeY()
		HomeZ()
	end
	FaceDir("+y")
end

function GoX(dx)
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
		while x~=0 and y~=0 and z~=0 do
		GoX()
		GoY()
		GoZ()
	end
end

function SavePosRot()
	sx,sy,sz,sdir=x,y,z,dir
end

function RestorePosRot()
	GoTo(sx,sy,sz)
	FaceDir(sdir)
end

function InventoryFull()
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
