module BitConverter10x16_tb;
reg [9:0] IN;
wire [15:0] OUT;

BitConverter10x16 instantaBitConverter(.IN(IN),.OUT(OUT));

initial 
begin
  BitConverter1;
  #5
  BitConverter2;
  #5
  BitConverter3;
  #5
  BitConverter4;
  #5
  BitConverter5;
end

task BitConverter1;
  begin
    IN <= 10'b1101100110;
    #5
    if (OUT == 16'b0000001101100110) 
      $write("First test passed\n");
   else
      $write("First test error: expected %b actual %b\n",16'b0000001101100110,OUT);  
  end
endtask

task BitConverter2;
  begin
    IN <= 10'b1111111111;
    #5
    if (OUT == 16'b0000001111111111) 
      $write("Second test passed\n");
   else
      $write("Second test error: expected %b actual %b\n",16'b0000001111111111,OUT);  
  end
endtask

task BitConverter3;
  begin
    IN <= 10'b1000000000;
    #5
    if (OUT == 16'b0000001000000000) 
      $write("Third test passed\n");
   else
      $write("Third test error: expected %b actual %b\n",16'b0000001000000000,OUT);  
  end
endtask

task BitConverter4;
  begin
    IN <= 10'b0111111111;
    #5
    if (OUT == 16'b0000000111111111) 
      $write("Fourth test passed\n");
   else
      $write("Fourth test error: expected %b actual %b\n",16'b0000000111111111,OUT);  
  end
endtask

task BitConverter5;
  begin
    IN <= 10'b1010101010;
    #5
    if (OUT == 16'b0000001010101010) 
      $write("Fifth test passed\n");
   else
      $write("Fifth test error: expected %b actual %b\n",16'b0000001010101010,OUT);  
  end
endtask

endmodule