//Felipe de Souza Siqueira
//Representa inteiro, primeiro exercício disponível no link: https://lad.dsc.ufcg.edu.br/loac/index.php?n=OAC.Soma
//119110399

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
Implemente um circuito que represente um valor inteiro de tamanho 3 
bits (SWI[2:0]) em base decimal no display de sete segmentos. 
No lugar do sinal "-" use o ponto (SEG[7]). 
*/

logic bit0, bit1, bit2;

always_comb begin
  bit0 <= SWI[0];
  bit1 <= SWI[1];
  bit2 <= SWI[2];

  always @(*) begin
    
    
  end
end