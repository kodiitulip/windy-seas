# Windy Seas

<p align="center">
  <img class="align-center" src="./icon.svg" alt="icon"/>
</p>

> [!NOTE]
> Legenda
> - Código: **<span style="color:#FF0A0A;font-weight:bold;">Negrito</span>**
> - Arte: _<span style="color:#59d7ee;font-style:italic;">Itálico</span>_
> - Som: **_<span style="color:#FFFF00;font-weight:bold;font-style:italic;">Negrito Itálico</span>_**

## Narrativa

O jogador aceita um trabalho como cargueiro para quitar dívidas de jogo. Agora deve desbravar os perigosos 7 mares fazendo entregas de pacotes clandestinos, para pagar a dívida... ou morrer tentando!
## Jogo

Começa o jogo com uma _<span style="color:#59d7ee;font-style:italic;">tela</span>_ de **<span style="color:#FF0A0A;font-weight:bold;">Loading</span>** para o **<span style="color:#FF0A0A;font-weight:bold;">menu inicial</span>**, sendo esse composto pelos _<span style="color:#59d7ee;font-style:italic;">botões jogar e sair do jogo</span>_ possuindo **_<span style="color:#FFFF00;font-weight:bold;font-style:italic;">música de fundo</span>_**. Ao clicar em jogar uma tela de **<span style="color:#FF0A0A;font-weight:bold;">Loading</span>** levará o jogador para a próxima cena que consiste do primeiro nível do jogo: Um _<span style="color:#59d7ee;font-style:italic;">cais</span>_ onde um jogador(representado pelo _<span style="color:#59d7ee;font-style:italic;">modelo do barco</span>_) receberá instruções por meio de **<span style="color:#FF0A0A;font-weight:bold;">diálogos</span>** em _<span style="color:#59d7ee;font-style:italic;"> balões de fala</span>_ sobre como **<span style="color:#FF0A0A;font-weight:bold;">controlar o barco</span>**, sendo necessário coletar ao menos uma das caixas dispostas no percurso até chegar no caís de destino. Ao chegar no caís de destino uma tela de resultados vai aparecer em conjunto com a música da tela de resultados informando quanto dinheiro o player fez, sendo o dinheiro ganho dependente de 3 fatores: Quantidade de caixas pegas, dano do barco e tempo para completar a entrega. Além disso, nessa mesma tela caso o player tenha conseguido o valor mínimo de dinheiro o botão para ir para o próximo nível aparecerá, caso não ele terá a opção de refazer a fase ou voltar para o menu inicial.  Os níveis seguintes vão introduzir novas mecânicas como obstáculos para desafiar as habilidades do jogador.


| Arte                         | Status | Programação                    | Status |
| ---------------------------- | :----: | ------------------------------ | :----: |
| Tela de Loading              |   🚧   | Loading entre cenas            |   ✅    |
| Fonte                        |   🚧   | Controles do Barco             |   ✅    |
| Backdrop Tela Inicial        |   🚧   | Diálogos (dialogic2)           |   🚧   |
| Botões Tela inicial          |   🚧   | Começar uma nova missão        |   🚧   |
| Botões de Controles do Barco |   🚧   | Completar a missão atual       |   🚧   |
| Interface de Diálogo         |   🚧   |                                |        |
|                              |        | Interface de Controle do Barco |   🚧   |
| Modelo do Barco              |   ✅    | Interface de Pausa             |   🚧   |
| Texto dos diálogos           |   🚧   | Física e Colisões              |   ✅    |
| Narrativa do jogo            |   🚧   |                                |        |
| Sprites dos personagens      |   🚧   |                                |        |
| Ícones                       |   🚧   |                                |        |

| Sons            | Status |
| --------------- | :----: |
| Sons de UI      |   🚧   |
| Música de fundo |   🚧   |

## Licensas

- Assets - Modelos 3D e Texturas:
  - ["PirateKit by Kenney"](https://kenney.nl/assets/pirate-kit) CC0
  - ["UI Pack Adventure by Kenney"](https://kenney.nl/assets/ui-pack-adventure) CC0
  - ["Input Prompts by Kenney"](https://kenney.nl/assets/input-prompts) CC0
  - ["Fonts by Kenney"](https://kenney.nl/assets/kenney-fonts) CC0
- Assets - Sons:
  - ["Interface Sounds by Kenney"](https://kenney.nl/assets/interface-sounds) CC0
- Código:
  - ["BeeHave"](https://bitbra.in/beehave/#/) MIT
  - ["Dialogic"](https://github.com/dialogic-godot/dialogic?tab=readme-ov-file#dialogic-2) MIT
  - ["Phantom Camera"](https://phantom-camera.dev/) MIT
  - Esse jogo MIT
