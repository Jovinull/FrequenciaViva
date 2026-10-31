# Pendências — Marco 02

- **P0 — arte ainda não refeita:** os sprites do rádio, dial e medidor continuam iguais aos do Marco 01. Não há planos ambientais nem contexto de oficina. A captura real mantém um grande vazio azul e uma carcaça geométrica. Não declarar a direção aprovada.
- **P0 — revisão manual no LibreSprite pendente:** não foram salvos novos fontes `.aseprite` nem substituídos PNGs de arte neste marco. A máscara do medidor é apenas um ajuste de interface, não uma revisão do sprite.
- **P0 — validação de diversão pendente:** o roteamento oferece três perdas determinísticas e uma rota válida. A lógica é clara, mas ainda não foi observado se pessoas entendem a escolha ou a consideram interessante. Nenhum playtest humano foi realizado.
- **P1 — tipografia/resolução:** a fonte atual é padrão. A janela de 640 × 360 reduz a leitura; observar em dispositivos e navegadores diferentes e ajustar escala mínima antes da submissão.
- **P1 — medidor:** texto e dez segmentos agora correspondem de 0/10 a 10/10. A execução visual precisa ser revista em escala nativa; a face continua provisória.
- **P1 — áudio:** cliques, ruído, trava e confirmação são efeitos originais já incluídos. Ainda não houve escuta humana com fones ou caixas de som, nem ajuste subjetivo dos níveis.
- **P1 — conclusão:** há confirmação, onda e flash breve; falta um momento audiovisual de chegada mais próprio e expressivo.
- **Cultura:** equipe, estúdio, pauta, sensores e oficina são ficcionais e não representam povo real. O roteiro foi assistido por IA; requer revisão editorial e consulta cultural qualificada antes de ser definitivo. Não criar idioma, ritual, símbolo ou grafismo cultural específico.
- **Competição:** o PDF integral não está no workspace e não foi lido. Os dados de avaliação vêm do briefing da responsável. A política específica de assistência de IA continua pendente de resposta da organização.
- **Navegador:** a build foi percorrida no Chrome 156 em modo headless com WebGL 2 via SwiftShader, nas janelas de 960 × 540, 640 × 360 e 1280 × 720. Repetir em navegadores e hardware reais; o navegador remoto Playwright disponível nesta estação não oferece WebGL.
- **Peso da Web:** `index.wasm` tem 39,5 MB sem compressão. Verificar a transferência no host de submissão e compressão gzip/Brotli; a documentação da Godot observa que itch.io não comprime esses arquivos automaticamente.
