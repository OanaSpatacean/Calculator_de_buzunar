module ProgramCounterInputDecider(
   input POP, BRA, 
   input [15:0] BRAInput,
   input [15:0] POPInput,
   output reg [15:0] ProgramCounterInput
);

always @(*) 
begin
    if (POP) 
    begin
      ProgramCounterInput <= POPInput; 
    end
    else if (BRA) 
    begin
      ProgramCounterInput <= BRAInput;
    end
end

endmodule
