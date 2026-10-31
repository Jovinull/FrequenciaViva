# Verificação — Marco 02

Data: 31/10/2026. Godot 4.7.2 stable, renderer Compatibility e export Web single-threaded. O navegador foi servido por HTTP local e executado no Chrome 156 headless com WebGL 2/SwiftShader. Capturas de estados principais estão em `evidence/10–23-marco02-*.png`.

As exigências de Web foram conferidas na [documentação oficial da Godot 4.7](https://docs.godotengine.org/en/4.7/tutorials/export/exporting_for_web.html): Godot 4 usa WebAssembly e WebGL 2 com renderer Compatibility; exportações com threads precisam de cabeçalhos de isolamento cross-origin. Este projeto usa exportação single-threaded e foi servido por HTTP local.

O `index.wasm` resultante tem 39,5 MB sem compressão; a latência de primeira carga no host da jam ainda não foi medida.

## Testes automatizados

Executado: `godot --headless --path . --script tests/run_tests.gd`.

- PASS — frequência limitada em 92,0–104,0 MHz, passo de 0,1 MHz e trava dentro/fora da tolerância.
- PASS — pico principal 10/10, pico falso 7/10 e limites do medidor entre 0 e 10.
- PASS — perdas por distância e ruído; só `balanced_clear` chega ao mínimo de 7/10.
- PASS — início, tentativas, avanço entre sintonia e rota e reinício da campanha.
- PASS — 4 grupos automatizados.

Executados também `godot --headless --editor --path . --quit` e `godot --headless --path . --export-release Web build/web/index.html`; ambos terminaram sem erro depois da correção de sintaxe. O preset exclui `evidence/*` e `build/*` do pacote.

## Percurso funcional em navegador

- Abriu a build e leu a cena no Chrome com WebGL 2.
- 16 setas levaram de 93,8 a 95,4 MHz; o medidor mostrou 7/10 âmbar. Transmitir não avançou e mostrou falha.
- 38 setas adicionais levaram a 99,2 MHz e 10/10. Mouse acionou transmitir e avançou à confirmação da pauta.
- Clique abriu o roteamento. Clique na rota curta exibiu 5/10 e não transmitiu; a rota equilibrada mostrou 7/10 e concluiu a entrega.
- Clique reiniciou a fatia. A leitura de frequência retorna a 93,8 MHz.
- Redimensionamento verificado em 640 × 360, 960 × 540 e 1280 × 720.
- Console do Chrome não registrou erro JavaScript na sessão. Não foi feita validação em navegador ou GPU adicional.

As imagens foram inspecionadas em 480 × 270 nativo, 960 × 540 e em tamanhos de janela diferentes. A leitura de textos é melhor em escala 2×; no menor tamanho, os rótulos são pequenos. A cena de rota deixa claros os custos e o limiar, mas a diversão e a leitura independente ainda precisam de observação com pessoas.

## Roteiro curto para três pessoas

Nenhum participante externo testou o jogo neste marco. Para a próxima rodada, convide três pessoas individualmente, sem explicar os puzzles. Peça consentimento para observar; não sugira a resposta.

1. Mostre somente a abertura. Pergunte depois de 30 segundos: “O que você acha que precisa fazer?” Registre se a pessoa identifica o dial, o medidor e o botão.
2. Observe se encontra o pico âmbar e percebe que ele não é transmissível. Não diga como ajustar.
3. Após receber a pauta, pergunte: “Como você escolheria o retransmissor?” Registre se A/R, as perdas e 7/10 sustentam uma decisão compreensível, sem tentativa aleatória.
4. Anote tempo até a rota válida, erros, hesitações, comentários espontâneos e se a conclusão parece satisfatória. Pergunte ao final o que a equipe decidiu e quem escolheu o uso da pauta.
5. Não conte esse ensaio como aprovação cultural. Interpretação da representação deve ser revista separadamente por pessoa qualificada e, idealmente, remunerada.

## Limites

Headless e testes automatizados não validam a qualidade visual, som percebido, diversão ou representação cultural. Não houve playtest humano, escuta crítica de áudio nem consulta cultural. A arte continua pendente e sem aprovação.
