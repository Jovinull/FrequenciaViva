# Frequência Viva

Puzzle narrativo curto sobre sintonia, circulação de mensagens e protagonismo na comunicação comunitária indígena contemporânea. O cenário e a equipe são ficcionais; nenhum personagem representa um povo real.

## Estado

Marco 02: fatia jogável com tutorial de sintonia, pico falso, puzzle determinístico de rota, transmissão e resposta da oficina. A arte continua em revisão; não está aprovada.

## Executar

Requer Godot 4.7.2 ou compatível. Abra `project.godot` no editor e pressione F6/F5, ou execute no terminal:

```powershell
godot --path .
```

Para rodar os testes de lógica:

```powershell
godot --headless --path . --script tests/run_tests.gd
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
- Ajuste até **10/10** e clique em **TRANSMITIR**. O pico âmbar em 7/10 é falso.
- Depois da confirmação, escolha um retransmissor. Compare perda de alcance (A) e ruído (R); a rota deve chegar com pelo menos 7/10.
- Em roteamento, use os botões, teclas `1`, `2`, `3` ou `Enter` após escolher. No fim, reinicie o turno.

## Capturas reais

- [Abertura do Marco 02](evidence/10-marco02-abertura.png) · [pico falso](evidence/11-marco02-pico-falso.png) · [falha de sintonia](evidence/12-marco02-erro-de-sintonia.png)
- [Seleção de rota](evidence/15-marco02-escolha-rota.png) · [rota fraca](evidence/16-marco02-rota-fraca.png) · [rota equilibrada](evidence/18-marco02-rota-clara.png) · [entrega](evidence/19-marco02-entrega.png)
- [Tela nativa 480 × 270](evidence/23-marco02-native-480x270.png) · [janela 640 × 360](evidence/21-marco02-janela-640x360.png) · [janela 1280 × 720](evidence/22-marco02-janela-1280x720.png)
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
- `tests/`: testes automatizados da lógica de sintonia, roteamento e campanha.

## Fontes e produção

Os fontes de arte `.aseprite` ficam fora do repositório em `C:\Workspace\FrequenciaViva-art\source`. Os sprites atuais foram desenhados manualmente em LibreSprite no Marco 01; o redesenho artístico previsto para o Marco 02 permanece pendente. Nenhum gerador de imagem ou modelo de sprite foi usado. Consulte [créditos](docs/credits.md), [direção artística](docs/direcao-artistica.md), [pesquisa cultural](docs/pesquisa-cultural.md) e [GDD](docs/gdd.md).

Ferramentas de assistência de IA foram usadas no planejamento, pesquisa, documentação e implementação de código. A arte raster final foi desenhada manualmente. A narrativa provisória é assistida por IA e ainda precisa de revisão editorial e consulta cultural qualificada antes de ser considerada definitiva. O regulamento oficial ligado pela organização está em uma pasta do Drive que não exibiu os arquivos sem login; não foi encontrada cópia no workspace. A equipe responsável pela inscrição deve confirmar com a organização como declarar assistência de IA.
