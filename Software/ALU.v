
module ALU(
  input signed [15:0] ACC,X,Y,IMMEDIATE,
  input [15:0] fact_reg,fact_val,
  input [5:0] OPCODE,
  input EN,CLK,RST,REGISTER_ADDRESS,
  output reg signed [15:0] res,
  output reg [3:0] flags); //FLAGS[Z=3,N=2,C=1,O=0]
  
 reg [15:0] value_before_operation;
 reg sign_before_operation, same_sign;
 reg [15:0] rotate_cnt;
  
  always @(negedge RST) begin
    if (!RST) begin
      res <= 16'd0;
      flags <= 4'd0;
    end
  end
  
  
  always @(*) begin
    
    if (CLK && EN) begin
      case (OPCODE)
        6'b000111: begin //ADD
          if (IMMEDIATE == 16'd0) begin
            sign_before_operation = ACC[15];
            value_before_operation = ACC;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (ACC[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC + X;
            end
            else begin
              if (ACC[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC + Y;
            end
        end
          else begin
            sign_before_operation = IMMEDIATE[15];
            value_before_operation = IMMEDIATE;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (IMMEDIATE[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = IMMEDIATE + X;
          end
            else begin
              if (IMMEDIATE[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = IMMEDIATE + Y;
            end
         end
      
      if  (res ==  16'd0) //zero
              flags[3] = 1'd1;
            else 
              flags[3] = 1'd0;
              
            if (res[15] == 1'd1) //negative
              flags[2] = 1'd1;
            else
              flags[2] = 1'd0;
              
            if (res < value_before_operation) //carry
              flags[1] = 1'd1;
            else
              flags[1] = 1'd0;
            
            if (same_sign == 1'd1 && sign_before_operation != res[15]) //overflow 
              flags[0] = 1'd1;
            else
              flags[0] = 1'd0;
      end
      
        6'b001000: begin //SUB
          if (IMMEDIATE == 16'd0) begin
            sign_before_operation = ACC[15];
            value_before_operation = ACC;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (ACC[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC - X;
            end
            else begin
              if (ACC[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC - Y;
            end
        end
          else begin
            sign_before_operation = IMMEDIATE[15];
            value_before_operation = IMMEDIATE;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (IMMEDIATE[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = X - IMMEDIATE;
            end
            else begin
              if (IMMEDIATE[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = Y - IMMEDIATE;
            end
          end
          
          if  (res ==  16'd0) //zero
              flags[3] = 1'd1;
            else 
              flags[3] = 1'd0;
              
            if (res[15] == 1'd1) //negative
              flags[2] = 1'd1;
            else
              flags[2] = 1'd0;
              
            if (res > value_before_operation) //carry
              flags[1] = 1'd1;
            else
              flags[1] = 1'd0;
            
            if (same_sign == 1'd1 && sign_before_operation != res[15]) //overflow 
              flags[0] = 1'd1;
            else
              flags[0] = 1'd0;
       end
       
        6'b001001: begin //LSR
          if (IMMEDIATE == 16'd0) begin
            sign_before_operation = ACC[15];
            value_before_operation = ACC;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (ACC[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC >> X;
            end
            else begin
              if (ACC[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC >> Y;
            end
          end
          else begin
            sign_before_operation = IMMEDIATE[15];
            value_before_operation = IMMEDIATE;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (IMMEDIATE[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = X >> IMMEDIATE;
            end
            else begin
              if (IMMEDIATE[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = Y >> IMMEDIATE;
            end
          end
            
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            
            if  (res ==  16'd0) //zero
              flags[3] = 1'd1;
            else 
              flags[3] = 1'd0;
              
            if (res[15] == 1'd1) //negative
              flags[2] = 1'd1;
            else
              flags[2] = 1'd0;
        end
      
        
        6'b001010: begin //LSL
          if (IMMEDIATE == 16'd0) begin
            sign_before_operation = ACC[15];
            value_before_operation = ACC;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (ACC[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC << X;
            end
            else begin
              if (ACC[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC << Y;
            end
          end
          else begin
            sign_before_operation = IMMEDIATE[15];
            value_before_operation = IMMEDIATE;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (IMMEDIATE[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = X << IMMEDIATE;
            end
            else begin
            if (IMMEDIATE[15] == Y[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = Y << IMMEDIATE;
            end
        end
            
          flags[0] = 1'd0;
          flags[1] = 1'd0;
            
          if  (res ==  16'd0) //zero
            flags[3] = 1'd1;
          else 
            flags[3] = 1'd0;
            
          if (res[15] == 1'd1) //negative
            flags[2] = 1'd1;
          else
            flags[2] = 1'd0;
        
      end
      
      
        6'b001011: begin // RSR
          if (IMMEDIATE == 16'd0) begin
            sign_before_operation = ACC[15];
            value_before_operation = ACC;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (ACC[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC;
              rotate_cnt = X;
              while (rotate_cnt > 0) begin
                res = {res[0], res[15:1]}; 
                rotate_cnt = rotate_cnt - 16'd1;
              end
            end
            else begin
              if (ACC[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC;
              rotate_cnt = Y;
              while (rotate_cnt > 0) begin
                res = {res[0], res[15:1]};
                rotate_cnt = rotate_cnt - 16'd1;
              end
            end
          end
          else begin
            sign_before_operation = IMMEDIATE[15];
            value_before_operation = IMMEDIATE;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (IMMEDIATE[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = X;
              rotate_cnt = IMMEDIATE;
              while (rotate_cnt > 0) begin
                res = {res[0], res[15:1]};  
                rotate_cnt = rotate_cnt - 16'd1;
              end
            end
            else begin
              if (IMMEDIATE[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = Y;
              rotate_cnt = IMMEDIATE;
              while (rotate_cnt > 0) begin
                res = {res[0], res[15:1]};
                rotate_cnt = rotate_cnt - 16'd1;
              end
            end
        end
              
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            
            if  (res ==  16'd0) //zero
              flags[3] = 1'd1;
            else 
              flags[3] = 1'd0;
              
            if (res[15] == 1'd1) //negative
              flags[2] = 1'd1;
            else
              flags[2] = 1'd0;
          end
       
       
     6'b001100: begin //RSL
          if (IMMEDIATE == 16'd0) begin
            sign_before_operation = ACC[15];
            value_before_operation = ACC;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (ACC[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC;
              rotate_cnt = X;
              while (rotate_cnt > 0) begin
                res = {res[14:0],res[15]}; 
                rotate_cnt = rotate_cnt - 16'd1;
              end
            end
            else begin
              if (ACC[15] == Y[15])
                same_sign = 1'd1;
              else
               	same_sign = 1'd0;
              res = ACC;
              rotate_cnt = Y;
              while (rotate_cnt > 0) begin
                res = {res[14:0],res[15]}; 
                rotate_cnt = rotate_cnt - 16'd1;
              end
            end
            end
          else begin
            sign_before_operation = IMMEDIATE[15];
            value_before_operation = IMMEDIATE;
            if (REGISTER_ADDRESS== 1'd0) begin
              if (IMMEDIATE[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = X;
              rotate_cnt = IMMEDIATE;
              while (rotate_cnt > 0) begin
                res = {res[14:0],res[15]}; 
                rotate_cnt = rotate_cnt - 16'd1;
              end
            end
            else begin
              if (IMMEDIATE[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = Y;
              rotate_cnt = IMMEDIATE;
              while (rotate_cnt > 0) begin
                res = {res[14:0],res[15]}; 
                rotate_cnt = rotate_cnt - 16'd1;
              end
            end
        end
            
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            
            if  (res ==  16'd0) //zero
              flags[3] = 1'd1;
            else 
              flags[3] = 1'd0;
              
            if (res[15] == 1'd1) //negative
              flags[2] = 1'd1;
            else
              flags[2] = 1'd0;
          end
        
       
       6'b001101: begin //MUL
          if (IMMEDIATE == 16'd0) begin
            sign_before_operation = ACC[15];
            value_before_operation = ACC;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (ACC[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC * X;
            end
            else begin
              if (ACC[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC * Y;
            end
          end
          else begin
            sign_before_operation = IMMEDIATE[15];
            value_before_operation = IMMEDIATE;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (IMMEDIATE[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = IMMEDIATE * X;
            end
            else begin
              if (IMMEDIATE[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = IMMEDIATE * Y;
            end
        end
          
          if  (res ==  16'd0) //zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
          
          if (res[15] == 1'd1) //negative
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
              
          if (res < value_before_operation) // carry
              flags[1] = 1'd1;
            else
              flags[1] = 1'd0;
              
              
          if (same_sign == 1'd1 && sign_before_operation != res[15]) //overflow
              flags[0] = 1'd1;
          else
              flags[0] = 1'd0;
       end
       
       
        6'b001110: begin //DIV
          if (IMMEDIATE == 16'd0) begin
            sign_before_operation = ACC[15];
            value_before_operation = ACC;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (ACC[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              if (X == 16'd0)
                res = ACC;
              else
                res = ACC / X;
            end
            else begin
              if (ACC[15] == Y[15])
                same_sign = 1'd1;
            else
                same_sign = 1'd0;
              if (Y == 16'd0)
                res = ACC;
              else
                res = ACC / Y;
            end     
          end
          else begin
            sign_before_operation = IMMEDIATE[15];
            value_before_operation = IMMEDIATE;
            if (REGISTER_ADDRESS== 1'd0) begin
              if (IMMEDIATE[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              if (IMMEDIATE == 16'd0)
                res = X;
              else
                res = X / IMMEDIATE;
            end
            else begin
              if (IMMEDIATE[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              if (IMMEDIATE == 16'd0)
                res = Y;
              else
                res = Y / IMMEDIATE;
            end
          end
            
          flags[0] = 1'd0;
          flags[1] = 1'd0;
          
          if  (res ==  16'd0) //zero
            flags[3] = 1'd1;
          else 
            flags[3] = 1'd0;
            
          if (res[15] == 1'd1) //negative
            flags[2] = 1'd1;
          else
            flags[2] = 1'd0;  
         
       end
       
       
        6'b001111: begin //MOD
          if (IMMEDIATE == 16'd0) begin
            sign_before_operation = ACC[15];
            value_before_operation = ACC;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (ACC[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              if (X == 16'd0)
                res = ACC;
              else
                res = ACC % X;
            end
            else begin
              if (ACC[15] == Y[15])
                same_sign = 1'd1;
            else
                same_sign = 1'd0;
              if (Y == 16'd0)
                res = ACC;
              else
                res = ACC % Y;
            end
          end
          else begin
            sign_before_operation = IMMEDIATE[15];
            value_before_operation = IMMEDIATE;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (IMMEDIATE[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              if (IMMEDIATE == 16'd0)
                res = X;
              else
                res = X % IMMEDIATE;
            end
            else begin
              if (IMMEDIATE[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              if (IMMEDIATE == 16'd0)
                res = Y;
              else
                res = Y % IMMEDIATE;
            end
        
            
          flags[0] = 1'd0;
          flags[1] = 1'd0;
          
          if  (res ==  16'd0) 
            flags[3] = 1'd1;
          else 
            flags[3] = 1'd0;
            
          if (res[15] == 1'd1)
            flags[2] = 1'd1;
          else
            flags[2] = 1'd0;
        end
       end
       
       
       6'b010000: begin //OR
          if (IMMEDIATE == 16'd0) begin
            sign_before_operation = ACC[15];
            value_before_operation = ACC;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (ACC[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC | X;
            end
            else begin
              if (ACC[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC | Y;
            end    
          end
          else begin
            sign_before_operation = IMMEDIATE[15];
            value_before_operation = IMMEDIATE;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (IMMEDIATE[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = X | IMMEDIATE;
            end
            else begin
              if (IMMEDIATE[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = Y | IMMEDIATE;
            end
          end
            
          flags[0] = 1'd0;
          flags[1] = 1'd0;
          
          if  (res ==  16'd0)//zero 
            flags[3] = 1'd1;
          else 
            flags[3] = 1'd0;
            
          if (res[15] == 1'd1)//negative
            flags[2] = 1'd1;
          else
            flags[2] = 1'd0;
        end
       
       
       6'b010001: begin // AND
          if (IMMEDIATE == 16'd0) begin
            sign_before_operation = ACC[15];
            value_before_operation = ACC;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (ACC[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC & X;
            end
            else begin
              if (ACC[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC & Y;
            end
          end
          else begin
            sign_before_operation = IMMEDIATE[15];
            value_before_operation = IMMEDIATE;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (IMMEDIATE[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = X & IMMEDIATE;
            end
            else begin
              if (IMMEDIATE[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = Y & IMMEDIATE;
            end
          end 
          
          flags[0] = 1'd0;
          flags[1] = 1'd0;
          
          if  (res ==  16'd0)//zero 
            flags[3] = 1'd1;
          else 
            flags[3] = 1'd0;
            
          if (res[15] == 1'd1)//negative
            flags[2] = 1'd1;
          else
            flags[2] = 1'd0;
    
       end
     
      6'b010010: begin // XOR
          if (IMMEDIATE == 16'd0) begin
            sign_before_operation = ACC[15];
            value_before_operation = ACC;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (ACC[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC ^ X;
            end
            else begin
              if (ACC[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC ^ Y;
            end
          end
          else begin
            sign_before_operation = IMMEDIATE[15];
            value_before_operation = IMMEDIATE;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (IMMEDIATE[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = X ^ IMMEDIATE;
            end
            else begin
              if (IMMEDIATE[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = Y ^ IMMEDIATE;
          end
        end
        
        flags[0] = 1'd0;
        flags[1] = 1'd0;
        
        if  (res ==  16'd0) //  zero
          flags[3] = 1'd1;
        else 
          flags[3] = 1'd0;
          
        if (res[15] == 1'd1) //negative
          flags[2] = 1'd1;
        else
          flags[2] = 1'd0;
    
       end
       
      6'b010011: begin // NOT
          if (REGISTER_ADDRESS == 1'd0) begin
            res = ~X;
          end
          else begin
            res = ~Y;
          end
        
        flags[0] = 1'd0;
        flags[1] = 1'd0;
        
        if  (res ==  16'd0) //zero
          flags[3] = 1'd1;
        else 
          flags[3] = 1'd0;
          
        if (res[15] == 1'd1)//negative
          flags[2] = 1'd1;
        else
          flags[2] = 1'd0;
          
      end
      
    
     6'b010100: begin //CMP
          if (IMMEDIATE == 16'd0) begin
            sign_before_operation = ACC[15];
            value_before_operation = ACC;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (ACC[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC - X;
            end
            else begin
              if (ACC[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC - Y;
            end
         end
         else begin
            sign_before_operation = IMMEDIATE[15];
            value_before_operation = IMMEDIATE;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (IMMEDIATE[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = X - IMMEDIATE;
            end
            else begin
              if (IMMEDIATE[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = Y - IMMEDIATE;
            end
          end 
          
          if  (res ==  16'd0) //zero
            flags[3] = 1'd1;
          else 
            flags[3] = 1'd0;
          if (res[15] == 1'd1) //negative 
            flags[2] = 1'd1;
          else
            flags[2] = 1'd0;
            
          if (res > value_before_operation) //carry
            flags[1] = 1'd1;
          else
            flags[1] = 1'd0;
            
          if (same_sign == 1'd1 && sign_before_operation != res[15]) //overflow
            flags[0] = 1'd1;
          else
            flags[0] = 1'd0;
            
       end
       
       6'b010101: begin //TST
          if (IMMEDIATE == 16'd0) begin
            sign_before_operation = ACC[15];
            value_before_operation = ACC;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (ACC[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC & X;
            end
            else begin
              if (ACC[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = ACC & Y;
            end
          end
          else begin
            sign_before_operation = IMMEDIATE[15];
            value_before_operation = IMMEDIATE;
            if (REGISTER_ADDRESS == 1'd0) begin
              if (IMMEDIATE[15] == X[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = X & IMMEDIATE; 
            end
            else begin
              if (IMMEDIATE[15] == Y[15])
                same_sign = 1'd1;
              else
                same_sign = 1'd0;
              res = Y & IMMEDIATE; 
            end
          end
        
          flags[0] = 1'd0;
          flags[1] = 1'd0;
          
          if  (res ==  16'd0)//zero 
            flags[3] = 1'd1;
          else 
            flags[3] = 1'd0;
            
          if (res[15] == 1'd1)//negative
            flags[2] = 1'd1;
          else
            flags[2] = 1'd0;
            
      end

       
       6'b010110: begin //INC
          sign_before_operation = 1'b0;
          value_before_operation = 16'd1;
          if (REGISTER_ADDRESS == 1'd0) begin
            if (1'd0 == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X + 16'd1;
         end
          else begin
            if (1'd0 == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y + 16'd1;
          end
           
        if  (res ==  16'd0) //zero
          flags[3] = 1'd1;
        else 
          flags[3] = 1'd0;
          
        if (res[15] == 1'd1) //negative
          flags[2] = 1'd1;
        else
          flags[2] = 1'd0;
          
        if (res < value_before_operation) //carry
          flags[1] = 1'd1;
        else
          flags[1] = 1'd0;
          
        if (same_sign == 1'd1 && sign_before_operation != res[15])//overflow
          flags[0] = 1'd1;
        else
          flags[0] = 1'd0;
    end
    
    
       6'b010111: begin //DEC
          sign_before_operation = 1'b0;
          value_before_operation = 16'd1;
          if (REGISTER_ADDRESS == 1'd0) begin
            if (1'd0 == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X - 16'd1;
         end
          else begin
            if (1'd0 == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y - 16'd1;
          end
          
        if  (res ==  16'd0) //zero
          flags[3] = 1'd1;
        else 
          flags[3] = 1'd0;
              
        if (res[15] == 1'd1)//negative
          flags[2] = 1'd1;
        else
          flags[2] = 1'd0;
          
        if (res > value_before_operation) //carry
          flags[1] = 1'd1;
        else
          flags[1] = 1'd0;
               
        if (same_sign == 1'd1 && sign_before_operation != res[15]) //overflow
          flags[0] = 1'd1;
        else
          flags[0] = 1'd0;
    end
      
     endcase
      
    end
  end
  
endmodule
