module timing(
input clk		,
input rst_n		,
//direttamente alla porta
output hsync	,
output vsync	,
//al ADV7123
output blank_n	,
output sync_n	,
//al mux per i pixels
output disp_enable,
output reg [31:0] Xpix,//parole enormi rispetto a quello che serve in realta`
output reg [31:0] Ypix
);

//==========================
// PARAMETRI ORIZZONTALI
//==========================

parameter H_disp 	= 1280	;
parameter H_front = 48		;
parameter H_sync 	= 112		;
parameter H_back 	= 248		;

//==========================
// PARAMETRI VERTICALI
//==========================

parameter V_sync 	= 3		;
parameter V_front = 1		;
parameter V_back 	= 38		;
parameter V_disp 	= 1024	;

//==========================
// Struttura
//==========================

wire vEnable, hEnable;

stm_timing #(
	.Disp	(H_disp),
	.Front(H_front),
	.Sync (H_sync),
	.Back	(H_back)	
) Htiming(
	.clk(clk),
	.rst_n(rst_n),
	.o_sync(hsync),
	.o_disp(hEnable)
);//sincronia orizzontale

stm_timing #(
.Disp	(V_disp),
.Front(V_front),
.Sync (V_sync),
.Back	(V_back)	
) VTiming(
	.clk(!hsync),//il timing verticale e` dato dalle linee orizzontali!
	.rst_n(rst_n),
	.o_sync(vsync),
	.o_disp(vEnable)
);//sincronia verticale
//==========================
// ISTRUZIONI
//==========================
assign disp_enable = vEnable && hEnable; // i pixel devono lavorare quando non siamo nel blank time
assign blank_n	= 1;//non uso l'opzione blank
assign sync_n	= 0;//disattiva i segnali di sincronia sul verde

always@(posedge clk or negedge rst_n)begin//avanza di una
	if(!rst_n) begin//reset
		Xpix <= 0;
	end
	else if(disp_enable) begin //avanza il counter della riga se posso disegnare
		Xpix <= Xpix+1;
	end
end

always@(negedge hsync or negedge rst_n)begin//avanza di una
	if(!rst_n) begin//reset
		Ypix <= 0;
	end
	else if(disp_enable) begin //avanza il counter della riga se posso disegnare
		Ypix <= Ypix+1;
	end
end

always@(negedge vEnable)begin
	Ypix <= 0;
end

always@(negedge hEnable)begin
	Xpix <= 0;
end
endmodule	//timing 

