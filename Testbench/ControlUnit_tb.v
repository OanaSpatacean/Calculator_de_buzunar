
module ControlUnit_tb;

  // Inputs
  reg [5:0] OPCODE;
  reg REGISTER_ADDRESS, CLK, RST;
  reg [1:0] REGISTER_ADDRESS_STACK;
  reg [8:0] IMMEDIATE;
  reg FACT_END;

  // Outputs
  wire ALU, BRA, COND_BRA, BRZ, BRN, BRC, BRO, LOAD, STORE, COPY, PUSH, POP, MOV, SEL_FLAG, SEL_ACC, SEL_X, SEL_Y, SEL_PC;
  wire FACT;

  // Instantiate the module
  ControlUnit uut (
    .OPCODE(OPCODE),
    .REGISTER_ADDRESS(REGISTER_ADDRESS),
    .CLK(CLK),
    .RST(RST),
    .REGISTER_ADDRESS_STACK(REGISTER_ADDRESS_STACK),
    .IMMEDIATE(IMMEDIATE),
    .FACT_END(FACT_END),
    .ALU(ALU),
    .BRA(BRA),
    .COND_BRA(COND_BRA),
    .BRZ(BRZ),
    .BRN(BRN),
    .BRC(BRC),
    .BRO(BRO),
    .LOAD(LOAD),
    .STORE(STORE),
    .COPY(COPY),
    .PUSH(PUSH),
    .POP(POP),
    .MOV(MOV),
    .SEL_FLAG(SEL_FLAG),
    .SEL_ACC(SEL_ACC),
    .SEL_X(SEL_X),
    .SEL_Y(SEL_Y),
    .SEL_PC(SEL_PC),
    .FACT(FACT)
  );

initial begin 
    CLK = 0;
    RST = 0;
    OPCODE = 6'b000000;
    REGISTER_ADDRESS = 0;
    REGISTER_ADDRESS_STACK = 2'b00;
    IMMEDIATE = 9'b0;
    FACT_END = 0;

    // Apply reset
    #10 RST = 1; 
    test_brz;
    test_brn;
    test_brc;
    test_bro;
    test_bra;
    test_cmp;
    test_inc_x;
    test_inc_y;
    test_dec_x;
    test_dec_y;
    test_load_x;
    test_load_y;
    test_store_x;
    test_store_y;
    test_push_x;
    test_push_y;
    test_push_acc;
    test_push_pc;
    test_pop_x;
    test_pop_y;
    test_pop_acc;
    test_pop_pc;
    test_not_x;
    test_not_y;
    test_copy_x;
    test_copy_y;
    test_mov_x;
    test_mov_y;
    test_fact_x;
    test_fact_y;
end

task test_brz;
  begin
