module InstructionMemory(
  input RST,
  input [9:0] ADDRESS,
  output reg [15:0] OUT
);

reg [15:0] ROM[1023:0];

always @(negedge RST) 
begin
  if (~RST) 
  begin
    OUT <= ROM[0];   
  end
end

always @(*) 
begin
  if (RST) 
  begin
    OUT <= ROM[ADDRESS];
  end
end

endmodule