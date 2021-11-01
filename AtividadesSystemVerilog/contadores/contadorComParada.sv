// Pedro Lucas Siqueira de Lima
// contador 4 bits com reset SWI[0], contagem decrescente SWI[1],
// contagem com incremento de 3 SWI[2], contagem com congelamento SWI[3],
// contagem com saturação SWI[4].
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

  logic[1:0] zerado=0;
  logic [3:0] contador;
  logic [1:0] reset;
  logic [1:0] decrescente;
  logic [1:0] inc3;
  logic [1:0] congela;
  logic [1:0] saturacao;
  
  
  
  always_comb begin
	  reset <= SWI[0];
	  zerado <= 0;
	  decrescente <= SWI[1];
	  inc3 <= SWI[2];
	  congela <= SWI[3];
	  saturacao <= SWI[4];
  end
  always_ff @(posedge clk_2) begin
         if(reset) begin
          contador <= zerado;
  	 end else if(saturacao && (contador > 14 || contador <1)) 		begin
		 contador <= contador;
	 end else if(!congela) begin
         	if(!inc3) begin
                	if(decrescente) begin
                		 contador <= contador - 1;
                	end else begin
                	 contador <= contador + 1;
                	end
         	end else begin
         		if(decrescente) begin
         			contador <= contador - 3;
         		end else begin
         			 contador <= contador + 3;
         		end
         	end
	end
  end 
  always_comb begin
	lcd_a <= contador;
  end 
 endmodule