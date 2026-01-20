# Windy Seas

> [!NOTE]
> Legenda
>
> - Código: _<span style="color:#56949f;font-style:italic;">Itálico</span>_
> - Arte: **<span style="color:#b4637a;font-weight:bold;">Negrito</span>**
> - Som: **_<span style="color:#ea9d34;font-weight:bold;font-style:italic;">Negrito Itálico</span>_**

## Narrativa

O jogador aceita um trabalho como cargueiro para quitar dívidas de jogo. Agora deve desbravar os perigosos 7 mares fazendo entregas de pacotes clandestinos, para pagar a dívida... ou morrer tentando!

## Jogo

Começa o jogo com uma **<span style="color:#b4637a;font-weight:bold;">tela</span>** de _<span style="color:#56949f;font-style:italic;">Loading</span>_ para o **<span style="color:#b4637a;font-weight:bold;">menu inicial</span>**, sendo esse composto pelos **<span style="color:#b4637a;font-weight:bold;">botões jogar e sair do jogo</span>** possuindo **_<span style="color:#ea9d34;font-weight:bold;font-style:italic;">música de fundo</span>_**. Ao clicar em jogar, **<span style="color:#b4637a;font-weight:bold;">uma tela de Loading</span>** levará o jogador para a próxima cena, que consiste do primeiro nível do jogo: Um **<span style="color:#b4637a;font-weight:bold;">cais</span>** atrás do jogador e um percurso logo a frente, onde o jogador (representado pelo **<span style="color:#b4637a;font-weight:bold;">modelo do barco</span>**) receberá instruções por meio de **<span style="color:#b4637a;font-weight:bold;">diálogos</span>** em _<span style="color:#56949f;font-style:italic;">balões de fala</span>_ sobre como _<span style="color:#56949f;font-style:italic;">controlar o barco</span>_, sendo necessário _<span style="color:#56949f; font-style:italic;">coletar</span>_ ao menos uma das **<span style="color:#b4637a;">caixas</span>** dispostas no percurso até chegar no **<span style="color:#b4637a;">cais de destino</span>**. Ao chegar no cais de destino uma **<span style="color:#b4637a;">tela de resultados</span>** vai aparecer em conjunto com a **_<span style="color:#ea9d34;font-weight:bold;font-style:italic;">música da tela de resultados</span>_** informando quanto dinheiro o player fez, sendo o dinheiro ganho dependente de 3 fatores: _<span style="color:#56949f;font-style:italic;">Quantidade de caixas coletadas</span>_, _<span style="color:#56949f;font-style:italic;">dano do barco</span>_ e _<span style="color:#56949f;font-style:italic;">tempo para chegar ao destino</span>_. Além disso, nessa mesma tela caso o player tenha conseguido o valor mínimo de dinheiro o **<span style="color:#b4637a;font-weight:bold">botão para ir para o próximo nível</span>** aparecerá, caso não ele terá o **<span style="color:#b4637a;font-weight:bold">botão de refazer a fase</span>** ou **<span style="color:#b4637a;font-weight:bold">voltar para o menu inicial</span>**. Os níveis seguintes vão introduzir novas mecânicas como obstáculos para desafiar as habilidades do jogador mantendo o mesmo sistema de dinheiro.

| <span style="color:#b4637a;">Arte</span> | Status | <span style="color:#56949f;">Programação</span> | Status |
| ---------------------------------------- | :----: | ----------------------------------------------- | :----: |
| Tela de Loading                          |   🚧   | Loading entre cenas                             |   ✅   |
| Fonte                                    |   🚧   | Controles do Barco                              |   ✅   |
| Backdrop Menu Inicial                    |   🚧   | Diálogos (dialogic2)                            |   🚧   |
| Botões Tela inicial                      |   🚧   | Começar uma nova missão                         |   🚧   |
| Botões de Controles do Barco             |   🚧   | Completar a missão atual                        |   🚧   |
| Interface de Diálogo                     |   🚧   | Interface de Controle do Barco                  |   🚧   |
| Modelo do Barco                          |   ✅   | Interface de Pausa                              |   🚧   |
| Texto dos diálogos                       |   🚧   | Física e Colisões                               |   ✅   |
| Narrativa do jogo                        |   🚧   | Quantidade Caixas Coletadas                     |   🚧   |
| Sprites dos personagens                  |   🚧   | Dano do Barco                                   |   🚧   |
| Ícones                                   |   🚧   | Tempo para Completar Entrega                    |   🚧   |
| Botão Próximo Nível                      |   🚧   |                                                 |        |
| Botão Refazer Fase                       |   🚧   |                                                 |        |
| Voltar para Menu Inicial                 |   🚧   |                                                 |        |

| <span style="color:#ea9d34;">Sons</span> | Status |
| ---------------------------------------- | :----: |
| Sons de UI                               |   🚧   |
| Música de fundo tela inicial             |   🚧   |
| Música Tela Resultados                   |   🚧   |

## Licensas

- Assets - Modelos 3D e Texturas:
  - ["PirateKit by Kenney"](https://kenney.nl/assets/pirate-kit) CC0
  - ["UI Pack Adventure by Kenney"](https://kenney.nl/assets/ui-pack-adventure) CC0
  - ["Input Prompts by Kenney"](https://kenney.nl/assets/input-prompts) CC0
  - ["Fonts by Kenney"](https://kenney.nl/assets/kenney-fonts) CC0
  - ["Watercraft Kit by Kenney"](https://kenney.nl/assets/watercraft-kit) CC0
- Assets - Sons:
  - ["Interface Sounds by Kenney"](https://kenney.nl/assets/interface-sounds) CC0
  - Menu Principal ["Curry Us - Dan Knoflicek](https://opengameart.org/content/curry-us) CC-BY 3.0
  - Level 1 ["Courage Rescue - Dan Knoflickek](https://opengameart.org/content/courage-rescue) CC-BY 4.0
  - Créditos ["A Floater - Dan Knoflickek"](https://opengameart.org/content/a-floater) CC-BY 4.0
- Código:
  - ["BeeHave"](https://bitbra.in/beehave/#/) MIT
  - ["Dialogic"](https://github.com/dialogic-godot/dialogic?tab=readme-ov-file#dialogic-2) MIT
  - ["Phantom Camera"](https://phantom-camera.dev/) MIT
  - Esse jogo MIT

## Inspiração Level Design

- [Rational Approach to Racing Game Track Design](https://www.gamedeveloper.com/design/a-rational-approach-to-racing-game-track-design)
![](readme-assets/pista-interlagos.svg)
