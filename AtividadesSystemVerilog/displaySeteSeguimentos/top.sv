//Felipe de Souza Siqueira
//Display de 7 seguimentos
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

Classificador de nota
Implemente um circuito lógico combinacional que apresente a situação de um aluno em um display de sete segmentos, conforme descrição a seguir.

    “A” (Aprovado por média) se a nota do aluno for igual ou superior a 7 pontos
    “F” (Final) se a nota do aluno for maior ou igual a 4 e menor que 7 pontos
    “P” (Perdeu a disciplina) se a nota do aluno for inferior a 4 pontos. 
Observação: a nota do aluno é representada por um valor inteiro entre 0 e 9.

Entradas:

    SWI[3:0] ... nota do aluno
    SWI[7] ... em "1" mostra a situação, em "0" mostra a nota. 

Saída: SEG

*/

logic opcao;
logic [3:0] bits;

always_comb begin
  opcao <= SWI[7];
  bits <= SWI[3:0];

  if (opcao) begin
    case (bits)
      0:SEG[6:0] <= 7'b01110011; //P
      1:SEG[6:0] <= 7'b01110011; //P
      2:SEG[6:0] <= 7'b01110011; //P
      3:SEG[6:0] <= 7'b01110011; //P
      4:SEG[6:0] <= 7'b01110001; //F
      5:SEG[6:0] <= 7'b01110001; //F
      6:SEG[6:0] <= 7'b01110001; //F
      7:SEG[6:0] <= 7'b01110111; //A
      8:SEG[6:0] <= 7'b01110111; //A
      9:SEG[6:0] <= 7'b01110111; //A
    endcase
  end

  else begin
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
      // 8
      8:SEG[7:0]  <= 8'b01111111;
      // 9
      9:SEG[7:0]  <= 8'b01100111;
    endcase
  end

end
endmodule
