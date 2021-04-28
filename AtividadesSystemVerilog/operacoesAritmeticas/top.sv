//Felipe de Souza Siqueira
//Soma de números de 3 bits, segundo exercício disponível no link: https://lad.dsc.ufcg.edu.br/loac/index.php?n=OAC.Soma
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

Implemente um somador para dois valores inteiros de 3 bits (SWI[7:5) e SWI[2:0]) e visualize o resultado de 3 bits em LED[2:0]. 
Visualize o resultado também em base decimal no display de sete segmentos. (presencial: 2 pontos de nota) (remoto: até 8 centavos)

*/

  logic bit0, bit1, bit2, bit3, bit4, bit5;

  always_comb begin


  end
endmodule