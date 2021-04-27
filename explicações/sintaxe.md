- SWI significa switch, quando defino por exemplo:
  
  '''variável <= SWI[0]'''

signiffica que eu estou atribuindo o switch 0 à variável.

- o switch de número zero representa o switch mais à direita, a indexação deles é diferente (o contrário) do que se vê em arrays nas linguagens de programação.

- logic: escrevo antes de definir quais serão as variáveis utilizadas
no meu programa, por exemplo:
  
  '''logic variavel1;
  logic variavel2;
  logic variavel3;'''

  ou

  '''logic variavel1, variavel2, variavel3;'''

- Em todos os exercícios da disciplina utilizei as seguintes linhas de código logo nas primeiras linhas:

      '''parameter NINSTR_BITS = 32;
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
                output logic lcd_MemWrite, lcd_Branch, lcd_MemtoReg, lcd_RegWrite);'''

    É algo padrão e que não entendi muito bem, mas pelo menos de início, sei que o significado de cada item pode ser ignorado, portanto não é preciso dedicar muito tempo ao entendimento desse trecho do código.