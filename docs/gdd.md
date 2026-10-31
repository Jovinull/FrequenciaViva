# GDD enxuto — Marco 02

## Visão

**Frequência Viva** é um puzzle narrativo 2D planejado para navegador. Esta fatia contém sintonia e uma entrega roteada. A equipe, estação, oficina e mensagens são ficcionais; o jogo identifica a equipe como indígena contemporânea sem reivindicar representar um povo real.

## Pilares

1. **Controles táteis e legíveis:** dial e seletores respondem imediatamente, com retorno visual e sonoro.
2. **Autoria e circulação:** a equipe revisa a própria pauta e aprova a versão; quem recebe usa o boletim para escolher uma atividade.
3. **Objetos com função:** botões, dial, medidor e painel parecem ferramentas de trabalho, não uma coleção de minijogos.

## Loop da fatia

1. A equipe escolhe sensores de luz como pauta para uma oficina de ciências.
2. Arrastar o dial horizontalmente ou usar roda/setas para percorrer o espectro.
3. Encontrar **10/10**. O pico falso chega a **7/10**, fica âmbar e não permite transmitir.
4. Transmitir e receber a resposta da oficina.
5. Escolher um retransmissor entre três. Comparar perda por distância e por ruído, observar o sinal previsto e escolher uma rota que chegue com pelo menos **7/10**.
6. Receber confirmação final ou explicação da perda; reiniciar sem recarregar.

## Regras determinísticas

### Sintonia

O dial cobre 92,0–104,0 MHz, em passos de 0,1 MHz. A qualidade deriva da distância ao sinal principal e de um pico falso. O medidor tem dez segmentos e texto de **0/10 a 10/10** na mesma escala. O pico correto permite transmissão na tolerância de 0,1 MHz; o pico falso não.

### Roteamento

Origem **10/10**, mínimo de chegada **7/10**. Cada rota desconta a perda indicada por distância e ruído. A curta perde `1 + 4` barras; a equilibrada `2 + 1`; a longa `4 + 0`. Só a rota equilibrada alcança o mínimo. Essas quantidades são regras ficcionais do puzzle, não dados de engenharia nem descrição de infraestrutura indígena real.

Estados: `SINTONIZANDO`, `TRANSMITINDO`, `RECEBIDO` e `ROTEANDO`. Transmitir sem sintonia válida, sem rota ou com chegada inferior a sete não avança; o jogo explica o erro. Reiniciar limpa seleção e tentativas.

## Proposta narrativa provisória

A equipe ficcional de comunicadores indígenas escolhe uma pauta sobre sensores de luz, revisa o boletim e aprova sua versão. A oficina recebe a pauta e decide testar os sensores. O jogador restaura a sintonia e compara rotas para entregar a versão completa. A equipe define o que envia; quem recebe escolhe como usar a pauta.

Falas provisórias, assistidas por IA, sujeitas a revisão editorial e cultural. Não atribuir o acontecimento a povo, lugar, idioma ou experiência reais. Consulta cultural qualificada continua pendente.

## Escopo seguinte

Não criar campanha longa neste marco. Fazer playtests da combinação sintonia + rota; só depois adicionar outra condição ou conteúdo. Evitar mapa de rede, inventário e personagens ilustrados antes de validar os dois puzzles.
