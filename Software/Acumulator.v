module Acumulator(
  input CLK,RESET,EN,
  input [15:0] IN,
  output reg [15:0] OUT
);
  
always @(negedge CLK, negedge RESET)
begin
  if (~RESET) 
     begin
        OUT <= 0;
     end   
   else if (EN) 
   begin
        OUT <= IN;  
   end
end
  
endmodule