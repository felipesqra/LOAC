// Pedro Lucas Siqueira de Lima
// Questões de lógica combinatória com todas as alternativas rodando de forma simultânea

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

  // Questao 1: EXPEDIENTE
  logic[1:0] eh_noite;
  logic[1:0] maq_paradas;
  logic[1:0] eh_sexta;
  logic[1:0] producao_finalizada;
  parameter ON = 1;
  parameter OFF = 0;

  always_comb begin
	  eh_noite <= SWI[4];
	  maq_paradas <= SWI[5];
	  eh_sexta <= SWI[6];
	  producao_finalizada <= SWI[7];
	  if ((eh_noite && maq_paradas) || (eh_sexta && producao_finalizada && maq_paradas)) LED[2] <= ON;
	  else LED[2] <= OFF;
  end

  // Questao 2: AGENCIA BANCARIA
  logic[1:0] porta_cofre;
  logic[1:0] em_expediente;
  logic[1:0] interruptor;
  
  always_comb begin
	  porta_cofre <= SWI[0];
	  em_expediente <= SWI[1];
	  interruptor <= SWI[2];
	  if(em_expediente && !interruptor) SEG[0] <= OFF;
	  else SEG[0] <= ON;	 
  end

  // Questao 3: ESTUFA
  logic[1:0] temp_maior_igual_15;
  logic[1:0] temp_maior_igual_20;
  always_comb begin
	  temp_maior_igual_15 <= SWI[3];
	  temp_maior_igual_20 <= SWI[4];
	  if(!temp_maior_igual_15 && temp_maior_igual_20) 
	  begin
		  SEG[7] <= ON;
		  LED[6] <= OFF;
		  LED[7] <= OFF;
	  end
	  else if(!temp_maior_igual_20 && !temp_maior_igual_15)
	  begin
		  SEG[7] <= OFF;
		  LED[6] <= ON;
		  LED[7] <= OFF;
	  end
	  else if(temp_maior_igual_20 && temp_maior_igual_15)
	  begin
		  SEG[7] <= OFF;
		  LED[6] <= OFF;
		  LED[7] <= ON;
	  end
	  else
	  begin
		  SEG[7] <= OFF;
		  LED[6] <= OFF;
		  LED[7] <= OFF;
	  end
  end	 

  // Questao 4: AERONAVES
  logic[1:0] lavatorio_1;
  logic[1:0] lavatorio_2;
  logic[1:0] lavatorio_3;
  logic[1:0] livre_mulheres;
  logic[1:0] livre_homens;
  always_comb begin
	  lavatorio_1 <= SWI[0];
	  lavatorio_2 <= SWI[1];
	  lavatorio_3 <= SWI[2];
	  livre_homens <= !(lavatorio_3 && lavatorio_2);
	  livre_mulheres <= !(lavatorio_1 && lavatorio_2 && lavatorio_3);
	  if(livre_homens) LED[1] <= ON;
	  else LED[1] <= OFF;

	  if(livre_mulheres) LED[0] <= ON;
	  else LED[0] <= OFF;
  end
endmodule