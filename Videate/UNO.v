module megapixel(
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
		if (x >5&&x<(5+H3))begin
			r <= full;
			b <= empty;
			g <= empty;
		end
		else if (x >(5+H3+5)&&x<(5+H3+5+H3))begin
			r <= empty;
			b <= empty;
			g <= full;
		end
		else if (x >(5+H3+5+H3+5)&&x<(5+H3+5+H3+5+H3))begin
			r <= empty;
			b <= full;
			g <= empty;
		end
		else begin
			r <= empty;
			b <= empty;
			g <= empty;
		end
	end
	else begin
r <= empty;
b <= empty;
g <= empty;
end
end
endmodule
