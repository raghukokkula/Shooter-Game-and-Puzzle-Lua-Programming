local composer = require( "composer" )
 
local scene = composer.newScene()
 

local physics = require("physics");
display.setStatusBar( display.HiddenStatusBar )
physics.start();

physics.setGravity(0,0);

local clickSound  =  audio.loadSound( "sounds/chipslide.wav" )

local Enemy = require ("Enemy");
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    total_lives = 5;
    isSquareTouch = 0;

    display.remove(lifeText)
    lifeText = display.newText("Life Count : "..total_lives,240,300,native.systemFont,30)
    sceneGroup:insert(lifeText)


    local options =   --this is to set the frames for the timebar
               {
                  frames = {
                     { x = 3, y = 400, width = 397, height = 39},--100%
                     { x = 3, y = 400, width = 380, height = 39}, 
                     { x = 3, y = 400, width = 370, height = 39},
                     { x = 3, y = 400, width = 363, height = 39}, 
                     { x = 5, y = 361, width = 356, height = 38},
                     { x = 5, y = 361, width = 346, height = 38},
                     { x = 5, y = 361, width = 332, height = 38},
                     { x = 5, y = 361, width = 325, height = 38},
                     { x = 3, y = 319, width = 318, height = 39},
                     { x = 3, y = 319, width = 310, height = 39},
                     { x = 3, y = 319, width = 300, height = 39},
                     { x = 3, y = 319, width = 290, height = 39},
                     { x = 3, y = 279, width = 278, height = 39},
                     { x = 3, y = 279, width = 268, height = 39},
                     { x = 3, y = 279, width = 255, height = 39},
                     { x = 3, y = 279, width = 245, height = 39},
                     { x = 3, y = 239, width = 236, height = 39},
                     { x = 3, y = 239, width = 226, height = 39},
                     { x = 3, y = 239, width = 210, height = 39},
                     { x = 3, y = 199, width = 197, height = 39},
                     { x = 3, y = 199, width = 187, height = 39},
                     { x = 3, y = 199, width = 177, height = 39},
                     { x = 3, y = 199, width = 170, height = 39},
                     { x = 3, y = 161, width = 160, height = 39},
                     { x = 3, y = 161, width = 150, height = 39},
                     { x = 3, y = 161, width = 140, height = 39},
                     { x = 3, y = 161, width = 130, height = 39},
                     { x = 3, y = 121, width = 119, height = 39},
                     { x = 3, y = 82, width = 80, height = 39},
                     { x = 3, y = 82, width = 70, height = 39},
                     { x = 3, y = 82, width = 60, height = 39},
                     { x = 3, y = 82, width = 50, height = 39},
                     { x = 3, y = 39, width = 40, height = 39},
                     { x = 3, y = 39, width = 30, height = 39},
                     { x = 3, y = 39, width = 20, height = 39},
                     { x = 3, y = 7, width = 6, height = 31},  --0%
                  }
               };
               local timeBarSheet = graphics.newImageSheet( "images/timebar.png", options );

               local timeBarSeqData = { 
               {name = "timebar_normal", start=1 , count = 36, time = 180000,loopCount=1}, 
                } 
    timebar = display.newSprite (timeBarSheet, timeBarSeqData); 
    timebar.x = display.contentCenterX-165; 
    timebar.y = display.contentCenterY-150; 
    timebar.xScale=0.8
    timebar.yScale=0.2
    timebar.anchorX = 0; 
    timebar.anchorY = 1; 
    
    sceneGroup:insert(timebar) --inserting the timebar into the scene group

    timebar:setSequence("timebar_normal")  --setting the sequence of the timebar
    timebar:play()

    local Square = Enemy:new( {HP=3, fR=720, fT=2000, --properties of the square object
                          bT=2700} );
