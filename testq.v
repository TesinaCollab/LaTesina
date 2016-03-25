module quadrati( );

reg rst;
wire clk;
wire hsync, vsync, blank_n, sync_n, disp_enable;
wire [31:0]Xpix, Ypix;
wire R,G,B;
wire Red,Green,Blue;

assign {R,G,B} = {Red&&disp_enable,Green&&disp_enable,Blue&&disp_enable};

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

cornice #(.H(640),.V(480)) screen(Xpix, Ypix, disp_enable, rst, clk, Red,Green,Blue);

myclock clock(clk);

initial
begin
	
rst	=	0	;
#5	
rst	=	1	;
	
end

endmodule // test

module cornice(
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
		if (X < 21)begin
			r <= 1;
			b <= 1;
			g <= 1;
		end
		else if (Y < 21)begin
			r <= 0;
			b <= 1;
			g <= 1;
		end
		else if (X > H-21)begin
			r <= 1;
			b <= 1;
			g <= 0;
		end
		else if (Y > V-21)begin
			r <= 1;
			b <= 0;
			g <= 1;
		end
		else begin
			r <= 0;
			b <= 1;
			g <= 0;
		end
	end
end
endmodule