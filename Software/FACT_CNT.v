module FACT_CNT(
  input [8:0] CNT,
  input CLK, RST, EN,
  output reg [8:0] OUT,
  output reg FACT_END);

  always @(posedge CLK, negedge RST) begin
    if (!RST) begin
      OUT = 9'd0; 
      FACT_END = 1'd0; 
    end
    else begin
       if (EN) begin
          if (CNT == 9'd0) begin
            // tratarea cazului in care se calculeaza factorial de 0
            OUT = CNT;
            FACT_END = 1'd1;
            #6 FACT_END = 1'd0;
          end  
        else begin
          OUT = CNT;  
        end
       end
       else if (OUT > 9'd0) OUT = OUT - 9'd1; 

       if (OUT == 9'd1) FACT_END = 1'd1; // calculul factorialului se incheie cand timer-ul ajunge la 1
       else if (OUT == 9'd0) FACT_END = 1'd0;
    end
  end

endmodule