local enemysound = audio.loadSound("shoot.wav");


    function squareTouch(event,self)
        if event.phase == "began" then
          audio.play(clickSound)
            print ("square touched")
            isSquareTouch = 1;
            print (isSquareTouch)
            
                      
        end
    end

    function Square:spawn() --to spawn a new pentagon
     --vertices = { 95,90,83,68,102.5,50,122,68,112,90}
      --self.shape = display.newPolygon (self.xPos, 
        --                      self.yPos, vertices); 
      self.shape = display.newImage("images/hero.png",self.xPos,self.yPos)
      self.shape.xScale = 0.4
      self.shape.yScale = 0.4
      self.shape.pp = self;
      self.shape.tag = "enemy";
      self.shape:setFillColor ( 1, 1, 0);
      physics.addBody(self.shape, "dynamic"); 
      sceneGroup:insert(self.shape)

      self.shape:addEventListener("touch", squareTouch)
    end

    function Square:forward ()  --square object to move forward
        transition.to(self.shape, {x=self.shape.x, y=450, 
                  time=self.fT,
        onComplete= function (obj) 
        print ("square completed")
        if isSquareTouch == 0 then 
            total_lives = total_lives - 1; 
            display.remove(lifeText); 
            if total_lives >= 0 then
                lifeText = display.newText("Life Count : "..total_lives,240,300,native.systemFont,30);  
            end
            if total_lives == 0 then
                timer.cancel(spawnTimer)
                display.remove(lifeText)
                composer.removeScene("roughWorkMain")
                composer.gotoScene("lose")
            end
        end
        isSquareTouch = 0;
            return; 
             end });
        
    end

    


    local Triangle = Enemy:new( {HP=1, bR=360, fT=4000, 
                             bT=300});

    function triangleTouch(event,self)
        if event.phase == "began" then
          audio.play(clickSound)
            print ("triangle touched")
            total_lives = total_lives - 1;
            display.remove(lifeText)
            lifeText = display.newText("Life Count : "..total_lives,240,300,native.systemFont,30)
            if total_lives == 0 then
                display.remove(lifeText)
                timer.cancel(spawnTimer)
                composer.removeScene("roughWorkMain")
                composer.gotoScene("lose")
            end
            
        end
    end

    function Triangle:spawn() --to spawn a new triangle object
         self.shape = display.newImage("images/pirate.png",self.xPos, self.yPos);
          self.shape.xScale = 0.02
        self.shape.yScale = 0.02
         self.shape.pp = self;
         self.shape.tag = "enemy";
         self.shape:setFillColor ( 0, 0.5, 1);
         physics.addBody(self.shape, "dynamic", 
                     {shape={-15,-15,15,-15,0,15}}); 
         sceneGroup:insert(self.shape)
         self.shape:addEventListener("touch", triangleTouch)
    end

    function Triangle:forward ()    --triangle object to move forward
      self.dist = math.random (40,70) * 10;
        transition.to(self.shape, {x=self.shape.x,
        y=450, time=self.fT, rotation=self.fR, 
        --onComplete=function(obj) obj:removeSelf(); obj=nil; end } );
        onComplete=function(obj) return; end } );
    end


    function spawning(event) --to spawn an enemy object randomly
        -- body
        firstRandNum = math.random(1,2)
        --print (firstRandNum)
        if firstRandNum == 1 then
            randNum1=math.random()
            if randNum1 <=0.5 then
                sq = Square:new({xPos=math.random(-50,85), yPos=-5});
                sq:spawn();
                sq:forward();
                --sq:addEventListener("touch",sq)
            else
                tr = Triangle:new({xPos=math.random(-50,85), yPos=-5});
                tr:spawn();
                tr:forward();
            end
        else
            randNum2=math.random()
            if randNum2 <=0.5 then
                sq = Square:new({xPos=math.random(400,570), yPos=-5});
                sq:spawn();
                sq:forward();
                --sq:addEventListener("touch",sq)
            else
                tr = Triangle:new({xPos=math.random(400,570), yPos=-5});
                tr:spawn();
                tr:forward();
            end
        end
    end
    function gotoevent(event)
        if (event.phase =="began") then 
            print (event.x.." "..event.y)
        end
    end
    Runtime:addEventListener("touch",gotoevent)



    ----------------------------------------------------------------------------

    io.output():setvbuf("no") 
    display.setStatusBar(display.HiddenStatusBar)  
        -- Locals
                                                          
    local w       = display.contentWidth        
    local h       = display.contentHeight 
    local centerX = display.contentWidth/2 
    local centerY = display.contentHeight/2

                                                
                                                    --
    local pieceSize = 80                
    local maxRows = 3                           
    local maxCols = 3                           

    local minX  = centerX - (maxCols * pieceSize)/2 + pieceSize/2   
    local minY  = centerY - (maxRows * pieceSize)/2 + pieceSize/2 - 15

    local theBoardPieces = {}                  
    local gameIsRunning  = true             

   local solutionString1 = ""  
    local solutionString2 = "" 

    local pieceNumbers = {}    
                               
                               

                                                        -- Load two audio files, one for clicks and one for puzzle solved
    local clickSound  =  audio.loadSound( "sounds/chipslide.wav" )
    local solvedSound =  audio.loadStream( "sounds/puzzlesolved.mp3" )

                                                        
    local freeChannel   = audio.findFreeChannel() 

                                                        
    audio.setVolume( 1.0 , {channel = freeChannel} )

    
    local gameStatusMsg                        
    -- Function Declarations
    --local prepData                               

    --local drawBoard                            

    local checkIfSolved                         

    local shuffle                               

    
    local onTouchPiece

    ----------------------------------------------------------------------
    ----------------------------------------------------------------------

   

    function prepData()

       
        --      
        solutionString1 = ""
        solutionString2 = ""
        pieceNumbers = {}

      
        local count = 1  -- A local for counting the current piece number.
        for row = 1, maxRows do
            for col = 1, maxCols do
                if not (row == 1 and col == 1) then
                    solutionString1 = solutionString1 .. count
                    pieceNumbers[count] = count
                    count = count + 1
                end
            end
        end

      
      
        solutionString2 = solutionString1 .. " "
        solutionString1 = " " .. solutionString1

      
        shuffle( pieceNumbers , 10 )
    end


    local backImage = display.newImageRect( "dif.jpg", 1140, 760) 
    backImage.x = centerX
    backImage.y = centerY
    backImage:toBack() 
    backImage.alpha = 0.5
    sceneGroup:insert(backImage)

  
    function drawBoard()

        local imagePaths = {}                  
        imagePaths[1] = "images/a.png"       
        --sceneGroup:insert(imagePaths[1])
        imagePaths[2] = "images/b.png"       
        --sceneGroup:insert(imagePaths[2])
        imagePaths[3] = "images/c.png"       
        --sceneGroup:insert(imagePaths[3])
        imagePaths[4] = "images/d.png"       
        --sceneGroup:insert(imagePaths[4])
        imagePaths[5] = "images/e.png"    
        --sceneGroup:insert(imagePaths[5])
        imagePaths[6] = "images/f.png"          
        --sceneGroup:insert(imagePaths[6])
        imagePaths[7] = "images/g.png"
        --sceneGroup:insert(imagePaths[7])
        imagePaths[8] = "images/h.png"
     
        local count = 1 
        for row = 1, maxRows do
            local y = minY + (row - 1) * pieceSize

            for col = 1, maxCols do
                local x = minX + (col - 1) * pieceSize

                if not (row == 1 and col == 1) then

                    local curPieceNum = pieceNumbers[count]
                    local boardPiece = display.newImageRect( imagePaths[curPieceNum], pieceSize, pieceSize) 
                    sceneGroup:insert(boardPiece)
                    boardPiece.count = curPieceNum

                    print(curPieceNum)
        
                    boardPiece.x = x
                    boardPiece.y = y

                        boardPiece.row = row
                    boardPiece.col = col

                
                    boardPiece:addEventListener( "touch", onTouchPiece )


  
                    if(not theBoardPieces[col]) then
                 theBoardPieces[col] = {}
                    end

                    theBoardPieces[col][row] = boardPiece

                    count = count + 1  

                end

            end
        end     
        
 
    end

 
    checkIfSolved = function()

        local puzzleString = ""
        for row = 1, maxRows do
            for col = 1, maxCols do
                if( theBoardPieces[col][row] == nil ) then
                    puzzleString = puzzleString .. " "
                else
                   
                    puzzleString = puzzleString .. theBoardPieces[col][row].count
                end
            end
        end

        print( "|" .. puzzleString .. "|" )
        print( "|" .. solutionString1 .. "|" )
        print( "|" .. solutionString2 .. "|" )

   
        if( puzzleString == solutionString1 ) then
            return true
        end
        if( puzzleString == solutionString2 ) then
            return true
        end

        return false
    end

  
    shuffle = function( t, passes )
        local passes = passes or 1
        for i = 1, passes do
            local n = #t 
            while n >= 2 do
            
                local k = math.random(n) -- 1 <= k <= n
                
                t[n], t[k] = t[k], t[n]
                n = n - 1
            end
        end 
        return t
    end

    function isEmpty(row,col)
        return theBoardPieces[col][row] == nil
    end

    onTouchPiece = function( event )
        
        
        local phase  = event.phase  
        local target = event.target

        local row    = target.row
        local col    = target.col


        if( not gameIsRunning ) then
            return true
        end

  
        if( phase == "ended" ) then
        
            local movedPieces = false

            for i = col, 1, -1 do
                --print(i)
                if( (i-1) > 0 and isEmpty( row, i-1 ) ) then  -- TO THE LEFT
                    print("Is empty to the left")
                    for j = i, col do                   
                        local curPiece = theBoardPieces[j][row]
                        curPiece.x = curPiece.x - pieceSize

                        theBoardPieces[j][target.row] = nil
                        curPiece.col = j - 1
                        theBoardPieces[curPiece.col][target.row] = curPiece
                    end
                    movedPieces = true
                    break
                end
            end

            if( not movedPieces ) then
                for i = col, maxCols do
                    --print(i)
                    if( (i+1) <= maxCols and isEmpty( row, i+1 ) ) then  
                        print("Is empty to the right")
                        for j = i, col, -1 do                       
                            local curPiece = theBoardPieces[j][row]
                            curPiece.x = curPiece.x + pieceSize

                            theBoardPieces[j][target.row] = nil
                            curPiece.col = j + 1
                            theBoardPieces[curPiece.col][target.row] = curPiece
                        end
                        movedPieces = true
                        break
                    end
                end
            end

            if( not movedPieces ) then
                for i = row, 1, -1 do
                    --print(i)
                    if( (i-1) > 0 and isEmpty( i-1, col ) ) then  -- UP
                        print("Is empty above")
                        for j = i, row do                       
                            local curPiece = theBoardPieces[col][j]
                            curPiece.y = curPiece.y - pieceSize

                            theBoardPieces[target.col][j] = nil
                            curPiece.row = j - 1
                            theBoardPieces[target.col][curPiece.row] = curPiece
                        end
                        movedPieces = true
                        break
                    end
                end
            end     

            if( not movedPieces ) then
                for i = row, maxRows do
                    print(i)
                    if( (i+1) <= maxRows and isEmpty( i+1, col ) ) then  -- DOWN
                        print("Is empty below")
                        for j = i, row, -1 do 
                            local curPiece = theBoardPieces[col][j]
                            curPiece.y = curPiece.y + pieceSize

                            theBoardPieces[target.col][j] = nil
                            curPiece.row = j + 1
                            theBoardPieces[target.col][curPiece.row] = curPiece
                        end
                        movedPieces = true
                        break
                    end
                end
            end     

            if( movedPieces ) then
             
                if( checkIfSolved( ) ) then
                  
                    print ("You solved it !!!")

                    gameIsRunning = false
                    composer.removeScene("main_scene")
                    composer.gotoScene("success")

                    audio.play( solvedSound, {channel = freeChannel} )
                else
                    audio.play( clickSound, {channel = freeChannel} )
                end
            end     
        end

        return true
    end

    function stopGame( )
        composer.removeScene("main_scene")
        composer.gotoScene("lose")
    end
 
end
 
 

function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

        prepData()
        drawBoard()

        --------------------------------------------------------

        function spawnTimerFunc () --function to call the spawning event
            print ("spawning called")
            spawnTimer=timer.performWithDelay(4000,spawning,36)
        end

        spawnTimerFunc()

        timebar:setSequence("timebar_normal")  --setting the sequence of the timebar
        timebar:play()

        function timedDelay()
                   -- body
           local t = timer.performWithDelay (180000, stopGame, 1);
        end

        timedDelay();
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
    display.remove(lifeText)
    total_lives = 5;
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene