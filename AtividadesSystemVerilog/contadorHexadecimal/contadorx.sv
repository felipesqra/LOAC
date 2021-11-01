// Pedro Lucas Siqueira de Lima
// Contador de 0-15 com representação em números binários e hexadecimais
// Atenção: Aguardar a contagem iniciar.
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
    lcd_a <= {56'h1234567890ABCD, SWI};
    lcd_b <= {SWI, 56'hFEDCBA09876543};
 end

  parameter ZERO = 'b000111111;
  parameter UM = 'b00000110;
  parameter DOIS = 'b01011011;
  parameter TRES = 'b01001111;
  parameter QUATRO = 'b01100110;
  parameter CINCO = 'b01101101;
  parameter SEIS = 'b01111101;
  parameter SETE = 'b00000111;
  parameter OITO = 'b01111111;
  parameter NOVE = 'b01101111;
  parameter DEZ = 'b01110111;
  parameter ONZE = 'b01111111;
  parameter DOZE = 'b00111001;
  parameter TREZE ='b00111111;
  parameter QUATORZE = 'b01111001;
  parameter QUINZE = 'b01110001;

  logic [NBITS_TOP-1:0] contador;
  logic [1:0] reset;

  always_comb begin
	  reset <= SWI[0];
  end

  always_ff @(posedge clk_2) begin
	  if(reset) contador <= 0;
	  else if(contador > 14) contador <= 0;
	  else contador <= contador + 1;
 end

 always_comb begin
 	  LED[7:0] <= contador; 
	  unique case(contador)
		 0 : SEG <= ZERO;
		 1 : SEG <= UM;
		 2 : SEG <= DOIS;
		 3 : SEG <= TRES;
		 4 : SEG <= QUATRO;
		 5 : SEG <= CINCO;
		 6 : SEG <= SEIS;
		 7 : SEG <= SETE;
		 8 : SEG <= OITO;
		 9 : SEG <= NOVE;
		 10: SEG <= DEZ;
		 11: SEG <= ONZE;
		 12: SEG <= DOZE;
		 13: SEG <= TREZE;
		 14: SEG <= QUATORZE;
		 15: SEG <= QUINZE;
	 endcase
end
endmodule