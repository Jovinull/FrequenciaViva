# GDD enxuto — Marco 01

## Visão

**Frequência Viva** é um puzzle narrativo 2D de 12–18 minutos planejado para navegador. A primeira fatia vertical é um turno de trabalho de menos de dois minutos em uma estação de rádio. A equipe, a estação e as mensagens são ficcionais. A abertura torna explícito que a equipe é um grupo contemporâneo de comunicadores indígenas fictício e não representa um povo real.

## Pilares

1. **Sintonia prazerosa:** movimento pequeno, contínuo e legível; retorno visual e sonoro imediato.
2. **Autoria e circulação:** a mensagem ganha um destino, não se transforma em artefato genérico colecionável.
3. **Objetos com função:** botões, dial, medidor e painel parecem uma ferramenta usada de verdade.

## Loop da vertical slice

1. Ler a mensagem: uma oficina de ciências aguarda o boletim gravado pela equipe.
2. Arrastar o dial horizontalmente ou usar roda/setas para percorrer o espectro.
3. Observar a qualidade em tempo real e localizar a faixa de sinal mais forte e estável sem receber sua frequência em texto.
4. Transmitir quando o estado indicar **SINAL ESTÁVEL**; o pico falso fica forte, mas âmbar e sem travar.
5. Receber confirmação visual/sonora e ler a resposta curta.
6. Recomeçar pelo botão de nova sintonia.

## Regra do puzzle

O dial cobre um trecho curto de FM, com passos de 0,1 MHz. A qualidade é determinística e deriva da distância entre a frequência escolhida e o pico do transmissor. Uma faixa lateral mais fraca cria ruído e impede que a simples leitura da amplitude pareça um valor binário. O jogador tem objetivo explícito: achar o pico que mantém quatro barras estáveis. Frequência-alvo e perfil ficam em dados separados da apresentação para permitir novas fases.

Estados: `SINTONIZANDO` (qualidade variável), `PRONTO` (pico válido), `TRANSMITINDO` (breve onda e confirmação), `RECEBIDO` (mensagem e reinício). Transmitir fora da janela não avança e mostra instrução clara; nenhuma tentativa deixa estado sem saída.

## Conteúdo provisório

**Contexto:** uma equipe de comunicação comunitária indígena fictícia preparou um boletim para uma oficina de ciências. O operador restabelece a sintonia para que o material chegue à turma.

**Fecho da fatia:** “Chegou. As bancadas já estão acesas.”

Texto experimental, assistido por IA, sujeito a revisão editorial e cultural. Não atribuir o acontecimento a povo, lugar, idioma ou experiência reais.

## Próximos níveis, se P0/P1 estiverem sólidos

1. Ajustar a frequência em uma faixa com um pico falso perceptível.
2. Encaminhar o sinal por um retransmissor com limite de capacidade.
3. Combinar sintonia e rota; cada nível apresenta uma única nova ideia.

Não adicionar campanha longa, personagem ilustrado, mapa de rede ou sistema de inventário antes de confirmar a diversão do loop básico.
