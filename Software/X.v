module X(
  input CLK,RST,EN,
  input [15:0] IN,
  output reg [15:0] OUT);
  
  always @(negedge CLK, negedge RST)
  begin
  //daca RST este activ, valoarea de ie?ire este resetata la zero
  //daca semnalul EN este activ, valoarea de iesire preia valoarea de intrare IN
     if (!RST) begin
        OUT <= 16'd0;
     end   
   else if (EN) begin
        OUT <= IN;  
   end
  end
  
endmodule
