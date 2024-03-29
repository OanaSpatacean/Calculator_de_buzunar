module FACTORIAL(
  input [8:0] VAL,
  input CLK, RST, FACT, 
  input [15:0] ALU,
  output reg FACT_END
  );

wire [8:0] CURRENT_ITERATION;
wire [15:0] FACT_OUT;
wire FACT_END_CNT;
FACT_CNT COUNTER(.CNT(VAL),.CLK(CLK),.RST(RST), .EN(~(| CURRENT_ITERATION) & FACT), .OUT(CURRENT_ITERATION), .FACT_END(FACT_END_CNT));
FACT_REG FACTREG(.IN(ALU),.CLK(CLK),.RST(RST & (| CURRENT_ITERATION)),.EN(~FACT_END & (| CURRENT_ITERATION)),.OUT(FACT_OUT));


always @(*) begin
    FACT_END = FACT_END_CNT;
end
endmodule
