module BitConverter10x16( 
  input [9:0] IN, 
  output reg [15:0] OUT 
); 
  
always @* begin 
   OUT = 16'b0; // Initialize with zeros 
   OUT[15:0] = IN; // Assign the input to the lower bits 
end 

endmodule 