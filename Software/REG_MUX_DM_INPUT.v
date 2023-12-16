module REG_MUX_DM_INPUT(
  input [15:0] X,
  input [15:0] Y,
  input [15:0] ACC,
  input [15:0] PC,
  input SEL_X,SEL_Y,SEL_ACC,SEL_PC,STORE,
  output reg [15:0] IN
);

always @(*) begin
  if (STORE && SEL_X)
    IN <= X;
  else if (STORE && SEL_Y)
    IN <= Y;
  else if (STORE && SEL_ACC)
    IN <= ACC; 
  else if (STORE && SEL_PC)
    IN <= PC;
end

endmodule

