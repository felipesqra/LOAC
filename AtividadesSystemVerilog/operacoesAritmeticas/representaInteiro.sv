//Felipe de Souza Siqueira
//Representação de um inteiro, primeiro exercício disponível no link: https://lad.dsc.ufcg.edu.br/loac/index.php?n=OAC.Soma
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
Especificação:
  Implemente um circuito que represente um valor inteiro de tamanho 3 
  bits (SWI[2:0]) em base decimal no display de sete segmentos. 
  No lugar do sinal "-" use o ponto (SEG[7]). 

*/

  logic [3:0] bits;

  always_comb begin
  bits <= SWI[2:0];
  
    case (bits)
      // 0
      0:SEG[7:0] <= 8'b00111111;
      // 1
      1:SEG[7:0] <= 8'b00000110;
      // 2
      2:SEG[7:0] <= 8'b01011011;
      // 3
      3:SEG[7:0] <= 8'b01001111;
      // 4
      4:SEG[7:0] <= 8'b01100110;
      // 5
      5:SEG[7:0]  <= 8'b01101101;
      // 6
      6:SEG[7:0]  <= 8'b00111101;
      // 7
      7:SEG[7:0]  <= 8'b00000111;
    endcase
  end
endmodule
