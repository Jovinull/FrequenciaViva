# Verificação da vertical slice — Marco 01

## Ambiente

- Godot 4.7.2 stable, renderer Compatibility.
- Exportação Web single-threaded, executada por servidor HTTP local.
- Navegador Playwright com WebGL 2; a página final registrou zero erros e zero avisos no console.
- Resolução lógica: 480×270; captura da página: 1280×720, com escala inteira e barras de enquadramento.

## Verificações realizadas

- Execução curta sem interface: `godot --headless --path . --quit-after 3` — saída 0, sem erros de script.
- Exportação Web de release com o preset `Web` — saída 0.
- Abertura, textos do painel, medidor, dial e botão no navegador.
- Setas a partir do início ajustam a frequência. Em 95,4 MHz, o pico falso mostra `SINAL 2 / 4` e sete segmentos âmbar.
- Transmitir no pico falso mantém o puzzle aberto, mostra retorno de falha e devolve o foco de teclado ao dial.
- Setas após a tentativa inválida chegam a 99,2 MHz; o estado muda para `SINAL ESTÁVEL` e os dez segmentos ficam turquesa.
- Arraste horizontal de 72 pixels de tela, desde o início, chega à faixa válida.
- Roda para cima e para baixo move o dial um passo (0,1 MHz); depois de ambos, uma seta para a direita avança de 93,8 para 93,9 MHz.
- Transmissão válida anima a onda, atualiza a mensagem, apresenta o botão de reinício e retorna ao estado inicial sem recarregar a página.
- Capturas reais de todos esses estados estão em `evidence/`, que contém `.gdignore` para o jogo não importar ou empacotar as imagens de revisão.

## Limites desta verificação

- Não houve playtest com pessoas novas nem avaliação auditiva dos efeitos.
- A estabilidade foi observada numa sessão de navegador e resolução; testar outros navegadores, telas, proporções e taxas de escala antes da submissão.
- Aprovação de arte e validação cultural continuam pendentes.
