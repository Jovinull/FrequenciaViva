# Direção artística — Frequência Viva

## Intenção

Uma estação de comunicação de uso diário: ferramenta de trabalho construída, mantida e operada no presente. A personalidade vem de marcas de uso, adaptações e objetos úteis; não de ornamentos culturais. A imagem mistura metal pintado, baquelite escura, vidro âmbar e etiquetas de manutenção. A luz é emitida pelos instrumentos, com uma única fonte quente e pequenos indicadores verde-água.

## Princípios extraídos das referências

As referências são estudo de princípios e não fontes de assets. Nenhum personagem, sprite, tela, moldura, ícone ou arranjo distintivo é reproduzido.

- **VA-11 Hall-A:** equipamentos e interface podem compartilhar o mesmo espaço diegético; a repetição de poucos materiais dá identidade a uma bancada. Adotar a integração entre objeto e interface, sem reproduzir balcão, layout ou elementos do jogo. [Página oficial de VA-11 Hall-A](https://playism.com/game/va11halla/)
- **Coffee Talk:** luz noturna e paleta controlada sustentam uma conversa íntima; retrato, fundo e texto precisam ter hierarquia. Aqui, a intimidade virá de uma mensagem curta e da luz do receptor, sem bar de café, personagens ou enquadramento copiados. [Página de Coffee Talk pela Toge Productions](https://togeproductions.itch.io/coffee-talk)
- **Unpacking:** escala pequena e silhuetas legíveis dão significado a objetos comuns. Na estação, cabos, parafusos, fita de reparo e etiquetas devem indicar função ou uso, não preencher espaço. [Site oficial de Unpacking](https://www.unpackinggame.com/)
- **NORCO:** enquadramentos atmosféricos e relações entre planos podem contar o lugar sem diálogo explicativo. Nesta tela única, profundidade virá do fundo recuado, plano da mesa e painel frontal; sem apropriar iconografia ou composição de uma cena específica. [Página do jogo na Steam](https://store.steampowered.com/app/1221250/NORCO/)
- **Eastward:** ambientes pixelados densos funcionam quando a silhueta e o caminho de leitura continuam claros. Usar contraste de escala e detalhes seletivos, sem copiar cenário, personagem ou iluminação. [Galeria oficial de mídia](https://eastwardgame.com/media/)
- **OneShot:** a luz pode direcionar a atenção e mudar o sentido de um objeto. Reservar a faixa âmbar para sintonia e a turquesa para sinal confirmado; não imitar telas, personagens ou enquadramentos específicos. [Página oficial na Steam](https://store.steampowered.com/app/420530/OneShot/)

Essas leituras são observações artísticas do material público e dos jogos, não citações de intenção dos autores.

## Especificação visual

- Resolução lógica: **480 × 270**, 16:9.
- Escala: integer stretch sempre que possível; filtro nearest para todas as texturas.
- Perspectiva: quadro frontal quase ortográfico; bancada em leve 3/4 apenas nos planos inferiores. Um único ponto de fuga implícito.
- Iluminação: ambiente azul-petróleo; fonte âmbar pequena atrás do visor; indicadores não emitem bloom. Realces ficam nas bordas voltadas à fonte.
- Cluster e pixel: formas-base de 1 px; contornos seletivos de 1 px; detalhes de até 2 px apenas no equipamento próximo. Evitar linhas inconsistentes e ruído aleatório.
- Hierarquia: primeiro mensagem/estado, depois dial e medidor, por fim marcas de fabricação e objetos de apoio.

## Paleta inicial refinada

| Uso | Cor | Hex |
|---|---|---|
| sombra fria | noite profunda | `#161F2A` |
| carcaça escura | petróleo escuro | `#263640` |
| painel pintado | petróleo | `#36525A` |
| borda iluminada | verde cinza | `#66766A` |
| madeira e etiqueta | terracota | `#AD704C` |
| controle e visor | âmbar | `#E2B36B` |
| texto e brilho curto | creme | `#F3DBA5` |
| sinal estável | turquesa | `#64BBA6` |
| falha/interferência | coral | `#D66D65` |

Reservar coral para falha, nunca para decoração. Manter texto relevante em creme ou âmbar sobre valores escuros.

## Pipeline e ativos

1. Thumbnail da tela inteira.
2. Grandes planos e silhuetas da carcaça.
3. Três sprites revisados isoladamente: corpo do rádio, dial e medidor.
4. Materiais e luz em clusters manuais.
5. Rótulos, parafusos e marcas funcionais em poucos pontos.
6. Integração com controles Godot e verificação em escala nativa.
7. Captura da execução real, revisão e ajustes.

Fontes editáveis `.aseprite` ficam fora do repositório em `C:\Workspace\FrequenciaViva-art\source`. Os PNG finais são exportados manualmente para `assets/art/`. Não usar imagens geradas por IA, geradores de sprites ou scripts para desenhar a arte final.

## Revisão da vertical slice

Os três sprites finais são originais e foram desenhados à mão no LibreSprite; as formas não foram criadas por script. Na tela real, corpo, dial e medidor têm escala e contorno coerentes, e a resolução lógica preserva o pixel. O texto do visor agora ocupa uma área azul lisa e legível. O falso pico usa âmbar e o bloqueio usa turquesa.

Pendências visuais: a carcaça ainda é geométrica e pouco marcada pelo uso; o dial não tem números ou marcas de frequência próprias; faltam um fundo de oficina, pequenos objetos funcionais e movimento ambiental. A tela lisa favorece leitura, mas encobre as pequenas marcas verdes desenhadas no visor. Manter os PNGs como protótipo revisável e não declarar a direção aprovada até nova avaliação do jogo.
