module StackPointer_tb;
reg CLK, RST, INC, DEC;
wire [15:0] OUT;

StackPointer instantaSP(.CLK(CLK), .RST(RST), .INC(INC), .DEC(DEC), .OUT(OUT));

initial begin
  
  SP1;
  #5
  SP2;
  #5
  SP3;
  #5
  SP4;
  #5
  SP5;
  
end

task SP1;
  begin
    #10 CLK = 0;
    RST = 0;
    INC = 0;
    DEC = 0;
    #5
    if (OUT == 16'b0000000111111111) 
      $write("Test 1 passed\n");
    else
      $write("Test 1 error: expected %b actual %b\n",16'b0000000111111111,OUT);  
    #10 CLK = 1;
  end
endtask

task SP2;
  begin
    #10 CLK = 0;
    RST = 1;
    INC = 0;
    DEC = 1;
    #5
    if (OUT == 16'b0000000111111110) 
      $write("Test 2 passed\n");
    else
      $write("Test 2 error: expected %b actual %b\n",16'b0000000111111110,OUT);  
    #10 CLK = 1;
  end
endtask

task SP3;
  begin
    #10 CLK = 0;
    RST = 1;
    INC = 0;
    DEC = 0;
    #5
    if (OUT == 16'b0000000111111110) 
      $write("Test 3 passed\n");
    else
      $write("Test 3 error: expected %b actual %b\n",16'b0000000111111110,OUT);  
    #10 CLK = 1;
  end
endtask

task SP4;
  begin
    #10 CLK = 0;
    RST = 1;
    INC = 1;
    DEC = 0;
    #5
    if (OUT == 16'b0000000111111110) 
      $write("Test 4 passed\n");
    else
      $write("Test 4 error: expected %b actual %b\n",16'b0000000111111110,OUT); 
    #10 CLK = 1; 
  end
endtask

task SP5;
  begin
    #10 CLK = 0;
    RST = 1;
    INC = 1;
    DEC = 0;
    #5
    if (OUT == 16'b0000000111111111) 
      $write("Test 5 passed\n");
    else
      $write("Test 5 error: expected %b actual %b\n",16'b0000000111111111,OUT);  
    #10 CLK = 1; 
  end
endtask

endmodule
