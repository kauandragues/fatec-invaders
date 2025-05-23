player = require("source.player")
enemy = require("source.enemy")
missionStart = require("source.missionStart")
powerUp = require("source.powerUp")

local utf8 = require("utf8")
local input_text = ""
local inicio_enemy = 2
local game = {}
local tempoSpawnPowerUp = 0
local intervaloSpawnPowerUp = 8
local time = 0
local estado = "jogando"
local screen_width, screen_height = 800, 600
local ranking = {}
local scroll = 0

function game.init(width, height)
    player.init(width, height)
    missionStart.init(width, height)
    screen_width = width
    screen_height = height
end

function game.load()
    enemy.load()
    player.load()
    missionStart.load()
    powerUp.load()
    math.randomseed(os.time() + os.clock() * 100000)
    love.window.setTitle("Quadrado Móvel")
end

local function carregarRanking()
    ranking = {}
    if love.filesystem.getInfo("ranking.txt") then
        local data = love.filesystem.read("ranking.txt")
        for line in data:gmatch("[^\r\n]+") do
            local nome, pontos = line:match("^(.-),(%d+)$")
            if nome and pontos then
                table.insert(ranking, {nome = nome, pontos = tonumber(pontos)})
            end
        end
        table.sort(ranking, function(a, b) return a.pontos > b.pontos end)
    end
end


function game.update(dt)
    if estado == "jogando" then
        tempoSpawnPowerUp = tempoSpawnPowerUp + dt
        if tempoSpawnPowerUp >= intervaloSpawnPowerUp then
            tempoSpawnPowerUp = 0
            powerUp.spawn()
        end
        powerUp.update(dt)
        player.update(dt)
        missionStart.update(dt)
        enemy.update(dt, player)
        if player.hp <= 0 then
            estado = "input_ranking"
        end
        time = time + dt
    end
end

function love.textinput(t)
    if estado == "input_ranking" then
        input_text = input_text .. t
    end
end

function love.keypressed(key)
    if estado == "input_ranking" then
        if key == "backspace" then
            input_text = input_text:sub(1, -2)
        elseif key == "return" or key == "kpenter" then
            local entry = input_text .. "," .. tostring(player.pontuacao_final) .. "\n"
            love.filesystem.append("ranking.txt", entry)
            estado = "gameover"
        end

    elseif estado == "gameover" then
        if key == "r" then
            reiniciarJogo()
        elseif key == "tab" then
            carregarRanking()
            estado = "ranking"
        end

    elseif estado == "ranking" then
        if key == "escape" then
            estado = "gameover"
        elseif key == "up" then
            scroll = math.max(scroll - 20, 0)
        elseif key == "down" then
            scroll = scroll + 20
        end
    end
end

function game.draw()
    if estado == "jogando" then
        love.graphics.setColor(1, 1, 1)
        player.draw()
        missionStart.draw()
        powerUp.draw()
        if time >= inicio_enemy then enemy.draw() end
        love.graphics.printf("Pontuação: " .. player.pontuacao_final, 0, 50, 200, "center")

    elseif estado == "input_ranking" then
        love.graphics.setColor(0.1, 0.1, 0.1, 0.8)
        love.graphics.rectangle("fill", screen_width / 2 - 200, screen_height / 2 - 80, 400, 160, 10)
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("PONTUAÇÃO FINAL: " .. player.pontuacao_final, screen_width / 2 - 180, screen_height / 2 - 70, 360, "center")
        love.graphics.printf("Digite seu nome:", screen_width / 2 - 180, screen_height / 2 - 20, 360, "center")
        love.graphics.setColor(1, 1, 0)
        love.graphics.printf(input_text, screen_width / 2 - 180, screen_height / 2 + 10, 360, "center")

    elseif estado == "gameover" then
        love.graphics.setColor(1, 0, 0)
        love.graphics.printf("GAME OVER", 0, screen_height / 2 - 60, screen_width, "center")
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("Pressione [R] para Reiniciar", 0, screen_height / 2, screen_width, "center")
        love.graphics.printf("Pressione [TAB] para ver o Ranking", 0, screen_height / 2 + 30, screen_width, "center")

    elseif estado == "ranking" then
        love.graphics.setColor(0.1, 0.1, 0.1, 0.9)
        love.graphics.rectangle("fill", screen_width / 2 - 300, 50, 600, 500, 10)
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("RANKING", 0, 60, screen_width, "center")

        local y = 100 - scroll
        for i, entry in ipairs(ranking) do
            local texto = string.format("%d. %s - %d", i, entry.nome, entry.pontos)
            if y > 50 then
                love.graphics.printf(texto, screen_width / 2 - 280, y, 560, "left")
            end

            
            y = y + 30
        end

        love.graphics.printf("Use ↑ ↓ para rolar, ESC para voltar", 0, 570, screen_width, "center")
    end
end

function reiniciarJogo()
    time = 0
    estado = "jogando"
    player.hp = 3
    player.x = 300
    player.y = 300
    enemy.list = {}
    enemy.time_nascimento = 0
    enemy.espera = 2
    enemy.dy = 1
    player.pontuacao = 0
    missionStart.load()
    input_text = ""
    scroll = 0
end

return game
