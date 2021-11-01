// Pedro Lucas Siqueira de Lima
// Jogo da memória com números hexadecimais!
// Como funciona: o lcd_a mostra 4 números de 0-F. Ao apertar SWI[0], o lcd_a
// é zerado, e o desafio é descobrir a soma dos últimos 4 números que foram mostrados, e colocar ela em
// binário no SWI[6:1]. Caso esteja correto, o SEG acende todos os
// seguimentos, caso esteja errado, só acende o ponto.
// Atenção: Aguardar o relógio iniciar a contagem, é possível deixar o jogo
// mais difícil aumentando a velocidade do relógio.

parameter divide_by=1000000;  // divisor do clock de referência
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

  parameter zerado=0;
  logic [1:0] zero;
  logic [3:0] contadorUm;
  logic [3:0] contadorDois;
  logic [3:0] contadorTres;
  logic [3:0] contadorQuatro;
  logic [5:0] resultado;
  logic [5:0] soma;
  logic [1:0] parar;
  
  always_comb begin
	  parar <= SWI[0];
	  soma <= SWI[6:1];
  end
  always_ff @(posedge clk_2) begin
	  lcd_a <= {contadorUm, contadorDois, contadorTres, contadorQuatro};
	  if(!parar)
	  	resultado <= (contadorUm+contadorDois+contadorTres+contadorQuatro);
	  if(!parar) begin
	 	contadorUm <= contadorUm + 1;
	  	contadorDois <= contadorDois + 2;
	  	contadorTres <= contadorTres + 3;
	  	contadorQuatro <= contadorQuatro + 4;
	  	
 	  end
	  else begin	 
		 zero <= 0;
		 lcd_a <= {zero, zero, zero, zero};
		 if(resultado == soma) SEG[7:0] <= 'b11111111;
		 else SEG[7:0] <= 'b10000000;
	 end
 end
endmodule