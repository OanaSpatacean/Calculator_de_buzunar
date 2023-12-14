module BitConverter10x16( 
  input [9:0] in, 
  output reg [15:0] out 
); 
  
always @* begin 
   out = 16'b0; // Initialize with zeros 
   out[15:0] = in; // Assign the input to the lower bits 
end 

endmodule 