module MUX_WRITE_REG(
  input [15:0] ALU_INPUT,
  input [15:0] MOV_INPUT,
  input [15:0] DM_INPUT,
  input [15:0] ACC_COPY,
  input ALU,MOV,LOAD,COPY,
  output reg [15:0] IN
);

always @(*) begin
  if (ALU)
    IN <= ALU_INPUT;
  else if (MOV)
    IN <= MOV_INPUT;
  else if (LOAD)
    IN <= DM_INPUT; 
  else if (COPY)
    IN <= ACC_COPY;  
end

endmodule
