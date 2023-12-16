module REG_MUX_DM_ADDR(
  input LOAD,STORE,PUSH,POP,
  input [8:0] SP,
  input [8:0] IMMEDIATE,
  output reg [8:0] IN
);

always @(*) begin
  if ((LOAD || STORE) && ~(PUSH || POP))
    IN <= IMMEDIATE;
  else if (PUSH || POP)
    IN <= SP;
end

endmodule


