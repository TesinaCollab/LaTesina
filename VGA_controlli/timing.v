/* questo modulo unisce i due controlli verticale e orizzontale,
 * fornisce i segnali di sincronia da inviare allo schermo,
 * genera un segnale che indica quando mandare i dati all'ADV7123
 * e fornisce le coordinate del pixel da disegnare
 */
module timing(
	      input 		clk,
	      input 		rst_n,
	      //direttamente alla porta VGA
	      output 		hsync,
	      output 		vsync,
	      //al ADV7123
	      output 		blank_n,
	      output 		sync_n,
	      output 		vEnable,
	      output 		hEnable,
	      //al mux per i pixels
	      output 		disp_enable,
	      //coordinate del pixel
	      //parole enormi rispetto a quello che serve in realta`
	      output reg [31:0] Xpix,
	      output reg [31:0] Ypix
	      );

   //==========================
   // PARAMETRI ORIZZONTALI, in impulsi di clock
   //==========================
   parameter H_disp = 1280;
   parameter H_front = 48;
   parameter H_sync = 112;
   parameter H_back = 248;

   //==========================
   // PARAMETRI VERTICALI, in righe
   //==========================
   parameter V_sync = 3;
   parameter V_front = 1;
   parameter V_back = 38;
   parameter V_disp = 1024;

   //==========================
   // Struttura
   //==========================

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
   // i pixel devono lavorare quando non siamo nel blank time
   //a quanto pare questo non funziona, meglio fare l'operazione di &&
   //nel modulo in cui serve
   assign disp_enable = vEnable && hEnable;
   assign blank_n	= 1'b1;//disp_enable;//blank negato
   assign sync_n	= 1'b0;//disattiva i segnali di sincronia sul verde

   //fa avanzare il counter per i pixel orizzontali
   always@(posedge clk or negedge rst_n or negedge hEnable)begin
      if(~rst_n || ~hEnable) begin//reset
	 Xpix <= 0;
      end
      else if(disp_enable) begin
	 //avanza il counter del pixel sulla riga, se posso disegnare
	 Xpix <= Xpix + 1;
      end
   end

   always@(posedge hEnable or negedge rst_n or negedge vEnable)begin//avanza di una
      if(~rst_n || ~vEnable) begin//reset
	 Ypix <= 0;
      end
      else if(disp_enable) begin
	 //avanza il counter della riga, se posso disegnare
	 Ypix <= Ypix + 1;
      end
   end
endmodule	//timing 
