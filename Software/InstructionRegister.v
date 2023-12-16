module InstructionRegister(
  input CLK,RESET,EN,
  input [15:0] IN,
  output reg [15:0] OUT,
  output reg [5:0] OPCODE,
  output reg REGISTER_ADRESS,
  output reg [1:0] REGISTER_ADRESS_STACK,
  output reg [8:0] IMMEDIATE,
  output reg [9:0] BA
);

always @(posedge CLK, negedge RESET) 
 begin
    if (!RESET) 
    begin
      OUT <= 16'd0;
      REGISTER_ADRESS <= 1'd0;
      REGISTER_ADRESS_STACK <= 2'd0;
      IMMEDIATE <= 9'd0;
      BA <= 10'd0;
  end
    else if (EN) 
    begin
      OUT <= IN;
      OPCODE <= IN[15:10];
      REGISTER_ADRESS <= IN[9];
      REGISTER_ADRESS_STACK <= IN[9:8];
      IMMEDIATE <= IN[8:0];
      BA <= IN[9:0];
    end
end

endmodule      