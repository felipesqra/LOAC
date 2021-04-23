// Felipe de Souza Siqueira
// Fim de Expediente, questão 1 da lista: http://lad.ufcg.edu.br/loac/index.php?n=OAC.Comb

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
           output logic lcd_MemWrite, lcd_Branch, lcd_MemtoReg, lcd_RegWrite);

  /*
    Especificação:

    O alarme de uma fábrica deve ser acionado em uma das seguintes situações:
      - Passou das 18:00 h e todas as máquinas estão fora de operação.
      - É sexta-feira, a produção do dia foi atingida e todas as máquinas estão
      fora de operação.

    As entradas do programa devem ser:
      * noite (passou das 18:00 h) - SWI[4];
      * paradas (todas as máquinas estão fora de operação) - SWI[5];
      * sexta (é sexta-feira) - SWI[6];
      * producao (produção do dia foi atendida) - SWI[7].
    
    A saída única deve ser:
      * sirene (tocar alarme) - LED[2].
  */
  
  // entradas

  logic noite, paradas, sexta, producao;

  always_comb begin
    noite <= SWI[4];
    paradas <= SWI[5];
    sexta <= SWI[6];
    producao <= SWI[7];
  end

  // lógica 

  logic sirene;

  always_comb begin
    sirene <= (noite & paradas) | (sexta & producao & paradas);
  end

  // saída

  always_comb begin
    LED[2] <= sirene;
  end

endmodule