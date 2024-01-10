module FACTORIAL_tb;
reg [8:0] VAL;
reg CLK, RST, FACT;
wire [15:0] ALU;
wire [3:0] ALU_FLAGS;
wire FACT_END;

ALU ArithmeticLogicUnit(.ACC(16'd0),.X(16'd0),.Y(16'd0),.IMMEDIATE(16'd0),.fact_reg(instantaFACTORIAL.FACT_OUT),.fact_val({ {7{1'b0}}, instantaFACTORIAL.CURRENT_ITERATION[8:0] }),.OPCODE(6'b011000),.EN(1'd1),.CLK(CLK),.RST(RST),.REGISTER_ADDRESS(1'd0),.res(ALU), .flags(ALU_FLAGS));
FACTORIAL instantaFACTORIAL(.VAL(VAL), .CLK(CLK), .RST(RST), .FACT(FACT), .ALU(ALU), .FACT_END(FACT_END));

initial begin
  VAL = 9'd5;
  CLK = 1'd0;
  RST = 1'd0;
  FACT = 1'd1;
  #15
  RST = 1'd1;
  #5
  test_FACT_ITERATION_1;
  test_FACT_ITERATION_2;
  test_FACT_ITERATION_3;
  test_FACT_ITERATION_4;
  

end

task test_FACT_ITERATION_1;
begin
  #10 CLK = 1'd1;
  $write(" FACT_ITERATION_1 \t");
  #2
  if (ALU == 16'd5)
    $write("passed");
  else
	$write("error @ %t , get %d, expect %d", $time, ALU, 16'd5);
	$write("\n");
	#10 CLK = 1'd0;
end
endtask

task test_FACT_ITERATION_2;
begin
  #10 CLK = 1'd1;
  $write(" FACT_ITERATION_2 \t");
  #2
  if (ALU == 16'd20)
    $write("passed");
  else
	$write("error @ %t , get %d, expect %d", $time, ALU, 16'd20);
	$write("\n");
	#10 CLK = 1'd0;
end
endtask


task test_FACT_ITERATION_3;
begin
  #10 CLK = 1'd1;
  $write(" FACT_ITERATION_3 \t");
  #2
  if (ALU == 16'd60)
    $write("passed");
  else
	$write("error @ %t , get %d, expect %d", $time, ALU, 16'd60);
	$write("\n");
	#10 CLK = 1'd0;
end
endtask



task test_FACT_ITERATION_4;
begin
  #10 CLK = 1'd1;
  $write(" FACT_ITERATION_4 \t");
  #2
  if (ALU == 16'd120)
    $write("passed");
  else
	$write("error @ %t , get %d, expect %d", $time, ALU, 16'd120);
	$write("\n");
	#10 CLK = 1'd0;
end
endtask

endmodule
