//Felipe de Souza Siqueira
//As aeronaves, 4 questão da lista: http://lad.ufcg.edu.br/loac/index.php?n=OAC.Comb
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

As aeronaves normalmente possuem um sinal luminoso que indica se tem lavatório (banheiro) desocupado. 
Suponha que um avião tenha três lavatórios. Cada lavatório possui um sensor que produz nível 1 em sua 
saída quando a porta do lavatório está trancada e 0, caso contrário. O primeiro lavatório é exclusivamente para mulheres. 
Projete um circuito que informa a disponibilidade de lavatório. Use as chaves SWI[0], SWI[1], e SWI[2] como 
sensores de tranca das respectivas portas. A luz de sinalização que informa se tem algum lavatório livre para mulheres é o LED[0]. 
A luz de sinalização que informa se tem algum lavatório livre para homens é o LED[1].

---- Anotação pessoal: 1 para porta trancada e 0 para porta destrancada. São 3 portas no total e portanto, 3 switches.
---- Anotação pessoal: LED[0] é o banheiro das mulheres, LED[1] dos homens, LED[2] não é especificado.

*/

logic banheiroFeminino, banheiroMasculino, banheiroAmbos, ledFeminino, ledMasculino, ledAmbos;

always_comb begin
  banheiroFeminino <= SWI[0];
  banheiroMasculino <= SWI[1];
  banheiroAmbos <= SWI[2];

  // lógica

  ledFeminino <= banheiroFeminino;
  ledMasculino <= banheiroMasculino;
  ledAmbos <= banheiroAmbos;

  // Saída

  LED[0] <= ledFeminino;
  LED[1] <= ledMasculino;
  LED[2] <= ledAmbos;


end

