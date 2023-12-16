module InstructionRegister_tb;
reg CLK, RESET, EN;
reg [15:0] IN;
wire [15:0] OUT;
wire [5:0] OPCODE;
wire REGISTER_ADRESS;
wire [1:0] REGISTER_ADRESS_STACK;
wire [8:0] IMMEDIATE;
wire [9:0] BA;

InstructionRegister instantaInstructionRegister(.CLK(CLK), .RESET(RESET), .EN(EN), .IN(IN), .OUT(OUT), .OPCODE(OPCODE), .REGISTER_ADRESS(REGISTER_ADRESS), .REGISTER_ADRESS_STACK(REGISTER_ADRESS_STACK), .IMMEDIATE(IMMEDIATE), .BA(BA));

initial begin
  EN = 1'd0;
  IN <= 16'b0110101010110011;
  
  #5
  InstructionRegister1;
  #5
  InstructionRegister2;
  #5
  InstructionRegister3;
  
end

task InstructionRegister1;
  begin
    CLK = 1'd1;
    RESET = 1'd0;
    
    #5
    if (OUT == 16'd0 && REGISTER_ADRESS == 1'd0 && BA == 10'd0 && IMMEDIATE == 9'd0 && REGISTER_ADRESS_STACK == 2'd0) 
      $write("First test passed\n");
    else
      $write("First test error: expected %b %b %b %b %b, actual %b %b %b %b %b\n",16'b0000000000000000,1'b0,10'b0000000000,9'b000000000,2'b00,OUT,REGISTER_ADRESS,BA,IMMEDIATE,REGISTER_ADRESS_STACK);  
    
    #10 
    CLK = 1'd0;
  end
endtask

task InstructionRegister2;
  begin
    #10 
    CLK = 1'd1;
    RESET = 1'd1;
    EN = 1'd1;
    
    #5
    if (OUT == 16'b0110101010110011 && OPCODE == 6'b011010 && REGISTER_ADRESS == 1'b1 && BA == 10'b1010110011 && IMMEDIATE == 9'b010110011 && REGISTER_ADRESS_STACK == 2'b10) 
      $write("Second test passed\n");
    else
      $write("Second test error: expected %b %b %b %b %b %b, actual %b %b %b %b %b %b\n",16'b0110101010110011,6'b011010,1'b1,10'b1010110011,9'b010110011,2'b10,OUT,OPCODE,REGISTER_ADRESS,BA,IMMEDIATE,REGISTER_ADRESS_STACK);  
    
    #10 
    CLK = 1'd0;
  end
endtask

task InstructionRegister3;
  begin
    IN <= 16'b0001011011110100;
    
    #10 
    CLK = 1'd1;
    RESET = 1'd1;
    EN = 1'd0;
    
    #5
    if (OUT == 16'b0110101010110011 && OPCODE == 6'b011010 && REGISTER_ADRESS == 1'b1 && BA == 10'b1010110011 && IMMEDIATE == 9'b010110011 && REGISTER_ADRESS_STACK == 2'b10) 
      $write("Third test passed\n");
    else
      $write("Third test error: expected %b %b %b %b %b %b, actual %b %b %b %b %b %b\n",16'b0110101010110011,6'b011010,1'b1,10'b1010110011,9'b010110011,2'b10,OUT,OPCODE,REGISTER_ADRESS,BA,IMMEDIATE,REGISTER_ADRESS_STACK);  
    
    #10 
    CLK = 1'd0;
  end
endtask

endmodule