module ProgramCounter(
  input CLK,RESET,EN,BRA,STACK_POP,FACT,
  input [15:0] IN,
  output reg [15:0] OUT
);

always @(negedge CLK, negedge RESET) 
begin
  if (~RESET) 
  begin
    OUT <= 16'd0;
  end
  else if (STACK_POP && EN) 
  begin 
    OUT <= IN + 16'd2;
  end
  else if (BRA && EN) 
  begin
    OUT <= IN;
  end
  else if (!FACT) 
  begin
    OUT <= OUT + 16'd1;
  end
end

endmodule