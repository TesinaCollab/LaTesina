module stm_timing(
		  input  clk,
		  input  rst_n,

		  output o_sync,
		  output reg o_disp      
		  );
   //==========================
   // PARAMETRI
   //==========================
   parameter Disp = 1280  ;
   parameter Front = 48;
   parameter Sync = 112;
   parameter Back = 248;
   parameter Total = Disp + Front + Sync + Back;
   //parameter Blank = Front + Sync + Back;
   //==========================
   // REG E WIRES
   //==========================
   reg [10:0]count;
   reg 	     sync;
   //==========================
   // INT STRUCT
   //==========================

   assign	o_sync = ~sync;//cosi` resetto a 0

   always@(posedge clk or negedge rst_n)
     begin
	if (!rst_n)
	  begin
	     count <= 11'd0;	 
	     sync <= 0;
	     o_disp <=0;
	  end //if rst_n
	else
	  begin
	     if(count < Total)
	       count <= count + 11'd1;
	     else
	       begin
		  count <= 11'd0;
		  o_disp <= 0;
	       end
	     if(count == (Front - 1))//impulso sincronia dopo il front
	       sync <= 1;
	     if(count == (Front + Sync - 1))//fine impulso sincronia
	       sync <= 0;
	     if(count == (Back + Front + Sync - 1))//dopo il back c'e` il display
	       o_disp <= 1;
	  end
     end //always
endmodule //stm_timing
