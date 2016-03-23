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
output disp_enable
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

/*
always@(posedge clk or negedge rst_n)
begin

end	//always 
*/

endmodule	//timing 

