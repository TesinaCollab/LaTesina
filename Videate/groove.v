module movimenti(
input VGA_CLK,
input VGA_VS,
input disp_en,
input [3:0]KEY,
input [9:0]SW,
input enable,
//coordinate
input [10:0]x,
input [10:0]y,
//colori
output reg [7:0]r,
output reg [7:0]g,
output reg [7:0]b,
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5
);
parameter H = 1280;
parameter V = 1024;
//rettangolo
parameter altezza = 300;
parameter larghezza = 400;
parameter spessore = 20;

parameter full = 8'hff;
parameter empty = 8'b0;

wire reset;
assign reset = KEY[0];

reg [10:0] posx = (H/2);
reg [10:0] posy = (V/2);
wire here;//la cornice
wire in;//l'interno

//7segmenti
wire [3:0] d3,d2,d1,d0;
wire [6:0] unused;
BIN20to6BCD segmenti(
.binary ({10'd0,((enable)?((SW[9])?posx:posy):10'd0)}),
.D3 (d3),
.D2 (d2),
.D1 (d1),
.D0 (d0)
);

cornicetta #(
.altezza (altezza),
.larghezza (larghezza),
.spessore(spessore)
) RET(
.X_POS (posx),
.Y_POS (posy),
//Controllo
.X_CONTROLLO (x),
.Y_CONTROLLO (y),

.CONFERMA (here),
.interno(in)

);

//gestione BCD
	bcdtoHex zero(
.inBCD (4'd0),
.outHEX (unused)
);

bcdtoHex cifra1(
.inBCD (d1),
.outHEX (HEX1)
);

bcdtoHex cifra2(
.inBCD (d2),
.outHEX (HEX2)
);


bcdtoHex cifra3(
.inBCD (d0),
.outHEX (HEX0)
);

bcdtoHex cifra4(
.inBCD (d3),
.outHEX (HEX3)
);

assign HEX5 = unused;
assign HEX4 = unused;
	//fine gestione BCD


initial
begin
r <= empty;
b <= empty;
g <= empty;
end

always@(posedge VGA_VS or negedge reset)
begin
	if (!reset)
	begin
	posx = (H/2 - larghezza/2);
	posy = (V/2 - altezza/2);
	end
	else
	begin
		if (!KEY[1])
		begin
			if (SW[0])
			begin
				if (posx == H)
				posx <= 10'd0;
				else
				posx <= posx + 10'd1;
			end
			else
			begin
				if (posx == (10'd0))
				posx <= H ;
				else
				posx <= posx - 10'd1;
			end
		end
		else
			posx <= posx;
	
		if (!KEY[2])
		begin
			if (SW[1])
			begin
				if (posy == V)
				posy <= 10'd0;
				else
				posy <= posy + 10'd1;
			end
			else
			begin
				if (posy == (10'd0))
				posy <= V ;
				else
				posy <= posy - 10'd1;
			end
		end
		else
		posy <= posy;

	end
	end
	//SCHERMO
always@(posedge VGA_CLK)
begin
	if(disp_en) 
	begin
		if (here)
		begin
		r <= full;
		g <= empty;
		b <= empty;
		end
		else if(in) begin
		r <= empty;
		g <= full;
		b <= empty;
		end else
		begin
		r <= empty;
		g <= empty;
		b <= full;
		end
	end
end

endmodule
