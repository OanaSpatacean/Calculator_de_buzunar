module CORE_tb;
reg CLK;
reg RST;
integer i;
integer f;

CORE GPP(.CLK(CLK),.RST(RST));

initial begin
   $readmemb("test.fic", GPP.IM.ROM); 
   $display("rom load successfully\n");
   reset_dm;
   $display("RAM has been initalised\n");
   RST <= 1'b1;
   CLK <= 1'b0;
   #2 RST <= 1'b0;
   #1 RST <= 1'b1;
   $display("CPU has been initialised\n");
   for(i=0;i<10000;i=i+1) begin
     #3 CLK = ~CLK;
   end
   display_all_regs;
   display_dm;
end

task display_all_regs;
		begin
			$display("display_all_regs:");
			$display("------------------------------");
			$display("   ACC      X      Y  ");
			$write("%d ",GPP.ACC_VAL);
			$write("%d ",GPP.X_VAL);
			$write("%d \n",GPP.Y_VAL);
			$display("------------------------------");
			$display("FLAGS\n");
			$display("Z\tN\tC\tO\n");
			$display("%d\t%d\t%d\t%d\n",GPP.FlagsRegister.ZERO,GPP.FlagsRegister.NEGATIVE,GPP.FlagsRegister.CARRY,GPP.FlagsRegister.OVERFLOW);
		end
	endtask
	
task reset_dm;
    begin
      for(i=0;i<512;i=i+1) begin
          GPP.DM.RAM[i] = 16'd0;
      end
    end
endtask
	
task display_dm;
    begin
      f = $fopen("mem.txt","w");
      $display("Writing Data Memory contents to file..");
      for(i=0;i<512;i=i+1) begin
          $fwrite(f,"%d : %d\n",i,GPP.DM.RAM[i]);
      end
    end
endtask

endmodule
