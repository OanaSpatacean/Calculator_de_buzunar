module SignalExtender9x16_tb;
reg [8:0] in;
wire [15:0] out;

SignalExtender9x16 instantaSignalExtender(.in(in),.out(out));

initial begin
  SignalExtender1;
  #5
  SignalExtender2;
  #5
  SignalExtender3;
  #5
  SignalExtender4;
  #5
  SignalExtender5;
  #5
  SignalExtender6;
end

task SignalExtender1;
  begin
    in <= 9'b101100110;
    #5
    if (out == 16'b1111111101100110) 
      $write("First test passed\n");
   else
      $write("First test error: expected %b actual %b\n",16'b1111111101100110,out);  
  end
endtask

task SignalExtender2;
  begin
    in <= 9'b001011110;
    #5
    if (out == 16'b0000000001011110) 
      $write("Second test passed\n");
   else
      $write("Second test error: expected %b actual %b\n",16'b0000000001011110,out);  
  end
endtask

task SignalExtender3;
  begin
    in <= 9'b011111111;
    #5
    if (out == 16'b0000000011111111) 
      $write("Third test passed\n");
   else
      $write("Third test error: expected %b actual %b\n",16'b0000000011111111,out);  
  end
endtask

task SignalExtender4;
  begin
    in <= 9'b111111111;
    #5
    if (out == 16'b1111111111111111) 
      $write("Fourth test passed\n");
   else
      $write("Fourth test error: expected %b actual %b\n",16'b1111111111111111,out);  
  end
endtask

task SignalExtender5;
  begin
    in <= 9'b100000001;
    #5
    if (out == 16'b1111111100000001) 
      $write("Fifth test passed\n");
   else
      $write("Fifth test error: expected %b actual %b\n",16'b1111111100000001,out);  
  end
endtask

task SignalExtender6;
  begin
    in <= 9'b100000000;
    #5
    if (out == 16'b1111111100000000) 
      $write("Sixth test passed\n");
   else
      $write("Sixth test error: expected %b actual %b\n",16'b1111111100000000,out);  
  end
endtask

endmodule