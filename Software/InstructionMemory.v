module InstructionMemory(
  input RESET,
  input [9:0] ADRESS,
  output reg [15:0] out
);

reg [15:0] ROM[1023:0];

always @(negedge RESET) 
begin
  if (~RESET) 
  begin
    out <= ROM[0];   
  end
end

always @(*) 
begin
  if (RESET) 
  begin
    out <= ROM[ADRESS];
  end
end

endmodule