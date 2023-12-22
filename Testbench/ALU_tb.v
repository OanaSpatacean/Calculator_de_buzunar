module ALU_tb;
// Inputs
reg signed [15:0] ACC,X,Y,IMMEDIATE;
reg [15:0] fact_reg, fact_val;
reg [5:0] OPCODE;
reg EN,CLK,RST,REGISTER_ADDRESS;

//Outputs
wire signed [15:0] res;
wire [3:0] flags;

// Instantiate the Unit Under Test (UUT)
ALU ArithmeticLogicUnit(.ACC(ACC), .X(X), .Y(Y), .IMMEDIATE(IMMEDIATE), .fact_reg(fact_reg), .fact_val(fact_val), .OPCODE(OPCODE), .EN(EN), .CLK(CLK), .RST(RST), .REGISTER_ADDRESS(REGISTER_ADDRESS), .res(res), .flags(flags));

initial begin
		// Initialize Inputs
		OPCODE = 6'd0;
		CLK = 1'd0;
		RST = 1'd0;
		IMMEDIATE = 16'd0;
		REGISTER_ADDRESS = 1'd0;
		EN = 1'd0;
		ACC = 16'd0;
		// Wait 30 ns for global reset to finish
		#30;
		RST = 1'd1;
		EN = 1'd1;
		// Add stimulus here
		#5
		test_ADD_X;
		test_ADD_Y;
		test_ADD_Y_OVERFLOW;
		test_ADD_Y_ZERO_AND_CARRY;
		test_ADD_Y_NEGATIVE;
		test_ADD_X_Immediate;
		test_ADD_Y_Immediate;
		test_SUB_X;
		test_SUB_Y_OVERFLOW;
		test_SUB_Y_ZERO;
		test_SUB_Y_NEGATIVE;
		test_SUB_X_Immediate;
		test_SUB_Y_Immediate;

			
	
end

