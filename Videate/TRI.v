module colori(
input VGA_CLK,
input disp_en,
//coordinate
input [10:0]x,
input [10:0]y,
//colori
output reg [7:0]r,
output reg [7:0]g,
output reg [7:0]b
);
parameter H = 1280;
parameter V = 1024;
 parameter H3 = 1260/3;
parameter full = 8'hff;
parameter empty = 8'b0;

parameter myX =440;
parameter myY =312;

wire wR,wG,wB;

triangolo#(300) R(myX,myY,x,y,wR);
triangolo#(300) G(myX,myY-100,x,y,wG);
triangolo#(300) B(myX+100,myY,x,y,wB);

initial
begin
r <= empty;
b <= empty;
g <= empty;
end

//CORNICE
always@(posedge VGA_CLK)
begin
	if(disp_en) begin
			if (wR)
			r <= full;
			else
			r <= empty;
			
			if (wG)
			g <= full;
			else
			g <= empty;
			
			if (wB)
			b <= full;
			else
			b <= empty;
			
	end
end
endmodule
