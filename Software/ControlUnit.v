module ControlUnit(
  input [5:0] OPCODE,
  input REGISTER_ADDRESS, CLK, RST,
  input [1:0] REGISTER_ADDRESS_STACK,
  input [8:0] IMMEDIATE,
  input FACT_END,
  output reg ALU, BRA, COND_BRA, BRZ, BRN, BRC, BRO, LOAD, STORE, COPY, PUSH, POP, MOV, SEL_FLAG, SEL_ACC, SEL_X, SEL_Y, SEL_PC,
  output reg FACT
);

always @(negedge RST) begin
    if (!RST) begin
      ALU <= 1'd0;
      BRA<=  1'd0;
      COND_BRA <= 1'd0;
      BRZ <= 1'd0;
      BRN <= 1'd0;
      BRC <= 1'd0;
      BRO <= 1'd0;
      LOAD <= 1'd0;
      STORE <= 1'd0;
      COPY <= 1'd0;
      PUSH <= 1'd0;
      POP <= 1'd0;
      MOV <= 1'd0;
      SEL_FLAG <= 1'd0;
      SEL_ACC <= 1'd0;
      SEL_X <= 1'd0;
      SEL_Y <= 1'd0;
      SEL_PC <= 1'd0;
      FACT <= 1'd0;
    end
end

always @(*) begin
    if (CLK) begin
	ALU <= 0;
        BRA <= 0;
        COND_BRA <= 0;
        BRZ <= 0;
        BRN <= 0;
        BRC <= 0;
        BRO <= 0;
        LOAD <= 0;
        STORE <= 0;
        COPY <= 0;
        PUSH <= 0;
        POP <= 0;
        MOV <= 0;
        SEL_FLAG <= 0;
        SEL_ACC <= 0;
        SEL_X <= 0;
        SEL_Y <= 0;
        SEL_PC <= 0;
        FACT <= 0;
        case (OPCODE)
            6'b000000: begin // BRZ
                BRA <=  1'd1;
		COND_BRA <= 1'd1;
                BRZ <= 1'd1;
            end
            6'b000001: begin // BRN
		BRA <=  1'd1;
		COND_BRA <= 1'd1;
                BRN <= 1'd1;
            end
		6'b000010: begin // BRC
		BRA <=  1'd1;
		COND_BRA <= 1'd1;
                BRC <= 1'd1;
            end
		6'b000011: begin // BRO
		BRA <=  1'd1;
		COND_BRA <= 1'd1;
                BRO <= 1'd1;
            end
		6'b000100: begin // BRA
		BRA <=  1'd1;
            end
		6'b010100: begin // CMP
		ALU <=  1'd1;
            	SEL_FLAG <= 1'd1;
            end
		6'b010110: begin // INC
		ALU <=  1'd1;
            	SEL_FLAG <= 1'd1;
		if (REGISTER_ADDRESS == 1'b0) begin
                 	SEL_X <= 1'b1; 
              	end
            	else if (REGISTER_ADDRESS == 1'b1) begin
                	SEL_Y <= 1'b1; 
            	end
            end
		6'b010111: begin // DEC
		ALU <=  1'd1;
            	SEL_FLAG <= 1'd1;
		if (REGISTER_ADDRESS == 1'b0) begin
                 	SEL_X <= 1'b1;
              	end
            	else if (REGISTER_ADDRESS == 1'b1) begin
                	SEL_Y <= 1'b1; 
            	end
            end
		6'b011010: begin // LOAD
		LOAD <= 1'd1;
            	if (REGISTER_ADDRESS == 1'd0) begin
               		SEL_X <= 1'd1;
            	end
            	else begin
              		SEL_Y <= 1'd1;
           	end
	    end
		6'b011011: begin // STORE
		STORE <= 1'd1;
            	if (REGISTER_ADDRESS == 1'd0) begin
              	 	SEL_X <= 1'd1;
            	end
            	else begin
              		SEL_Y <= 1'd1;
           	end
	    end
		6'b011110: begin // PUSH
		PUSH <= 1'd1;
            	STORE <= 1'd1;
		if (REGISTER_ADDRESS_STACK == 2'd0) begin
               		SEL_X <= 1'd1;
            	end
            	else if (REGISTER_ADDRESS_STACK == 2'd1) begin
               		SEL_Y <= 1'd1;
           	end
         	else if (REGISTER_ADDRESS_STACK == 2'd2) begin
               		SEL_ACC <= 1'd1;
        	end
        	else if (REGISTER_ADDRESS_STACK == 2'd3) begin
               		SEL_PC <= 1'd1;
        	end
      	      	else begin
               SEL_X <= 1'd0;
               SEL_Y <= 1'd0;
               SEL_ACC <= 1'd0;
               SEL_PC <= 1'd0;
     		 end
            end
		6'b011111: begin // POP
		POP <= 1'd1;
            	LOAD <= 1'd1;
		if (REGISTER_ADDRESS_STACK == 2'd0) begin
               SEL_X <= 1'd1;
            	end
            	else if (REGISTER_ADDRESS_STACK == 2'd1) begin
               SEL_Y <= 1'd1;
           	end
         	else if (REGISTER_ADDRESS_STACK == 2'd2) begin
               SEL_ACC <= 1'd1;
        	end
        	else if (REGISTER_ADDRESS_STACK == 2'd3) begin
               SEL_PC <= 1'd1;
        	end
      	      	else begin
               SEL_X <= 1'd0;
               SEL_Y <= 1'd0;
               SEL_ACC <= 1'd0;
               SEL_PC <= 1'd0;
     		 end
            end
		6'b011000: begin // FACT
                if (FACT == 1'd1) begin
              		if (FACT_END == 1'd1) begin
                 		FACT = 1'd0;  
                  		if (REGISTER_ADDRESS == 1'd0) begin
                    			SEL_X <= 1'd1;
                  		end
                  		else begin
                    		SEL_Y <= 1'd1;
                  		end
              		end
            	end
            	else begin
            	ALU <=  1'd1;
            	SEL_FLAG <= 1'd1;
            	FACT <= 1'd1;
         	end
            end
		6'b010011: begin // NOT
                ALU <=  1'd1;
            	SEL_FLAG <= 1'd1;
		if (REGISTER_ADDRESS == 1'd0) begin
                	SEL_X <= 1'd1;
            	end
            	else begin
                	SEL_Y <= 1'd1;
            	end
            end
	    6'b011100: begin // COPY_X
                COPY <= 1'd1;
            	SEL_X <= 1'd1;
            end
	    6'b011101: begin // COPY_Y
                COPY <= 1'd1;
                SEL_Y <= 1'd1;
            end
            6'b011001: begin // MOV
                MOV <= 1;
                if (REGISTER_ADDRESS == 1'd0) begin
               		SEL_X <= 1'd1;
            	end
            	else begin
              		SEL_Y <= 1'd1;
           	end
            end
            default: begin
                ALU <= 0;
        	BRA <= 0;
        	COND_BRA <= 0;
        	BRZ <= 0;
        	BRN <= 0;
        	BRC <= 0;
        	BRO <= 0;
        	LOAD <= 0;
        	STORE <= 0;
        	COPY <= 0;
        	PUSH <= 0;
        	POP <= 0;
        	MOV <= 0;
        	SEL_FLAG <= 0;
        	SEL_ACC <= 0;
        	SEL_X <= 0;
        	SEL_Y <= 0;
        	SEL_PC <= 0;
        	FACT <= 0;
            end
        endcase
    end
end

endmodule
