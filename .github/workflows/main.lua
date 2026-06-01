-- Charge ta configuration au lancement
require("config")

function love.load()
    -- Position de départ du joueur
    playerX = 50
    playerY = 50
end

function love.update(dt)
    -- Applique la gravité depuis la config
    if playerY < 240 - Config.player.size then
        playerY = playerY + (Config.game.gravity * dt)
    else
        playerY = 240 - Config.player.size -- Reste au sol (écran du haut = 240px de haut)
    end

    -- Déplacement avec le Pad Circulaire ou la Croix de la 3DS
    if love.joystick.getJoystickCount() > 0 then
        local joystick = love.joystick.getJoysticks()[1]
        local x = joystick:getAxis(1)
        
        if x > 0.5 then 
            playerX = playerX + (Config.player.speed * dt) 
        elseif x < -0.5 then 
            playerX = playerX - (Config.player.speed * dt) 
        end
    end

    -- Limites de l'écran (400px de large)
    if playerX < 0 then playerX = 0 end
    if playerX > 400 - Config.player.size then playerX = 400 - Config.player.size end
end

function love.draw()
    -- Dessine le joueur avec tes paramètres
    love.graphics.setColor(Config.player.color)
    love.graphics.rectangle("fill", playerX, playerY, Config.player.size, Config.player.size)
    
    -- Affiche le titre choisi
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(Config.game.title, 10, 10)
end
