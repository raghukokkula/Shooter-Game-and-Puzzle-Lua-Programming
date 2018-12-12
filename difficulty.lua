local composer = require( "composer" )
local widget = require("widget") -- inlcudes widgets used in the code

 
local scene = composer.newScene()
 
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

    local background = display.newImage(sceneGroup, "dif.jpg",display.contentCenterX, display.contentCenterY)
    local s = display.contentWidth / background.width
    background:scale(s+0.1,s+0.1)

 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
         -- start function to go to first scene and play the game 
            local function start( event )

              if ( "began" == event.phase ) then
                  print( "Button was pressed and released and start button" )
              end
              composer.removeScene("difficulty",true)   ---- removes the menu scence to avoid overlapping
              
              local options = {  --- options to move to other scence 
                  effect = "slideLeft",
                  time = 500,
                  
               }
               composer.gotoScene( "hard", options )  --used to composer to go to next scence "level"
            end

         
         ---  start button widget 
            local button1 = widget.newButton(
                {
                    label = "button",
                    onEvent = start,
                    emboss = false,
                    shape = "rectangle",
                    width = 200,
                    height = 40,
                    cornerRadius = 2,
                    fillColor = { default={1,1,1,1}, over={1,1,1,1} },
                    strokeColor = { default={0,0,0,1}, over={1,1,1,1} },
                    strokeWidth = 4
                }
            )

         --- position of the button 
            button1.x = display.contentCenterX 
            button1.y = display.contentCenterY -20
            button1:setLabel( "Easy" )
            sceneGroup:insert(button1)

            local function medium( event )

              if ( "began" == event.phase ) then
                  print( "Button was pressed and released and start button" )
              end
              composer.removeScene("difficulty",true)   ---- removes the menu scence to avoid overlapping
              
              local options = {  --- options to move to other scence 
                  effect = "slideLeft",
                  time = 500,
                  
               }
               composer.gotoScene( "medium", options )  --used to composer to go to next scence "level"
            end

            ---  start button widget 
            local button2 = widget.newButton(
                {
                    label = "button",
                    onEvent = medium,
                    emboss = false,
                    shape = "rectangle",
                    width = 200,
                    height = 40,
                    cornerRadius = 2,
                    fillColor = { default={1,1,1,1}, over={1,1,1,1} },
                    strokeColor = { default={0,0,0,1}, over={1,1,1,1} },
                    strokeWidth = 4
                }
            )

         --- position of the button 
            button2.x = display.contentCenterX 
            button2.y = display.contentCenterY +30
            button2:setLabel( "Medium" )
            sceneGroup:insert(button2)


            local function hard( event )

              if ( "began" == event.phase ) then
                  print( "Button was pressed and released and start button" )
              end
              composer.removeScene("difficulty",true)   ---- removes the menu scence to avoid overlapping
              
              local options = {  --- options to move to other scence 
                  effect = "slideLeft",
                  time = 500,
                  
               }
               composer.gotoScene( "main_scene", options )  --used to composer to go to next scence "level"
            end

            ---  start button widget 
            local button3 = widget.newButton(
                {
                    label = "button",
                    onEvent = hard,
                    emboss = false,
                    shape = "rectangle",
                    width = 200,
                    height = 40,
                    cornerRadius = 2,
                    fillColor = { default={1,1,1,1}, over={1,1,1,1} },
                    strokeColor = { default={0,0,0,1}, over={1,1,1,1} },
                    strokeWidth = 4
                }
            )

         --- position of the button 
            button3.x = display.contentCenterX 
            button3.y = display.contentCenterY +80
            button3:setLabel( "Hard" )
            sceneGroup:insert(button3)
 
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