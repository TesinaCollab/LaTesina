module test( );

reg rst;
wire clk;
wire hsync, vsync, blank_n, sync_n, disp_enable;
wire [31:0]Xpix, Ypix;
wire R,G,B;

timing #(
.H_disp	(1280),
.H_front(48),
.H_sync (112),
.H_back	(248),
.V_disp	(1024),
.V_front(1),
.V_sync (3),
.V_back	(38)	
) testingtime(clk, rst, hsync, vsync, blank_n, sync_n, disp_enable, Xpix, Ypix);

testscreen screen(Xpix, Ypix, disp_enable, rst, clk, R,G,B);

myclock clock(clk);

initial
begin
	
rst	=	0	;
#5	
rst	=	1	;
	
end

endmodule // test

module testscreen(//temporaneo per usare VGASIM
	input [31:0] X,
	input [31:0] Y,
	input enable,
	input rst_n,
	input clk,
	output reg r,
	output reg g,
	output reg b
);
parameter H = 1280;
parameter V = 1024;
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		r <= 0;
		b <= 0;
		g <= 0;
	end else if(enable) begin
		if (X<H/2&&Y<V/2)begin
			r <= 1;
			b <= 0;
			g <= 0;
		end else if (Y<V/2)begin
			r <= 1;
			b <= 1;
			g <= 1;
		end else if (X<H/2)begin
			r <= 1;
			b <= 1;
			g <= 0;
		end begin
			r <= 1;
			b <= 0;
			g <= 1;
		end		
	end
end
endmodule

module myclock(
 output reg clk
 );
 always begin

		#4629 clk=1;//9.259ns/2
		#4629 clk=0;//108Mhz!
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