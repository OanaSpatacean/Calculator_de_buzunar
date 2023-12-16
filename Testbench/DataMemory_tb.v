module DataMemory_tb;
    reg CLK;
    reg RST;
    reg EN;
    reg [8:0] ADDR;
    reg signed [15:0] in;
    wire signed [15:0] out;

   //Unit Under Test
    DataMemory uut (
        .CLK(CLK), 
        .RST(RST), 
        .EN(EN), 
        .ADDR(ADDR), 
        .in(in), 
        .out(out)
    );

    always #5 CLK = ~CLK;

    initial begin
        // Initialize Inputs
        CLK = 0;
        RST = 1; // Start with reset active
        EN = 0;
        ADDR = 0;
        in = 0;

        // Wait for global reset
        #10;
        RST = 0; // Release reset
        #10;
        RST = 1;
        
        // Display initial values
        $display("Initial Values: CLK=%b, RST=%b, EN=%b, ADDR=%d, in=%d, out=%d", CLK, RST, EN, ADDR, in, out);

        // Write operation
        EN = 1; // Enable write
        ADDR = 9'd123; // Set address
        in = 16'sd456; // Set data to write
        #10;
        $display("After Write: ADDR=%d, in=%d, out=%d", ADDR, in, out);

        EN = 0; // Disable write
        #10;

        // Read operation
        ADDR = 9'd123; // Set address to read
        #10;
        $display("After Read: ADDR=%d, out=%d", ADDR, out);

        // Finish simulation
        $finish;
    end

    // Monitor changes
    always @(posedge CLK) begin
        $display("Time = %t : CLK=%b, RST=%b, EN=%b, ADDR=%d, in=%d, out=%d", $time, CLK, RST, EN, ADDR, in, out);
    end

endmodule