#10 CLK = 1'd1;
#1
if (BRA == 1'b1 && COND_BRA == 1'b1 && BRZ == 1'b1)
      $write("Test passed: BRZ operation\n");
    else
      $write("Test failed: BRZ operation\n");
#10 CLK = 0;
  
  end
endtask

task test_brn;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b000001;
#1
if (BRA == 1'b1 && COND_BRA == 1'b1 && BRN == 1'b1)
      $write("Test passed: BRN operation\n");
    else
      $write("Test failed: BRN operation\n");
#10 CLK = 0;
  
  end
endtask

task test_brc;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b000010;
#1
if (BRA == 1'b1 && COND_BRA == 1'b1 && BRC == 1'b1)
      $write("Test passed: BRC operation\n");
    else
      $write("Test failed: BRC operation\n");
#10 CLK = 0;
  
  end
endtask

task test_bro;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b000011;
#1
if (BRA == 1'b1 && COND_BRA == 1'b1 && BRO == 1'b1)
      $write("Test passed: BRO operation\n");
    else
      $write("Test failed: BRO operation\n");
#10 CLK = 0;
  
  end
endtask

task test_bra;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b000100;
#1
if (BRA == 1'b1)
      $write("Test passed: BRA operation\n");
    else
      $write("Test failed: BRA operation\n");
#10 CLK = 0;
  
  end
endtask

task test_cmp;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b010100;
#1
if (ALU == 1'b1 && SEL_FLAG)
      $write("Test passed: CMP operation\n");
    else
      $write("Test failed: CMP operation\n");
#10 CLK = 0;
  
  end
endtask

task test_inc_x;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b010110;
REGISTER_ADDRESS = 1'b0;
#5
if (ALU == 1'b1 && SEL_FLAG == 1'b1 && SEL_X == 1'b1)    
      $write("Test passed: INC_X operation\n");
else
      $write("Test failed: INC_X operation\n");
#10 CLK = 0;
  
  end
endtask

task test_inc_y;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b010110;
REGISTER_ADDRESS = 1'b1;
#5
if (ALU == 1'b1 && SEL_FLAG == 1'b1 && SEL_Y == 1'b1)    
      $write("Test passed: INC_Y operation\n");
else
      $write("Test failed: INC_Y operation\n");
#10 CLK = 0;
  
  end
endtask

task test_dec_x;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b010111;
REGISTER_ADDRESS = 1'b0;
#5
if (ALU == 1'b1 && SEL_FLAG == 1'b1 && SEL_X == 1'b1)    
      $write("Test passed: DEC_X operation\n");
else
      $write("Test failed: DEC_X operation\n");
#10 CLK = 0;
  
  end
endtask

task test_dec_y;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b010111;
REGISTER_ADDRESS = 1'b1;
#5
if (ALU == 1'b1 && SEL_FLAG == 1'b1 && SEL_Y == 1'b1)    
      $write("Test passed: DEC_Y operation\n");
else
      $write("Test failed: DEC_Y operation\n");
#10 CLK = 0;
  
  end
endtask

task test_load_y;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b011010;
REGISTER_ADDRESS = 1'b1;
#5
if (LOAD == 1'b1 && SEL_Y == 1'b1)    
      $write("Test passed: LOAD_Y operation\n");
else
      $write("Test failed: LOAD_Y operation\n");
#10 CLK = 0;
  
  end
endtask

task test_load_x;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b011010;
REGISTER_ADDRESS = 1'b0;
#5
if (LOAD == 1'b1 && SEL_X == 1'b1)    
      $write("Test passed: LOAD_X operation\n");
else
      $write("Test failed: LOAD_X operation\n");
#10 CLK = 0;
  
  end
endtask

task test_store_x;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b011011;
REGISTER_ADDRESS = 1'b0;
#5
if (STORE == 1'b1 && SEL_X == 1'b1)    
      $write("Test passed: STORE_X operation\n");
else
      $write("Test failed: STORE_X operation\n");
#10 CLK = 0;
  
  end
endtask

task test_store_y;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b011011;
REGISTER_ADDRESS = 1'b1;
#5
if (STORE == 1'b1 && SEL_Y == 1'b1)    
      $write("Test passed: STORE_Y operation\n");
else
      $write("Test failed: STORE_Y operation\n");
#10 CLK = 0;
  
  end
endtask

task test_push_y;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b011110;
REGISTER_ADDRESS_STACK = 2'd1;
#5
if (PUSH == 1'b1 && STORE == 1'b1 && SEL_Y == 1'b1)    
      $write("Test passed: PUSH_Y operation\n");
else
      $write("Test failed: PUSH_Y operation\n");
#10 CLK = 0;
  
  end
endtask

task test_push_x;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b011110;
REGISTER_ADDRESS_STACK = 2'd0;
#5
if (PUSH == 1'b1 && STORE == 1'b1 && SEL_X == 1'b1)    
      $write("Test passed: PUSH_X operation\n");
else
      $write("Test failed: PUSH_X operation\n");
#10 CLK = 0;
  
  end
endtask

task test_push_acc;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b011110;
REGISTER_ADDRESS_STACK = 2'd2;
#5
if (PUSH == 1'b1 && STORE == 1'b1 && SEL_ACC == 1'b1)    
      $write("Test passed: PUSH_ACC operation\n");
else
      $write("Test failed: PUSH_ACC operation\n");
#10 CLK = 0;
  
  end
endtask

task test_push_pc;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b011110;
REGISTER_ADDRESS_STACK = 2'd3;
#5
if (PUSH == 1'b1 && STORE == 1'b1 && SEL_PC == 1'b1)    
      $write("Test passed: PUSH_PC operation\n");
else
      $write("Test failed: PUSH_PC operation\n");
#10 CLK = 0;
  
  end
endtask

task test_pop_pc;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b011111;
REGISTER_ADDRESS_STACK = 2'd3;
#5
if (POP == 1'b1 && LOAD == 1'b1 && SEL_PC == 1'b1)    
      $write("Test passed: POP_PC operation\n");
else
      $write("Test failed: POP_PC operation\n");
#10 CLK = 0;
  
  end
endtask

task test_pop_x;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b011111;
REGISTER_ADDRESS_STACK = 2'd0;
#5
if (POP == 1'b1 && LOAD == 1'b1 && SEL_X == 1'b1)    
      $write("Test passed: POP_X operation\n");
else
      $write("Test failed: POP_X operation\n");
#10 CLK = 0;
  
  end
endtask

task test_pop_y;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b011111;
REGISTER_ADDRESS_STACK = 2'd1;
#5
if (POP == 1'b1 && LOAD == 1'b1 && SEL_Y == 1'b1)    
      $write("Test passed: POP_Y operation\n");
else
      $write("Test failed: POP_Y operation\n");
#10 CLK = 0;
  
  end
endtask

task test_pop_acc;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b011111;
REGISTER_ADDRESS_STACK = 2'd2;
#5
if (POP == 1'b1 && LOAD == 1'b1 && SEL_ACC == 1'b1)    
      $write("Test passed: POP_ACC operation\n");
else
      $write("Test failed: POP_ACC operation\n");
#10 CLK = 0;
  
  end
endtask

task test_not_x;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b010011;
REGISTER_ADDRESS = 1'd0;
#5
if (ALU == 1'b1 && SEL_FLAG == 1'b1 && SEL_X == 1'b1)    
      $write("Test passed: NOT_X operation\n");
else
      $write("Test failed: NOT_X operation\n");
#10 CLK = 0;
  
  end
endtask

task test_not_y;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b010011;
REGISTER_ADDRESS = 1'd1;
#5
if (ALU == 1'b1 && SEL_FLAG == 1'b1 && SEL_Y == 1'b1)    
      $write("Test passed: NOT_Y operation\n");
else
      $write("Test failed: NOT_Y operation\n");
#10 CLK = 0;
  
  end
endtask

task test_copy_x;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b011100;
#1
if (COPY == 1'b1 && SEL_X == 1'b1)
      $write("Test passed: COPY_X operation\n");
    else
      $write("Test failed: COPY_X operation\n");
#10 CLK = 0;
  
  end
endtask

task test_copy_y;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b011101;
#1
if (COPY == 1'b1 && SEL_Y == 1'b1)
      $write("Test passed: COPY_Y operation\n");
    else
      $write("Test failed: COPY_Y operation\n");
#10 CLK = 0;
  
  end
endtask

task test_mov_x;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b011001;
REGISTER_ADDRESS = 1'd0;
#1
if (MOV == 1'b1 && SEL_X == 1'b1)
      $write("Test passed: MOV_X operation\n");
    else
      $write("Test failed: MOV_X operation\n");
#10 CLK = 0;
  
  end
endtask

task test_mov_y;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b011001;
REGISTER_ADDRESS = 1'd1;
#1
if (MOV == 1'b1 && SEL_Y == 1'b1)
      $write("Test passed: MOV_Y operation\n");
    else
      $write("Test failed: MOV_Y operation\n");
#10 CLK = 0;
  
  end
endtask

task test_fact_x;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b011000;
REGISTER_ADDRESS = 1'd0;
#1
if (FACT_END == 1'b1 && SEL_X == 1'b1 && (FACT == 1'b1 || FACT == 1'b1))
      $write("Test passed: FACT_X operation\n");
    else
      $write("Test failed: FACT_X operation\n");
#10 CLK = 0;
  
  end
endtask

task test_fact_y;
  begin
#10 CLK = 1'd1;
OPCODE = 6'b011000;
REGISTER_ADDRESS = 1'd1;
#1
if (FACT_END == 1'b1 && SEL_Y == 1'b1 && (FACT == 1'b1 || FACT == 1'b1))
      $write("Test passed: FACT_Y operation\n");
    else
      $write("Test failed: FACT_Y operation\n");
#10 CLK = 0;
  
  end
endtask

endmodule
