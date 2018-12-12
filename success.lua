local composer = require( "composer" )
 
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
    local background = display.newImage(sceneGroup, "dif.jpg", 150, 240,220,200)
    local text2=display.newText(sceneGroup, "You Win ", 250, 100,native.systemFont, 40 );
    text2:setFillColor(1,0,0);
    


end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

      menu_button = display.newRoundedRect(250,200,160,50,10)
      menu_button:setFillColor(1,0,0)
      menu_button_text = display.newText("Restart",250,200,native.systemFont,25)   --adding the go home button
      sceneGroup:insert(menu_button)
      sceneGroup:insert(menu_button_text)

      function return_menu( event ) --adding event listener for the go home button
          -- body
          if event.phase == "ended" then

          -- removes the displayed messages and sprites on the screen 
              display.remove(win_message)
              display.remove(janken)
              display.remove(bubble)
              display.remove(alex)
              display.remove( bg )
              display.remove(hand)
              composer.removeScene("success")
              composer.gotoScene("menu",{effect="fade",time=300})


          end
      end
      menu_button:addEventListener("touch",return_menu)
 
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