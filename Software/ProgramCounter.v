module ProgramCounter(
  input CLK,RESET,w,BRA,STACK_POP,FACT,
  input [15:0] in,
  output reg [15:0] out
);

always @(negedge CLK, negedge RESET) 
begin
  if (~RESET) 
  begin
    out <= 16'd0;
  end
  else if (STACK_POP && w) 
  begin 
    out <= in + 16'd2;
  end
  else if (BRA && w) 
  begin
    out <= in;
  end
  else if (!FACT) 
  begin
    out <= out + 16'd1;
  end
end

endmodule