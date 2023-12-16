module ProgramCounter_tb;
reg [15:0] IN;
reg CLK, RESET, EN, BRA, STACK_POP, FACT;
wire [15:0] OUT;

ProgramCounter instantaProgramCounter(.CLK(CLK), .RESET(RESET), .EN(EN), .BRA(BRA), .STACK_POP(STACK_POP), .FACT(FACT), .IN(IN), .OUT(OUT));

initial begin
  EN = 1'd0;
  BRA = 1'd0;
  STACK_POP = 1'd0;
  FACT = 1'd0;
  IN <= 16'b0110101010110011;
  
  ProgramCounter1;
  #5
  ProgramCounter2;
  #5
  ProgramCounter3;
  #5
  ProgramCounter4;
  #5
  ProgramCounter5;
  #5
  ProgramCounter6;
  #5
  ProgramCounter7;
  #5
  ProgramCounter8;
  
end

task ProgramCounter1;
  begin
    CLK = 1'd0;
    RESET = 1'd0;
    #5
    if (OUT == 16'b0000000000000000) 
      $write("First test passed\n");
    else
      $write("First test error: expected %b actual %b\n",16'b0000000000000000,OUT);  
    #10 CLK = 1'd1;
  end
endtask

task ProgramCounter2;
  begin
    #10 CLK = 1'd0;
    RESET = 1'd1;
    #5
    if (OUT == 16'b0000000000000001) 
      $write("Second test passed\n");
    else
      $write("Second test error: expected %b actual %b\n",16'b0000000000000001,OUT);  
    #10 CLK = 1'd1;
  end
endtask

task ProgramCounter3;
  begin
    #10 CLK = 1'd0;
    RESET = 1'd1;
    BRA = 1'd1;
    #5
    if (OUT == 16'b0000000000000010) 
      $write("Third test passed\n");
    else
      $write("Third test error: expected %b actual %b\n",16'b0000000000000010,OUT);  
    #10 CLK = 1'd1;
  end
endtask

task ProgramCounter4;
  begin
    #10 CLK = 1'd0;
    RESET = 1'd1;
    BRA = 1'd1;
    EN = 1'd1;
    #5
    if (OUT == 16'b0110101010110011) 
      $write("Fourth test passed\n");
    else
      $write("Fourth test error: expected %b actual %b\n",16'b0110101010110011,OUT);  
    #10 CLK = 1'd1;
  end
endtask

task ProgramCounter5;
  begin
    IN <= 16'b1000011110101011;
    #10 CLK = 1'd0;
    RESET = 1'd1;
    BRA = 1'd0;
    STACK_POP = 1'd1;
    EN = 1'd1;
    #5
    if (OUT == 16'b1000011110101101) 
      $write("Fifth test passed\n");
    else
      $write("Fifth test error: expected %b actual %b\n",16'b1000011110101101,OUT);  
    #10 CLK = 1'd1;
  end
endtask

task ProgramCounter6;
  begin
    IN <= 16'b1000010000000000;
    #10 CLK = 1'd0;
    RESET = 1'd1;
    BRA = 1'd0;
    STACK_POP = 1'd0;
    EN = 1'd1;
    #5
    if (OUT == 16'b1000011110101110) 
      $write("Sixth test passed\n");
    else
      $write("Sixth test error: expected %b actual %b\n",16'b1000011110101110,OUT);  
    #10 CLK = 1'd1;
  end
endtask

task ProgramCounter7;
  begin
    IN <= 16'b1000010000000000;
    #10 CLK = 1'd0;
    RESET = 1'd0;
    BRA = 1'd0;
    STACK_POP = 1'd0;
    EN = 1'd1;
    #5
    if (OUT == 16'b0000000000000000) 
      $write("Seventh test passed\n");
    else
      $write("Seventh test error: expected %b actual %b\n",16'b0000000000000000,OUT);  
    #10 CLK = 1'd1;
  end
endtask

task ProgramCounter8;
  begin
    IN <= 16'b1000010000000000;
    #10 CLK = 1'd0;
    RESET = 1'd1;
    BRA = 1'd0;
    STACK_POP = 1'd1;
    EN = 1'd0;
    #5
    if (OUT == 16'b0000000000000001) 
      $write("Eighth test passed\n");
    else
      $write("Eighth test error: expected %b actual %b\n",16'b0000000000000001,OUT);  
    #10 CLK = 1'd1;
  end
endtask

endmodule