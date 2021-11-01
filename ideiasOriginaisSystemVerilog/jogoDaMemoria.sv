// Pedro Lucas Siqueira de Lima
// JOGO DA >MEMÓRIA< COM BINARIO NO LED
// Como funciona: o LED mostra um número em binário, representado por luzes amarelas. Ao apertar SWI[0], o LED
// é travado e fica em 0. O desafio é conseguir lembrar da posição dos riscos amarelos e fazer o SWI[6:1] ficar com o mesmo valor em binário. Caso esteja correto, o SEG acende todos os
// seguimentos, caso esteja errado, só acende o ponto.
parameter divide_by=100000000;  // divisor do clock de referência
// A frequencia do clock de referencia é 50 MHz.
// A frequencia de clk_2 será de  50 MHz / divide_by

parameter NBITS_INSTR = 32;
parameter NBITS_TOP = 8, NREGS_TOP = 32, NBITS_LCD = 64;
module top(input  logic clk_2,
           input  logic [NBITS_TOP-1:0] SWI,
           output logic [NBITS_TOP-1:0] LED,
           output logic [NBITS_TOP-1:0] SEG,
           output logic [NBITS_LCD-1:0] lcd_a, lcd_b,
           output logic [NBITS_INSTR-1:0] lcd_instruction,
           output logic [NBITS_TOP-1:0] lcd_registrador [0:NREGS_TOP-1],
           output logic [NBITS_TOP-1:0] lcd_pc, lcd_SrcA, lcd_SrcB,
             lcd_ALUResult, lcd_Result, lcd_WriteData, lcd_ReadData, 
           output logic lcd_MemWrite, lcd_Branch, lcd_MemtoReg, lcd_RegWrite);

  always_comb begin
    lcd_WriteData <= SWI;
    lcd_pc <= 'h12;
    lcd_instruction <= 'h34567890;
    lcd_SrcA <= 'hab;
    lcd_SrcB <= 'hcd;
    lcd_ALUResult <= 'hef;
    lcd_Result <= 'h11;
    lcd_ReadData <= 'h33;
    lcd_MemWrite <= SWI[0];
    lcd_Branch <= SWI[1];
    lcd_MemtoReg <= SWI[2];
    lcd_RegWrite <= SWI[3];
    for(int i=0; i<NREGS_TOP; i++)
       if(i != NREGS_TOP/2-1) lcd_registrador[i] <= i+i*16;
       else                   lcd_registrador[i] <= ~SWI;
 end

  logic [3:0] contadorUm;
  logic [3:0] contadorDois;
  logic [3:0] contadorTres;
  logic [3:0] contadorQuatro;
  logic [5:0] resultado;
  logic [5:0] soma;
  logic [1:0] reset;
  
  always_comb begin
	  reset <= SWI[0];
	  soma <= SWI[6:1];
  end
  always_ff @(posedge clk_2) begin 
  	  if(!reset) begin
  	   	  resultado <= (contadorUm+contadorDois+contadorTres+contadorQuatro);
 	  	contadorUm <= contadorUm + 1;
	  	contadorDois <= contadorDois + 2;
	  	contadorTres <= contadorTres + 3;
	  	contadorQuatro <= contadorQuatro + 4;
 	  end 
 end
 always_comb begin
   	if(reset) LED <= 0;
  	else LED <= resultado;
  	if(reset && resultado == soma) SEG <= 'b11111111;
  	else SEG <= 'b10000000;
 end
endmodule