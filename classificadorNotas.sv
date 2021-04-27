//Felipe de Souza Siqueira
//Classificador de notas, exercíicio disponível no link: http://lad.ufcg.edu.br/loac/index.php?n=OAC.Seg7
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

/* 
  Anotação pessoal: O usuário irá informar a nota do aluno em binários, que pode
variar de 1 a 9, necessitando assim de 4 bits para formar todas as possibilidades
*/
logic bit0, bit1, bit2, bit3, opcao;
logic seguimento0, seguimento1, seguimento2, seguimento3, seguimento4, seguimento5, seguimento6;

always_comb begin
  // Definindo variáveis
  bit0 <= SWI[0];
  bit1 <= SWI[1];
  bit2 <= SWI[2];
  bit3 <= SWI[3];
  opcao <= SWI[7];
end

always @(*) begin

  if (opcao) begin
    // Usuário deseja mostrar situação do aluno
    seguimento0 <= 1;
    seguimento1 <= ~(~bit3 & bit2 & ~(bit1 & bit0));
    seguimento2 <= (bit3 | (bit0 & bit1 & bit2));
    // Anotação pessoal: O seguimento 3 deve estar sempre desligado
    seguimento3 <= 0;
    seguimento4 <= 1;
    seguimento5 <= 1;
    seguimento6 <= 1;  
  end

  else begin
    // O usuário deseja mostrar a nota do aluno

    if (~bit3 & ~bit2 & ~bit1 & ~bit0) begin
      // zero

      seguimento0 <= 1;
      seguimento1 <= 1;
      seguimento2 <= 1;
      seguimento3 <= 1;
      seguimento4 <= 1;
      seguimento5 <= 1;
      seguimento6 <= 0;
    end

    if (~bit3 & ~bit2 & ~bit1 & bit0) begin
      // um

      seguimento0 <= 0;
      seguimento1 <= 1;
      seguimento2 <= 1;
      seguimento3 <= 0;
      seguimento4 <= 0;
      seguimento5 <= 0;
      seguimento6 <= 0;

    end

    if (~bit3 & ~bit2 & bit1 & ~bit0) begin
      // dois

      seguimento0 <= 1;
      seguimento1 <= 1;
      seguimento2 <= 0;
      seguimento3 <= 1;
      seguimento4 <= 1;
      seguimento5 <= 0;
      seguimento6 <= 1;

    end

    if (~bit3 & ~bit2 & bit1 & bit0) begin
      // tres

      seguimento0 <= 1;
      seguimento1 <= 1;
      seguimento2 <= 1;
      seguimento3 <= 1;
      seguimento4 <= 0;
      seguimento5 <= 0;
      seguimento6 <= 1;

    end

    if (~bit3 & bit2 & ~bit1 & ~bit0) begin
      // quatro

      seguimento0 <= 0;
      seguimento1 <= 1;
      seguimento2 <= 1;
      seguimento3 <= 0;
      seguimento4 <= 0;
      seguimento5 <= 1;
      seguimento6 <= 1;

    end

    if (~bit3 & bit2 & ~bit1 & bit0) begin
      // cinco

      seguimento0 <= 1;
      seguimento1 <= 0;
      seguimento2 <= 1;
      seguimento3 <= 1;
      seguimento4 <= 0;
      seguimento5 <= 1;
      seguimento6 <= 1;

    end

    if (~bit1 & bit2 & bit1 & ~bit0) begin
      // seis

      seguimento0 <= 1;
      seguimento1 <= 0;
      seguimento2 <= 1;
      seguimento3 <= 1;
      seguimento4 <= 1;
      seguimento5 <= 1;
      seguimento6 <= 1;

    end

    if (~bit3 & bit2 & bit1 & bit0) begin
      // sete

      seguimento0 <= 1;
      seguimento1 <= 1;
      seguimento2 <= 1;
      seguimento3 <= 0;
      seguimento4 <= 0;
      seguimento5 <= 0;
      seguimento6 <= 0;

    end

    if (bit3 & ~bit2 & ~bit1 & ~bit0) begin
      // oito

      seguimento0 <= 1;
      seguimento1 <= 1;
      seguimento2 <= 1;
      seguimento3 <= 1;
      seguimento4 <= 1;
      seguimento5 <= 1;
      seguimento6 <= 1;

    end

    if (bit3 & ~bit2 & ~bit1 & bit0) begin
      // nove

      seguimento0 <= 1;
      seguimento1 <= 1;
      seguimento2 <= 1;
      seguimento3 <= 0;
      seguimento4 <= 0;
      seguimento5 <= 1;
      seguimento6 <= 1;

    end
  end


// Saída

SEG[0] <= seguimento0;
SEG[1] <= seguimento1;
SEG[2] <= seguimento2;
SEG[3] <= seguimento3;
SEG[4] <= seguimento4;
SEG[5] <= seguimento5;
SEG[6] <= seguimento6;
end
endmodule

