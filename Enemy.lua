--local soundTable=require("soundTable");

local Enemy = {tag="enemy", HP=1, xPos=0, yPos=0, fR=6000, sR=0, bR=0, fT=10000, sT=500, bT	=500};

function Enemy:new (o)    --constructor
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function Enemy:spawn() -- function to spawn an enemy object
 self.shape=display.newCircle(self.xPos, self.yPos,15);
 self.shape.pp = self;  -- parent object
 self.shape.tag = self.tag; -- “enemy”
 self.shape:setFillColor (1,1,0);
 physics.addBody(self.shape, "kinematic"); --setting up the enemy bodies to be kinematic
end


function Enemy:forward ()   --function to move the enemy objects forward towards the player
   transition.to(self.shape, {x=self.shape.x, y=800, 
   time=self.fT, --rotation=self.fR, 
   --onComplete= function (obj) self:side() end } );
   onComplete= function(obj) obj:removeSelf(); obj=nil; end } );
end

function Enemy:move ()	
	self:forward();
end

function Enemy:hit () --this function is called when an enemy object is being hit by either the player or the player bullet
	self.HP = self.HP - 1;
	if (self.HP > 0) then 
		audio.play( soundTable["hitSound"] );
		self.shape:setFillColor(0.5,0.5,0.5);
	
	else 
		audio.play( soundTable["explodeSound"] );
		transition.cancel( self.shape );
		
		if (self.timerRef ~= nil) then
			timer.cancel ( self.timerRef );
		end

		-- die
		self.shape:removeSelf();
		self.shape=nil;	
		self = nil;  
	end		
end


function Enemy:shoot (interval) --this function is called when the enemy shoots bullets at the player
  interval = interval or 1500;
  local function createShot(obj)
    if obj.shape.y == nil then
      return
    else 
      local p = display.newRect (obj.shape.x, obj.shape.y+50, 
                                 10,10);
      p:setFillColor(0.5,0,0.5);
      p.anchorY=0;
      physics.addBody (p, "dynamic");
      p:applyForce(0, 0.2, p.x, p.y);
  		
      local function shotHandler (event)  --event handler to detect collision between enemy bullet and other bodies
        if (event.phase == "began") then
  	  event.target:removeSelf();
     	  event.target = nil;
        end
      end
      p:addEventListener("collision", shotHandler);
    end
  end
  self.timerRef = timer.performWithDelay(interval, 
	function (event) createShot(self) end, -1);  --adding a timer to shoot the bullet at the player object
end


return Enemy

