// Felipe de Souza Siqueira
// circuito meio somador


module halfAdder(
  input logic a, b,
  output logic sum, carry
);

  always_comb sum <= a ^ b;

  always_comb carry <= a & b;
    
endmodule