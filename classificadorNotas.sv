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
           output logic lcd_MemWrite, lcd_Branch, lcd_MemtoReg, lcd_RegWrite
          );

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

logic bit0, bit1, bit2, bit3, opcao;

always_comb begin
  
  bit0 <= SWI[0];
  bit1 <= SWI[1];
  bit2 <= SWI[2];
  bit3 <= SWI[3];
  opcao <= SWI[7];

  logic seguimento0, seguimento1, seguimento2, seguimento3, seguimento4, seguimento5, seguimento6;

  if (opcao) begin
    // Usuário deseja mostrar situação do aluno
    seguimento0 <= 1;
    seguimento1 <= ~(~bit_quatro & bit_tres & ~(bit_dois & bit_um));
    seguimento2 <= (bit_quatro | (bit_um & bit_dois & bit_tres));
    // Anotação pessoal: O seguimento 3 deve estar sempre desligado
    seguimento3 <= 0;
    seguimento4 <= 1;
    seguimento5 <= 1;
    seguimento6 <= 1;  
  end

  else begin
    // O usuário deseja mostrar a nota do aluno

    if (~bit_quatro & ~bit_tres & ~bit_dois & ~bit_um) begin
      // zero
      zero <= 1;
      um <= 1;
      dois <= 1;
      tres <= 1;
      quatro <= 1;
      cinco <= 1;
      seis <= 0;
    end

    if (~bit_quatro & ~bit_tres & ~bit_dois & bit_um) begin
      // um
      zero <= 0;
      um <= 1;
      dois <= 1;
      tres <= 0;
      quatro <= 0;
      cinco <= 0;
      seis <= 0;
    end

    if (~bit_quatro & ~bit_tres & bit_dois & ~bit_um) begin
      // dois
      zero <= 1;
      um <= 1;
      dois <= 0;
      tres <= 1;
      quatro <= 1;
      cinco <= 0;
      seis <= 1;
    end

    if (~bit_quatro & ~bit_tres & bit_dois & bit_um) begin
      // tres
      zero <= 1;
      um <= 1;
      dois <= 1;
      tres <= 1;
      quatro <= 0;
      cinco <= 0;
      seis <= 1;
    end

    if (~bit_quatro & bit_tres & ~bit_dois & ~bit_um) begin
      // quatro
      zero <= 0;
      um <= 1;
      dois <= 1;
      tres <= 0;
      quatro <= 0;
      cinco <= 1;
      seis <= 1;
    end

    if (~bit_quatro & bit_tres & ~bit_dois & bit_um) begin
      // cinco
      zero <= 1;
      um <= 0;
      dois <= 1;
      tres <= 1;
      quatro <= 0;
      cinco <= 1;
      seis <= 1;
    end

    if (~bit_quatro & bit_tres & bit_dois & ~bit_um) begin
      // seis
      zero <= 1;
      um <= 0;
      dois <= 1;
      tres <= 1;
      quatro <= 1;
      cinco <= 1;
      seis <= 1;
    end

    if (~bit_quatro & bit_tres & bit_dois & bit_um) begin
      // sete
      zero <= 1;
      um <= 1;
      dois <= 1;
      tres <= 0;
      quatro <= 0;
      cinco <= 0;
      seis <= 0;
    end

    if (bit_quatro & ~bit_tres & ~bit_dois & ~bit_um) begin
      // oito
      zero <= 1;
      um <= 1;
      dois <= 1;
      tres <= 1;
      quatro <= 1;
      cinco <= 1;
      seis <= 1;
    end

    if (bit_quatro & ~bit_tres & ~bit_dois & bit_um) begin
      // nove
      zero <= 1;
      um <= 1;
      dois <= 1;
      tres <= 0;
      quatro <= 0;
      cinco <= 1;
      seis <= 1;
    end
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

endmodule

