module stm_timing(

input clk		,
input rst_n		,

);

//==========================
// PARAMETRI
//==========================

parameter Disp 	= 1280	;
parameter Front 	= 48		;
parameter Sync 	= 112		;
parameter Back		= 248		;


//==========================
// REG E WIRES
//==========================

reg	[1:0] 	states		;

reg	[10:0]	count_disp	;
reg	[10:0]	count_front	;
reg	[10:0]	count_sync	;
reg	[10:0]	count_back	;

wire [3:0] verifica	;

//==========================
// INT STRUCT
//==========================

assign	verifica[3] = count_disp 	< 	Disp	;
assign	verifica[2] = count_front 	< 	Front ;
assign	verifica[1] = count_sync 	< 	Sync	;
assign	verifica[0] = count_back 	<	Back 	;

always@(posedge clk or negedge rst_n)
begin
if (!rst_n)
	begin
	
	states <= 0	;
	
	count_disp	<=	0	;
	count_front	<=	0	;
	count_sync	<=	0	;
	count_back	<=	0	;
	
	end //if rst_n
else
	begin
	
	casex({verifica,states})
	xx1x_00	:	
		begin
		count_sync	<=	count_sync	+	1	;
		end // xx1x_00
	xx0x_00	:
		begin
		states	<=	2b'01	;
		count_sync	<=	0	;
		end // xx0x_00
	1xxx_01	:
		begin
		count_back	<=	count_back	+	1	;
		end // 1xxx_01
	0xxx_01	:
		begin
		states	<=	2b'11	;
		count_back	<=	0	;
		end // 0xxx_01
	xxx1_11	:
		begin
		count_disp	<=	count_disp	+	1	;
		end // xxx1_11
	xxx0_11	:
		begin
		states	<=	2b'10	;
		count_disp	<=	0	;
		end // xxx0_11
	x1xx_10	:
		begin
		count_front	<=	count_front	+	1	;
		end // x1xx_10
	x0xx_10	:
		begin
		states	<=	2b'10	;
		count_front	<=	0	;
		end // x0xx_10
		
	end
end //always


endmodule //stm_timing