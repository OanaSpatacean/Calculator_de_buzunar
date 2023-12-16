module SignalExtender9x16( 
  input [8:0] IN, 
  output reg [15:0] OUT 
); 

always @* begin 
  OUT <= { {7{IN[8]}}, IN[8:0] }; 
end 

endmodule 