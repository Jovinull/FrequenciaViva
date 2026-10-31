# Frequência Viva

Puzzle narrativo curto sobre sintonia, circulação de mensagens e protagonismo na comunicação comunitária indígena contemporânea. O cenário e a equipe são ficcionais; nenhum personagem representa um povo real.

## Estado

Marco 01: fatia vertical jogável. Contém uma estação, um puzzle determinístico com pico falso, transmissão, resposta curta e reinício. A arte continua candidata a revisão; não é uma aprovação final.

## Executar

Requer Godot 4.7.2 ou compatível. Abra `project.godot` no editor e pressione F6/F5, ou execute no terminal:

```powershell
godot --path .
```

O projeto usa GDScript, renderer Compatibility, resolução lógica 480×270, filtro nearest e não depende de plugins.

## Exportar para Web

Instale os templates da mesma versão da Godot e execute:

```powershell
godot --headless --path . --export-release Web build/web/index.html
python -m http.server 8000 --directory build/web
```

Abra `http://127.0.0.1:8000/` no navegador. As capturas da build executada e testada estão em [evidence](evidence/).

## Controles

- Arraste o dial horizontalmente ou use a roda do mouse para sintonizar.
- Também é possível usar as setas esquerda/direita.
- Ajuste até o estado **SINAL ESTÁVEL** e clique em **TRANSMITIR**.
- Depois da mensagem chegar, use **SINTONIZAR DE NOVO** para recomeçar.

## Capturas reais

- [Abertura](evidence/01-opening.png)
- [Pico falso](evidence/02-false-peak.png)
- [Sinal estável](evidence/04-locked.png)
- [Transmissão e mensagem recebida](evidence/05-transmitting.png) · [resposta](evidence/06-received.png)
- [Sintonia por arraste](evidence/08-mouse-locked.png)
- [Roda do mouse e teclado](evidence/09-wheel-and-key.png)

## Estrutura

- `scenes/` e `scripts/`: apresentação e lógica do puzzle.
- `assets/art/`: imagens finais exportadas dos fontes de arte mantidos em `../FrequenciaViva-art/`.
- `assets/audio/`: efeitos sonoros originais do protótipo.
- `docs/`: decisões artísticas, GDD, pesquisa, regras consultadas, créditos e pendências.
- `evidence/`: capturas da versão realmente executada.

## Fontes e produção

O fonte de arte `.aseprite` está fora do repositório em `C:\Workspace\FrequenciaViva-art\source`. A ilustração é desenhada manualmente em LibreSprite; nenhum gerador de imagem ou modelo de sprite foi usado. Consulte [créditos](docs/credits.md), [direção artística](docs/direcao-artistica.md), [pesquisa cultural](docs/pesquisa-cultural.md) e [GDD](docs/gdd.md).

Ferramentas de assistência de IA foram usadas no planejamento, pesquisa, documentação e implementação de código. A arte raster final foi desenhada manualmente. A narrativa provisória é assistida por IA e ainda precisa de revisão editorial e consulta cultural qualificada antes de ser considerada definitiva. O regulamento oficial ligado pela organização está em uma pasta do Drive que não exibiu os arquivos sem login; não foi encontrada cópia no workspace. A equipe responsável pela inscrição deve confirmar com a organização como declarar assistência de IA.
