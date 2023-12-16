module InstructionMemory(
  input RESET,
  input [9:0] ADRESS,
  output reg [15:0] OUT
);

reg [15:0] ROM[1023:0];

always @(negedge RESET) 
begin
  if (~RESET) 
  begin
    OUT <= ROM[0];   
  end
end

always @(*) 
begin
  if (RESET) 
  begin
    OUT <= ROM[ADRESS];
  end
end

endmodule