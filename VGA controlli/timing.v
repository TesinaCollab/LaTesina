module timing(

input clk		,
input rst_n		,

output hsync	,
output vsync	,
output blank_n	,
output sync_n	,

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
// REGISTRI
//==========================

reg 

//==========================
// ISTRUZIONI
//==========================

always@(posedge clk or negedge rst_n)
begin

end	//always 


endmodule	//timing 

