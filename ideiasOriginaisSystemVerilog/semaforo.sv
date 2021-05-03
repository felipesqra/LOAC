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

  logic pare, atencao, siga;


  parameter ALTA_TENSAO=1, BAIXA_TENSAO=0, ATIVO=0;
  // Entradas
  always_comb begin
    pare <= SWI[0];
    atencao <= SWI[1];
    siga <= SWI[2];


    if (pare & (atencao | siga) | atencao & (pare | siga))
      SEG[7:0]  <= 8'b11111111;
  
    else if(pare) begin
      //PARE
      SEG[7:0] <= 8'b01110011; 
    end

    else if(atencao) begin
      // ATENÇÃO
      SEG[7:0] <= 8'b01110111; 
    end
    
    else if(siga) begin
      // SIGA
      SEG[7:0]  <= 8'b01101101;
    end

    else begin
      SEG[7:0]  <= 8'b00000000;
    end

  end
endmodule