task test_ADD_X;
begin
  #10 CLK = 1'd1;
  $write(" ALU_ADD_X \t");
  OPCODE = 6'b000111;
  IMMEDIATE = 16'd0;
  X = 16'd6;
  REGISTER_ADDRESS = 1'd0;
  #2
  if (res == 16'd6)
	$write("passed");
  else
	$write("error @ %t , get %d, expect %d", $time, res, 16'd5);
	$write("\n");
	#10 CLK = 1'd0;
end
endtask

task test_ADD_Y;
begin
  #10 CLK = 1'd1;
  $write(" ALU_ADD_Y \t");
  OPCODE = 6'b000111;
  IMMEDIATE = 16'd0;
  ACC = 16'd2;
  Y = 16'd14;
  REGISTER_ADDRESS = 1'd1;
  #2
  if (res == 16'd16)
	$write("passed");
  else
	$write("error @ %t , get %d, expect %d", $time, res, 16'd16);
	$write("\n");
	#10 CLK = 1'd0;
end
endtask

task test_ADD_Y_OVERFLOW;
begin
  #10 CLK = 1'd1;
  $write(" ALU_ADD_Y_OVERFLOW\t");
  OPCODE = 6'b000111;
  IMMEDIATE = 16'd0;
  ACC = 16'b0111111111111110;
  Y = 16'd2;
  REGISTER_ADDRESS = 1'd1;
  #2
  if (res == 16'b1000000000000000 && flags[0] == 1'd1)
    $write("passed");
  else
	$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[0], 16'b1000000000000000, 1'd1);
	$write("\n");
	#10 CLK = 1'd0;
end
endtask


task test_ADD_Y_ZERO_AND_CARRY;
begin
  #10 CLK = 1'd1;
  $write(" ALU_ADD_Y_ZERO_AND_CARRY \t");
  OPCODE = 6'b000111;
  IMMEDIATE = 16'd0;
  ACC = 16'b0000000000000011;
  Y = 16'b1111111111111101;
  REGISTER_ADDRESS = 1'd1;
  #2
  if (res == 16'b0000000000000000 && flags[1] == 1'd1 && flags[3] == 1'd1)
	$write("passed");
  else
	$write("error @ %t , get %d %d %d, expect %d %d %d", $time, res, flags[1], flags[3], 16'b0000000000000000, 1'd1, 1'd1);
	$write("\n");
	#10 CLK = 1'd0;
end
endtask


task test_ADD_Y_NEGATIVE;
begin
  #10 CLK = 1'd1;
  $write(" ALU_ADD_Y_NEGATIVE \t");
  OPCODE = 6'b000111;
  IMMEDIATE = 16'd0;
  ACC = 16'b0000000000000011;
  Y = 16'b1111111111111100;
  REGISTER_ADDRESS = 1'd1;
  #2
  if (res == 16'b1111111111111111 && flags[2] == 1'd1)
	$write("passed");
  else
	$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[2], 16'b11111111111111111, 1'd1);
	$write("\n");
	#10 CLK = 1'd0;
end
endtask

task test_ADD_X_Immediate;
begin
  #10 CLK = 1'd1;
  $write(" ALU_ADD_X_Immediate \t");
  OPCODE = 6'b000111;
  IMMEDIATE = 16'b0101010101010101;
  X = 16'b0010101010101010;
  REGISTER_ADDRESS = 1'd0;
  #2
  if (res == X + IMMEDIATE)
    $write("passed");
  else
	$write("error @ %t , get %d, expect %d", $time, res, X+IMMEDIATE);
	$write("\n");
	#10 CLK = 1'd0;
end
endtask


task test_ADD_Y_Immediate;
begin
  #10 CLK = 1'd1;
  $write(" ALU_ADD_Y_Immediate \t");
  OPCODE = 6'b000111;
  IMMEDIATE = 16'b1111100000111110;
  Y = 16'b1000001111000000;
  REGISTER_ADDRESS = 1'd1;
  #2
  if (res == Y + IMMEDIATE)
 	$write("passed");
  else
	$write("error @ %t , get %d, expect %d", $time, res, Y+IMMEDIATE);
	$write("\n");
	#10 CLK = 1'd0;
end
endtask

task test_SUB_X;
begin
  #10 CLK = 1'd1;
  $write(" ALU_SUB_X \t");
  OPCODE = 6'b001000;
  IMMEDIATE = 16'd0;
  ACC = 16'b0011111111111111;
  X = 16'b0000000000111000;
  REGISTER_ADDRESS = 1'd0;
  #2
  if (res == ACC - X)
    $write("passed");
  else
	$write("error @ %t , get %d, expect %d", $time, res, ACC - X);
	$write("\n");
	#10 CLK = 1'd0;
end
endtask

task test_SUB_Y_OVERFLOW;
begin
  #10 CLK = 1'd1;
  $write(" ALU_SUB_Y_OVERFLOW\t");
  OPCODE = 6'b001000;
  IMMEDIATE = 16'd0;
  ACC = 16'b1111111111110011;
  Y = 16'b1000000000000001;
  REGISTER_ADDRESS = 1'd1;
  #2
  if (res == ACC - Y && flags[0] == 1'd1)
    $write("ok ");
  else
		$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[0], ACC - Y, 1'd1);
	$write("\n");
	#10 CLK = 1'd0;
end
endtask

task test_SUB_Y_ZERO;
begin
  #10 CLK = 1'd1;
  $write(" ALU_SUB_Y_ZERO \t");
  OPCODE = 6'b001000;
  IMMEDIATE = 16'd0;
  ACC = 16'b0000000000000011;
  Y = 16'b0000000000000011;
  REGISTER_ADDRESS = 1'd1;
  #2
  if (res == ACC - Y && flags[3] == 1'd1)
 	$write("passed");
  else
	$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[3], ACC - Y, 1'd1);
	$write("\n");
	#10 CLK = 1'd0;
end
endtask

task test_SUB_Y_NEGATIVE;
begin
  #10 CLK = 1'd1;
  $write(" ALU_SUB_Y_NEGATIVE \t");
  OPCODE = 6'b001000;
  IMMEDIATE = 16'd0;
  ACC = 16'b0000000000000011;
  Y = 16'b0000000000111000;
  REGISTER_ADDRESS = 1'd1;
  #2
  if (res == ACC - Y && flags[2] == 1'd1)
    $write("passed");
  else
	$write("error @ %t , get %d %d, expect %d %d", $time, res, flags[2], ACC - Y, 1'd1);
	$write("\n");
	#10 CLK = 1'd0;
end
endtask

task test_SUB_X_Immediate;
begin
  #10 CLK = 1'd1;
  $write(" ALU_SUB_X_Immediate \t");
  OPCODE = 6'b001000;
  IMMEDIATE = 16'b1111111111110001;
  X = 16'b1111111111111111;
  REGISTER_ADDRESS = 1'd0;
  #2
  if (res == X - IMMEDIATE)
 	$write("passed");
  else
	$write("error @ %t , get %d, expect %d", $time, res, X - IMMEDIATE);
	$write("\n");
	#10 CLK = 1'd0;
end
endtask

task test_SUB_Y_Immediate;
begin
  #10 CLK = 1'd1;
  $write(" ALU_SUB_Y_Immediate \t");
  OPCODE = 6'b001000;
  IMMEDIATE = 16'b0110000001110100;
  Y = 16'b1000001111000000;
  REGISTER_ADDRESS = 1'd1;
  #2
  if (res == Y - IMMEDIATE)
    $write("ok ");
  else
		$write("error @ %t , get %d, expect %d", $time, res, Y - IMMEDIATE);
	$write("\n");
	#10 CLK = 1'd0;
end
endtask


endmodule

