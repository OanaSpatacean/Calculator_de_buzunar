module DataMemory(
  input CLK,RST,EN,
  input [8:0] ADDR,
  input signed [15:0] in,
  output reg signed [15:0] out
);

reg signed [15:0] RAM [511:0];

always @(negedge RST) begin // la fiecare tranzitie negativa a lui RST
  if (!RST) begin
    out <= RAM[0];   // cand RST == 0, iesirea out este setata la valoarea de la adresa 0 din memorie
 end
end

always @(*) begin //la orice schimbare a semnalelor de intrare
  out <= RAM[ADDR];  //out este setata la valoarea memoriei la adresa specificata de ADDR 
end

always @(negedge CLK) begin // la fiecare tranzitie negativa a semnalului de CLK
  if (EN) begin //daca semnalul w este 1, datele de intrare in sunt scrise in memorie la adresa specificata de ADDR
    RAM[ADDR] <= in;
 end
end

endmodule