module test( );

reg rst;
wire clk;

timing #(
.H_disp	(20),
.H_front(1),
.H_sync (3),
.H_back	(10),
.V_disp	(15),
.V_front(1),
.V_sync (3),
.V_back	(10)	
) testingtime(clk, rst, hsync, vsync, blank_n, sync_n, disp_enable, Xpix, Ypix);

myclock clock(clk);

initial
begin
	
rst	=	0	;
#5	
rst	=	1	;
	
end

endmodule // test

 module myclock(
 output reg clk
 );
 integer i;
  initial begin
   for(i=0;i<100;i=i+1) begin
		#1 clk=1;
		#1 clk=0;
	end
end

endmodule // myclk