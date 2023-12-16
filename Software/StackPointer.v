module StackPointer(
  input CLK,RST,INC,DEC,
  output reg [15:0] OUT);
  
  always @(negedge CLK, negedge RST)
  //Dac? RST este activ, valoarea de ie?ire (OUT) este resetat? la 16'b0000000111111111.
  //Dac? semnalul DEC este activ, valoarea de ie?ire (OUT) este decrementat? cu 1.
  begin
     if (!RST) begin
        OUT <= 16'b0000000111111111;
     end   
   else if (DEC) begin
        OUT <= OUT - 16'd1;
   end 
  end
  
  always @(posedge CLK) begin
    //la fiecare front pozitiv al semnalului CLK:
    //daca semnalul INC este activ si valoarea de ie?ire este mai mica decat 16'b0000000111111111 => valoarea de iesire ++
    #1
    if (INC && OUT < 16'b0000000111111111) begin
        OUT <= OUT + 16'd1;  
   end
  end
  
endmodule
