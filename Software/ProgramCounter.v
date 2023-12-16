module ProgramCounter(
  input CLK,RST,EN,BRA,POP,FACT,
  input [15:0] IN,
  output reg [15:0] OUT
);

always @(negedge CLK, negedge RST) 
begin
  if (~RST) 
  begin
    OUT <= 16'd0;
  end
  else if (POP && EN) 
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