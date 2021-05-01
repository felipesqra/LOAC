// Felipe de Souza Siqueira
// Uma estufa, questão 3 da lista: http://lad.ufcg.edu.br/loac/index.php?n=OAC.Comb
// 119110399

parameter NINSTR_BITS = 32;
parameter NBITS_TOP = 8, NREGS_TOP = 32, NBITS_LCD = 64;

module top(input  logic clk_2,
           input  logic [NBITS_TOP-1:0] SWI,
           output logic [NBITS_TOP-1:0] LED,
           output logic [NBITS_TOP-1:0] SEG,
           output logic [NBITS_LCD-1:0] lcd_a, lcd_b,
           output logic [NINSTR_BITS-1:0] lcd_instruction,
           output logic [NBITS_TOP-1:0] lcd_registrador [0:NREGS_TOP-1],
           output logic [NBITS_TOP-1:0] lcd_pc, lcd_SrcA, lcd_SrcB,
           lcd_ALUResult, lcd_Result, lcd_WriteData, lcd_ReadData, 
           output logic lcd_MemWrite, lcd_Branch, lcd_MemtoReg, lcd_RegWrite
          );

/*
Uma estufa deve manter a temperatura interna sempre na faixa entre 15°C e 20°C controlada automaticamente 
por um sistema de controle digital. Para tanto, foram instalados internamente dois sensores de temperatura 
que fornecem níveis lógicos 0 e 1 nas seguintes condições:

· T1 = 1 para temperatura ≥ 15°C; - chave SWI[3]   ---- Anotação pessoal: Se a temperatura cair abaixo de 15 graus o sensor desliga e o aquecedor liga

· T2 = 1 para temperatura ≥ 20°C. - chave SWI[4]   ---- Anotação pessoal: Se a temperatura subir acima de 20 graus o sensor liga e o resfriador liga também

Faça o controle da temperatura desta estufa a partir do acionamento de um aquecedor A (LED[6]) ou um 
resfriador R (LED[7]) sempre que a temperatura interna cair abaixo de 15°C ou subir acima de 20°C, respectivamente. 
Em caso de inconsistência dos sinais dos sensores de temperatura, um LED vermelho (SEG[7]) deve acender e nem o 
resfriamento nem o aquecimento deve ser acionados.    

    ---- Anotação pessoal: Caso eu indique que a temperatura está acima de 20 graus e abaixo de 15 graus ao mesmo
tempo um LED deve acender.

*/

  logic T1, T2, aquecedor, resfriador, inconsistencia; // Definindo variáveis que serão utilizadas

  always_comb begin
    T1 <= SWI[3];
    T2 <= SWI[4];

    //lógica

    aquecedor <= ~T1 & ~T2;
    resfriador <= T1 & T2;
    inconsistencia <= ~T1 & T2;

    //saída

    LED[6] <= aquecedor;
    LED[7] <= resfriador;
    SEG[7] <= inconsistencia;

  end

endmodule
