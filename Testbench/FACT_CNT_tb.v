module FACT_CNT_tb;
reg [8:0] CNT;
reg CLK, RST, EN;
wire [8:0] OUT;
wire FACT_END;

FACT_CNT instantaFACT_CNT(.CNT(CNT), .CLK(CLK), .RST(RST), .EN(EN), .OUT(OUT), .FACT_END(FACT_END));

initial begin
  RST = 1'd0;
  #1
  RST = 1'd1;
  EN = 1'd1;
  CLK = 1'd1;
  CNT = 9'd3;
  #5
  EN = 1'd0;
  CNT1;
  #5
  CNT2;
  #5
  CNT3;
  #5
  CNT4;
  #5
  CNT5;
  $stop;
  $finish;

end

task CNT1;
  begin
    #5
    if (OUT == 9'd3 && FACT_END == 1'b0) 
      $write("First test passed\n");
    else
      $write("First test error: expected %b %b actual %b %b\n",16'd3,1'd0,OUT,FACT_END);  
    #10 CLK = 1'd0;
  end
endtask

task CNT2;
  begin
    #10 CLK = 1'd1;
    #5
    if (OUT == 9'd2 && FACT_END == 1'b0) 
      $write("Second test passed\n");
    else
      $write("Second test error: expected %b %b actual %b %b\n",9'd2,1'd0,OUT,FACT_END);  
    #10 CLK = 1'd0;
  end
endtask

task CNT3;
  begin
    #10 CLK = 1'd1;
    #5
    if (OUT == 9'd1 && FACT_END ==  1'b1) 
      $write("Third test passed\n");
    else
      $write("Third test error: expected %b %b actual %b %b\n",9'd1,1'b1,OUT,FACT_END); 
    #10 CLK = 1'd0;
  end
endtask

task CNT4;
  begin
    #10 CLK = 1'd1;
    #5
    if (OUT == 9'd0 && FACT_END == 1'b0) 
      $write("Forth test passed\n");
    else
      $write("Forth test error: expected %b %b actual %b %b\n",9'd0,1'b0,OUT,FACT_END);  
    #10 CLK = 1'd0;
  end
endtask

task CNT5;
  begin
    #10 CLK = 1'd1;
    #5
    if (OUT == 9'd0 &&  FACT_END == 1'b0) 
      $write("Fifth test passed\n");
    else
      $write("Fifth test error: expected %b %b actual %b %b\n",9'd0,1'b0,OUT,FACT_END);  
    #10 CLK = 1'd0;
  end
endtask

endmodule