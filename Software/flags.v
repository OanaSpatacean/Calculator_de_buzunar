module flags(
  input CLK,RESET,w,
  input [3:0] in,
  output reg OVERFLOW,CARRY,NEGATIVE,ZERO
);

always @(negedge RESET) 
begin
    if (~RESET) 
    begin
      OVERFLOW <= 0;  
      CARRY <= 0;
      NEGATIVE <= 0;
      ZERO <= 0;     
   end
end

always @(*) 
begin
  if (w && CLK) 
  begin
      OVERFLOW <= in[0];
      CARRY <= in[1];
      NEGATIVE <= in[2];
      ZERO <= in[3];     
  end
end

endmodule