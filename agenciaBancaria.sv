// Felipe de Souza Siqueira
// Uma agência bancária, questão 2 da lista: http://lad.ufcg.edu.br/loac/index.php?n=OAC.Comb
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
  Especificação:
  2. Uma agência bancária possui um cofre que só pode ser aberto no horário do 
  expediente do banco, este horário é controlado por um relógio eletrônico. 
  Durante o expediente, um interruptor situado na mesa do gerente deve estar 
  desligado para que o cofre possa ser aberto. Se as condições descritas não 
  forem satisfeitas e, mesmo assim, o cofre for aberto, deve-se soar uma sirene
  de alarme, ou seja, para não soar o alarme na abertura do cofre, deve-se
  estar em horário de expediente e com o interruptor desligado.
  
  As entradas devem ser:
  * Porta do cofre (cofre = 0 - porta fechada; cofre = 1 - porta aberta) - SWI[0]

  * Relógio eletrônico (relogio = 0 -fora do expediente; relogio = 1 -horário de expediente) - SWI[1]

  * Interruptor na mesa do gerente (gerente = 0 -alarme desativado; gerente = 1 - alarme ativado) - SWI[2]
  
  A única saída deve ser:
  * Alarme: 0 -silencioso, 1 -gerando sinal sonoro. - SEG[0]

*/

logic portaDoCofre, relogioEletronico, interruptor, alarme;

// Entradas:

always_comb begin
  portaDoCofre <= SWI[0];
  relogioEletronico <= SWI[1];
  interruptor <= SWI[2];
  
  alarme <= portaDoCofre & ~(relogioEletronico & ~interruptor);

  SEG[0] <= alarme;

end

endmodule

  