//Felipe de Souza Siqueira
//Semáforo, ideia original
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
  O circuito representa um semáforo que mostra no display as seguintes informações:
  P - Pare SWI[0]
  A - Atenção SWI[1]
  S - Siga SWI[2]

  O circuito demonstra ainda que há uma inconsistência nas informações caso mais de uma
  informação seja acionada ao mesmo tempo.

  SEG[7] - Inconsistência
*/

  logic pare, atencao, siga, inconsistencia, seguimento0, seguimento1, seguimento2, seguimento3, seguimento4, seguimento5, seguimento6;

  parameter ALTA_TENSAO=1, BAIXA_TENSAO=0;
  // Entradas
  always_comb begin
    pare <= SWI[0];
    atencao <= SWI[1];
    siga <= SWI[2];
  end

  // Lógica
  always @(*) begin

    if (pare & (atencao | siga) | atencao & (pare | siga))
      inconsistencia <= ALTA_TENSAO;
    else
      inconsistencia <= BAIXA_TENSAO;
    
    if (pare) begin
      seguimento0 <= ALTA_TENSAO;
      seguimento1 <= ALTA_TENSAO;
      seguimento2 <= BAIXA_TENSAO;
      seguimento3 <= BAIXA_TENSAO;
      seguimento4 <= ALTA_TENSAO;
      seguimento5 <= ALTA_TENSAO;
      seguimento6 <= ALTA_TENSAO;
    end

    else if (atencao) begin
      seguimento0 <= ALTA_TENSAO;
      seguimento1 <= ALTA_TENSAO;
      seguimento2 <= ALTA_TENSAO;
      seguimento3 <= BAIXA_TENSAO;
      seguimento4 <= ALTA_TENSAO;
      seguimento5 <= ALTA_TENSAO;
      seguimento6 <= ALTA_TENSAO;
    end

    else if (siga) begin
      seguimento0 <= ALTA_TENSAO;
      seguimento1 <= BAIXA_TENSAO;
      seguimento2 <= ALTA_TENSAO;
      seguimento3 <= ALTA_TENSAO;
      seguimento4 <= BAIXA_TENSAO;
      seguimento5 <= ALTA_TENSAO;
      seguimento6 <= ALTA_TENSAO;
    end

  // Saídas
  SEG[0] <= seguimento0;
  SEG[1] <= seguimento1;
  SEG[2] <= seguimento2;
  SEG[3] <= seguimento3;
  SEG[4] <= seguimento4;
  SEG[5] <= seguimento5;
  SEG[6] <= seguimento6;

  SEG[7] <= inconsistencia;
  end
endmodule