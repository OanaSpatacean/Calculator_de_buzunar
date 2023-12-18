module Y_tb;
reg [15:0] IN;
reg CLK, RST, EN;
wire [15:0] OUT;

Y instantaX(.IN(IN), .CLK(CLK), .RST(RST), .EN(EN), .OUT(OUT));

initial begin
  RST = 0;
  Y1;
  #5
  Y2;
  #5;
  RST = 1;
  #5
  Y3;
  #5
  Y4;
end

task Y1;
  begin
    #10 CLK = 0;    
    IN <= 16'b1011110010100010;
    EN = 0;
    #5
    if (OUT == 16'b0000000000000000) 
      $write("Test 1 passed\n");
    else
      $write("Test 1 error: expected %b actual %b\n",16'b0000000000000000,OUT);  
    #10 CLK = 1;
  end
endtask

task Y2;
  begin
    IN <= 16'b1011110010100010;
    #10 CLK = 0;
    EN = 1;
    #5
    if (OUT == 16'b0000000000000000) 
      $write("Test 2 passed\n");
    else
      $write("Test 2 error: expected %b actual %b\n",16'b0000000000000000,OUT);  
    #10 CLK = 1;
  end
endtask

task Y3;
  begin
    IN <= 16'b1111111111111111;
    #10 CLK = 0;
    EN = 1;
    #5
    if (OUT == 16'b1111111111111111) 
      $write("Test 3 passed\n");
    else
      $write("Test 3 error: expected %b actual %b\n",16'b1111111111111111,OUT);  
    #10 CLK = 1;
  end
endtask

task Y4;
  begin
    IN <= 16'b1001010111001101;
    #10 CLK = 0;
    EN = 0;
    #5
    if (OUT == 16'b1111111111111111) 
      $write("Test 4 passed\n");
    else
      $write("Test 4 error: expected %b actual %b\n",16'b1111111111111111,OUT);  
    #10 CLK = 1;
  end
endtask

endmodule
