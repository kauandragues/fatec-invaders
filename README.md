# Fatec Invaders

Projeto de jogo retro 2D criado em Lua utilizando o framework LÖVE (Love2D). Este jogo foi desenvolvido e apresentado durante o evento "Fatec Portas Abertas", onde a comunidade externa visitou a faculdade — eu e meu colega Ezequiel exibimos o jogo e visitantes puderam jogá-lo.

**Status:** Projeto entregue e demonstrado no evento.

**Visão geral**

- **Gênero:** Shooter arcade 2D
- **Tecnologia:** Lua + LÖVE (Love2D)
- **Plataforma alvo:** Desktop (Windows, macOS, Linux)

**Destaques**

- Jogabilidade simples e acessível, inspirada em clássicos shoot 'em up.
- Inimigos variados, power-ups e múltiplas telas (início, missão, jogo).
- Arquivos organizados em `main.lua`, pasta `source/` e `assets/`.

Como jogar

- Movimente-se com as setas ou `A`/`D` (dependendo da configuração do teclado).
- Pressione `Espaço` para atirar.
- Objetivo: derrotar inimigos e acumular a maior pontuação possível.

Executando o jogo (desenvolvimento)

1. Instale o LÖVE (Love2D) — https://love2d.org/
2. Abra um terminal na raiz do projeto (pasta do repositório).
3. Execute:

```powershell
love .
```

No Windows você também pode arrastar a pasta para o executável `love.exe` ou usar o caminho completo: `C:\caminho\para\love.exe .`.

Estrutura do projeto

- `main.lua` — Ponto de entrada do jogo.
- `assets/` — Recursos (imagens, áudio, vídeo como `background.ogv`).
- `source/` — Código-fonte do jogo:
	- `game.lua` — Lógica principal de jogo e loop.
	- `player.lua` — Comportamento e estado do jogador.
	- `enemy.lua` — Lógica dos inimigos.
	- `bullet.lua` — Tiros/projéteis.
	- `powerUp.lua` — Power-ups e seus efeitos.
	- `start_screen.lua` — Tela inicial/menu.
	- `missionStart.lua` — Tela de início de missão.
	- `Button.lua` — Componente de botão usado nas telas.

Contribuidores

- Kauã — desenvolvimento e apresentação
- Ezequiel — desenvolvimento e apresentação

Evento

Este jogo foi criado especificamente para o evento **Fatec Portas Abertas**, um dia em que a comunidade externa visita a Fatec para conhecer os cursos e projetos. Eu e meu colega Ezequiel apresentamos o jogo durante o evento; diversos visitantes testaram e aproveitaram a experiência.
