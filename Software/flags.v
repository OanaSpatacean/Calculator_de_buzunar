module flags(
  input CLK,RESET,EN,
  input [3:0] IN,
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
  if (EN && CLK) 
  begin
      OVERFLOW <= IN[0];
      CARRY <= IN[1];
      NEGATIVE <= IN[2];
      ZERO <= IN[3];     
  end
end

endmodule