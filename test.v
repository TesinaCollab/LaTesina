module test( );

reg rst;
wire clk;
wire hsync, vsync, blank_n, sync_n, disp_enable;
wire [31:0]Xpix, Ypix;
wire R,G,B;

timing #(
.H_disp	(640),
.H_front(16),
.H_sync (96),
.H_back	(48),
.V_disp	(480),
.V_front(10),
.V_sync (2),
.V_back	(33)	
) testingtime(clk, rst, hsync, vsync, blank_n, sync_n, disp_enable, Xpix, Ypix);

testscreen #(.H(640),.V(480)) screen(Xpix, Ypix, disp_enable, rst, clk, R,G,B);

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
	/*
			if (X<(H/2)&&Y<(V/2))begin
			r <= 1;
			b <= 0;
			g <= 0;
		end
		else if (X>(H/2)&&Y<(V/2))begin
			r <= 0;
			b <= 1;
			g <= 0;
		end
		else if (X<(H/2)&&Y>(V/2))begin
			r <= 0;
			b <= 0;
			g <= 1;
		end
		else if (X>(H/2)&&Y>(V/2))begin
			r <= 0;
			b <= 0;
			g <= 0;
		end*/
		if (X<(H/2-4)&&Y<(V/2-4))begin
			r <= 1;
			b <= 0;
			g <= 0;
		end
		else if (X>(H/2+4)&&Y<(V/2-4))begin
			r <= 0;
			b <= 1;
			g <= 0;
		end
		else if (X<(H/2-4)&&Y>(V/2+4))begin
			r <= 0;
			b <= 0;
			g <= 1;
		end
		else if (X>(H/2+4)&&Y>(V/2+4))begin
			r <= 0;
			b <= 0;
			g <= 0;
		end
		else begin
			r <= 1;
			b <= 1;
			g <= 1;
		end
	end
end
endmodule

module myclock(
 output reg clk
 );
 always begin
		#20000 clk=1;//39.721ns/2
		#20000 clk=0;//25.175Mhz! per 640x480 @ 60Hz
		//#4629 clk=1;//9.259ns/2
		//#4629 clk=0;//108Mhz!
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