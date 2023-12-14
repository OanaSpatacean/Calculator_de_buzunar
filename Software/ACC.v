module ACC(
  input CLK,RESET,w,
  input [15:0] in,
  output reg [15:0] out
);
  
always @(negedge CLK, negedge RESET)
begin
  if (~RESET) 
     begin
        out <= 0;
     end   
   else if (w) 
   begin
        out <= in;  
   end
end
  
endmodule