module ACC_tb;
reg CLK, RESET, EN;
reg [15:0] IN;
wire [15:0] OUT;

ACC instantaACC(.CLK(CLK), .RESET(RESET), .EN(EN), .IN(IN), .OUT(OUT));

initial 
begin  
  #5
  ACC1;
  
  #5
  ACC2;
  
  #5
  ACC3;
  
  #5
  ACC4;
  
  #5
  ACC5;
end

task ACC1;
  begin
    IN <= 16'b0110101010110011;
    
    #10 
    CLK = 0;
    RESET = 0;
    EN = 0;
    
    #5
    if (OUT == 16'b0000000000000000) 
      $write("First test passed\n");
    else
      $write("First test error: expected %b actual %b\n",16'b0000000000000000,OUT);  
    
    #10 
    CLK = 1;
  end
endtask

task ACC2;
  begin
    IN <= 16'b0110101010110011;
    
    #10 
    CLK = 0;
    RESET = 1;
    EN = 1;
    
    #5
    if (OUT == 16'b0110101010110011) 
      $write("Second test passed\n");
    else
      $write("Second test error: expected %b actual %b\n",16'b0110101010110011,OUT);  
    
    #10 
    CLK = 1;
  end
endtask

task ACC3;
  begin
    IN <= 16'b0000100000000000;
    
    #10 
    CLK = 0;
    RESET = 1;
    EN = 0;
    
    #5
    if (OUT == 16'b0110101010110011) 
      $write("Third test passed\n");
    else
      $write("Third test error: expected %b actual %b\n",16'b0110101010110011,OUT);  
    
    #10 
    CLK = 1;
  end
endtask

task ACC4;
  begin
    IN <= 16'b0000111100000000;
    
    #10 
    CLK = 0;  
    RESET = 1;
    EN = 1;
    
    #5
    if (OUT == 16'b0000111100000000) 
      $write("Fourth test passed\n");
    else
      $write("Fourth test error: expected %b actual %b\n",16'b0000111100000000,OUT);  
    
    #10 
    CLK = 1;
  end
endtask

task ACC5;
  begin
    IN <= 16'b0000111100000000;
    
    #10 
    CLK = 0;
    RESET = 0;
    EN = 1;
    
    #5
    if (OUT == 16'b0000000000000000) 
      $write("Fifth test passed\n");
    else
      $write("Fifth test error: expected %b actual %b\n",16'b0000000000000000,OUT);  
    
    #10 
    CLK = 1;
  end
endtask

endmodule