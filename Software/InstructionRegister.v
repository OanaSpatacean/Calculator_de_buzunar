module InstructionRegister(
  input CLK,RESET,w,
  input [15:0] in,
  output reg [15:0] out,
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
      out <= 16'd0;
      REGISTER_ADRESS <= 1'd0;
      REGISTER_ADRESS_STACK <= 2'd0;
      IMMEDIATE <= 9'd0;
      BA <= 10'd0;
  end
    else if (w) 
    begin
      out <= in;
      OPCODE <= in[15:10];
      REGISTER_ADRESS <= in[9];
      REGISTER_ADRESS_STACK <= in[9:8];
      IMMEDIATE <= in[8:0];
      BA <= in[9:0];
    end
end

endmodule      