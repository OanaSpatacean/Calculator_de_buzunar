module MUX_WRITE_REG(
  input [15:0] ALU_OUT,
  input [15:0] MOV_INPUT,
  input [15:0] DM_OUTPUT,
  input [15:0] ACC_COPY,
  input ALU,MOV,LOAD,COPY,
  output reg [15:0] IN
);

always @(*) begin
  if (ALU)
    IN <= ALU_OUT;
  else if (MOV)
    IN <= MOV_INPUT;
  else if (LOAD)
    IN <= DM_OUTPUT; 
  else if (COPY)
    IN <= ACC_COPY;  
end

endmodule
