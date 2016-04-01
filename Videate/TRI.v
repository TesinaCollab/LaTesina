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

wire wR,wG,wB;

triangolo#(300) R(400,500,x,y,wR);
triangolo#(300) G(400,600,x,y,wG);
triangolo#(300) B(500,600,x,y,wB);

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
