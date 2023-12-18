module InstructionRegister(
  input CLK,RST,EN,
  input [15:0] IN,
  output reg [15:0] OUT,
  output reg [5:0] OPCODE,
  output reg REGISTER_ADDRESS,
  output reg [1:0] REGISTER_ADDRESS_STACK,
  output reg [8:0] IMMEDIATE,
  output reg [9:0] BA
);

always @(posedge CLK, negedge RST) 
 begin
    if (!RST) 
    begin
      OUT <= 16'd0;
      REGISTER_ADDRESS <= 1'd0;
      REGISTER_ADDRESS_STACK <= 2'd0;
      IMMEDIATE <= 9'd0;
      BA <= 10'd0;
  end
    else if (EN) 
    begin
      OUT <= IN;
      OPCODE <= IN[15:10];
      REGISTER_ADDRESS <= IN[9];
      REGISTER_ADDRESS_STACK <= IN[9:8];
      IMMEDIATE <= IN[8:0];
      BA <= IN[9:0];
    end
end

endmodule      