// Felipe de Souza Siqueira
// Circuito meio somador
// 119110399

module halfAdder(
  input logic a, b,
  output logic sum, carry
);

  always_comb begin
    sum <= a ^ b;
    carry <= a & b;
  end
    
endmodule