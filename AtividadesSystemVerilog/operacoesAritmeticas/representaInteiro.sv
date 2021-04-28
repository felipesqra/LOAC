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
Especificação:
  Implemente um circuito que represente um valor inteiro de tamanho 3 
  bits (SWI[2:0]) em base decimal no display de sete segmentos. 
  No lugar do sinal "-" use o ponto (SEG[7]). 
*/

  logic bit0, bit1, bit2, sinal, seguimento0, seguimento1, seguimento2, seguimento3, seguimento4, seguimento5, seguimento6;

  parameter ALTA_TENSAO=1, BAIXA_TENSAO=0;
  
  //Entradas
  always_comb begin
    bit0 <= SWI[0];
    bit1 <= SWI[1];
    bit2 <= SWI[2];

  end

  always @(*) begin

    if (~bit2 & ~bit1 & ~bit0) begin
      seguimento0 <= ALTA_TENSAO;
      seguimento1 <= ALTA_TENSAO;
      seguimento2 <= ALTA_TENSAO;
      seguimento3 <= ALTA_TENSAO;
      seguimento4 <= ALTA_TENSAO;
      seguimento5 <= ALTA_TENSAO;
      seguimento6 <= BAIXA_TENSAO;
    end

    if (~bit2 & ~bit1 & bit0) begin
      seguimento0 <= BAIXA_TENSAO;
      seguimento1 <= ALTA_TENSAO;
      seguimento2 <= ALTA_TENSAO;
      seguimento3 <= BAIXA_TENSAO;
      seguimento4 <= BAIXA_TENSAO;
      seguimento5 <= BAIXA_TENSAO;
      seguimento6 <= BAIXA_TENSAO;
    end

    if (~bit2 & bit1 & ~bit0) begin
      seguimento0 <= ALTA_TENSAO;
      seguimento1 <= ALTA_TENSAO;
      seguimento2 <= BAIXA_TENSAO;
      seguimento3 <= ALTA_TENSAO;
      seguimento4 <= ALTA_TENSAO;
      seguimento5 <= BAIXA_TENSAO;
      seguimento6 <= ALTA_TENSAO;
    end

    if (~bit2 & bit1 & bit0) begin
      seguimento0 <= ALTA_TENSAO;
      seguimento1 <= ALTA_TENSAO;
      seguimento2 <= ALTA_TENSAO;
      seguimento3 <= ALTA_TENSAO;
      seguimento4 <= BAIXA_TENSAO;
      seguimento5 <= BAIXA_TENSAO;
      seguimento6 <= ALTA_TENSAO;
    end

    if (bit2 & ~bit1 & ~bit0) begin
      seguimento0 <= BAIXA_TENSAO;
      seguimento1 <= ALTA_TENSAO;
      seguimento2 <= ALTA_TENSAO;
      seguimento3 <= BAIXA_TENSAO;
      seguimento4 <= BAIXA_TENSAO;
      seguimento5 <= ALTA_TENSAO;
      seguimento6 <= ALTA_TENSAO;
    end

    if (bit2 & ~bit1 & bit0) begin
      seguimento0 <= ALTA_TENSAO;
      seguimento1 <= BAIXA_TENSAO;
      seguimento2 <= ALTA_TENSAO;
      seguimento3 <= ALTA_TENSAO;
      seguimento4 <= BAIXA_TENSAO;
      seguimento5 <= ALTA_TENSAO;
      seguimento6 <= ALTA_TENSAO;
    end

    if (bit2 & bit1 & ~bit0) begin
      seguimento0 <= ALTA_TENSAO;
      seguimento1 <= BAIXA_TENSAO;
      seguimento2 <= ALTA_TENSAO;
      seguimento3 <= ALTA_TENSAO;
      seguimento4 <= ALTA_TENSAO;
      seguimento5 <= ALTA_TENSAO;
      seguimento6 <= ALTA_TENSAO;
    end

    if (bit2 & bit1 & bit0) begin
      seguimento0 <= ALTA_TENSAO;
      seguimento1 <= ALTA_TENSAO;
      seguimento2 <= ALTA_TENSAO;
      seguimento3 <= BAIXA_TENSAO;
      seguimento4 <= BAIXA_TENSAO;
      seguimento5 <= BAIXA_TENSAO;
      seguimento6 <= BAIXA_TENSAO;
    end

  SEG[0] <= seguimento0;
  SEG[1] <= seguimento1;
  SEG[2] <= seguimento2;
  SEG[3] <= seguimento3;
  SEG[4] <= seguimento4;
  SEG[5] <= seguimento5;
  SEG[6] <= seguimento6;

  SEG[7] <= SWI[7];
  end
endmodule