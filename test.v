module test( );

reg rst;
wire clk;

stm_timing #(

.Disp	(15)	,
.Front(1)	,
.Sync (3)	,
.Back	(10)	

) a(clk,rst);

myclock ciccio(clk);

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