module FACT_REG(
  input [15:0] IN,
  input CLK,RST,EN,
  output reg [15:0] OUT);

  always @(negedge CLK, negedge RST)
  begin
     if (!RST) begin
        OUT <= 16'd1;
     end   
   else if (EN) begin
        OUT <= IN;  
   end
  end

endmodule

