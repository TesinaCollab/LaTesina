//A test of life
module vita();
wire clk;
myclock theclk(clk);

endmodule

module myclock(
 output reg clk
 );
 always begin

		#1 clk=1;
		#1 clk=0;
 /* per linux
 integer i;
  initial begin
   for(i=0;i<100;i=i+1) begin
		#1 clk=1;
		#1 clk=0;
	end
	*/
end

endmodule // myclk