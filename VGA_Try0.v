module VGA_Try0(
		//////////// CLOCK //////////
		input 	     CLOCK_50,
		input 	     CLOCK2_50,
		input 	     CLOCK3_50,
		input 	     CLOCK4_50,

		//////////// SEG7 //////////
		output [6:0] HEX0,
		output [6:0] HEX1,
		output [6:0] HEX2,
		output [6:0] HEX3,
		output [6:0] HEX4,
		output [6:0] HEX5,

		//////////// KEY //////////
		input [3:0]  KEY, 

		//////////// LED //////////
		output [9:0] LEDR,

		//////////// SW //////////
		input [9:0]  SW,

		//////////// VGA //////////
		output [7:0] VGA_B,
		output 	     VGA_BLANK_N,
		output 	     VGA_CLK,
		output [7:0] VGA_G,
		output 	     VGA_HS,
		output [7:0] VGA_R,
		output 	     VGA_SYNC_N,
		output 	     VGA_VS,


		//////////// GPIO_1, GPIO_1 connect to GPIO Default //////////
		inout [35:0] GPIO1GPIO
		);
   //=======================================================
   //  REG/WIRE declarations
   //=======================================================
   wire 		     reset;
   //relativi alla VGA
   wire 		     disp_en;//tempo in cui posso visualizzare i pixel
   wire 		     vEnable,hEnable;// i display time
   //pixel attuale
   wire [31:0] 		     x;
   wire [31:0] 		     y;
   //i colori dei vari schermi per le dismostrazioni
   wire [7:0] 		     r1,g1,b1;
   wire [7:0] 		     r2,g2,b2;
   wire [7:0] 		     r3,g3,b3;
   wire [7:0] 		     r4,g4,b4;
   //i fili dal mux di selezione delle schermate all'enable per l'ADV7123
   wire [7:0] 		     r,g,b;
   //il selettore dei quattro schermi
   reg [1:0] 		     states;
   //=======================================================
   //  parameters declarations
   //=======================================================
   //parametri per i timing della VGA, spiegazione accurata in timing_stm.v
   //questi sono selezionati per uno schermo 1280x1024 @ 60Hz
   //su internet sono facili da reperire
   //per H sono impulsi di clock
   parameter H = 1280;
   parameter Hf = 48;
   parameter Hs = 112;
   parameter Hb = 248;
   //per V sono righe
   parameter V = 1024;
   parameter Vs = 3;
   parameter Vf = 1;
   parameter Vb = 38;
   //colori
   parameter full = 8'hff;
   parameter empty = 8'b0;
   
   //=======================================================
   //  Structural coding
   //=======================================================
   assign reset = KEY[0];
   //Usiamo i GPIO per avere un po' di output per il debug
   assign GPIO1GPIO[5:0]={VGA_CLK,disp_en,VGA_HS,VGA_VS,vEnable,hEnable};
   //il blank fa diventare lo schermo nero noi lo teniamo fisso a 1
   assign VGA_BLANK_N = 1'b1;
   assign LEDR[1] = VGA_BLANK_N ;
   
   //mux prinipali per spegnere i dac quando la riga non deve essere visualizzata
   assign disp_en = vEnable && hEnable;
   assign VGA_R = (disp_en)?r:empty;
   assign VGA_G = (disp_en)?g:empty;
   assign VGA_B = (disp_en)?b:empty;
   //mux per la selezione dello schermo
   assign r = (states==2'b00)?r1:((states==2'b01)?r2:((states==2'b10)?r3:(r4)));
   assign g = (states==2'b00)?g1:((states==2'b01)?g2:((states==2'b10)?g3:(g4)));
   assign b = (states==2'b00)?b1:((states==2'b01)?b2:((states==2'b10)?b3:(b4)));
   
   //modulo creato con una megafunzione
   // (vedi ipcatalog dal menu view->Utility Windows)
   PLL pll(	
		.refclk(CLOCK_50),//clock di partenza, deve essere 50 MHz per come abbiamo impostato le cose
		.rst(~reset),
		.outclk_0(VGA_CLK),//uscita del clock a 108MHz
		.locked(LEDR[9])// se il led e` acceso il PLL funziona
		);

   //spiegazioni in timing.v
   timing#(
	   .H_disp(H),
	   .V_disp(V),
	   .H_front(Hf),
	   .H_sync(Hs),
	   .H_back(Hb),
	   .V_sync(Vs),
	   .V_front(Vf),
	   .V_back(Vb)
	   )
   tm(
      .clk(VGA_CLK),
      .rst_n(reset),
      //direttamente alla porta
      .hsync(VGA_HS),
      .vsync(VGA_VS),
      //al ADV7123
      .sync_n(VGA_SYNC_N),
      .Xpix (x),
      .Ypix (y),
      .vEnable (vEnable),
      .hEnable (hEnable)
      );
   //questi moduli servono ad alternare le schermate
   //abbiamo preferito creare moduli per non aggiungere
   //troppe righe di codice al modulo principale e renderlo piu` leggibile
   megapixel#(H,V,(H-20)/3,20/4)  uno(
			.VGA_CLK(VGA_CLK),
			.disp_en(disp_en),
			.x(x),
			.y(x),
			.r(r1),
			.g(g1),
			.b(b1)
			);
   colori#(H,V)  i_triangoli(
			     .VGA_CLK(VGA_CLK),
			     .disp_en(disp_en),
			     .x(x),
			     .y(x),
			     .r(r2),
			     .g(g2),
			     .b(b2)
			     );
   
   attorno#(H,V)  cornice(
			  .VGA_CLK(VGA_CLK),
			  .disp_en(disp_en),
			  .x(x),
			  .y(x),
			  .r(r3),
			  .g(g3),
			  .b(b3)
			  );

   movimenti#(H,V) muv(
		       .VGA_CLK(VGA_CLK),
		       .disp_en(disp_en),
		       .x(x),
		       .y(x),
		       .r(r4),
		       .g(g4),
		       .b(b4)
		       .KEY(KEY),
		       .SW(SW),
		       //attiva lo schermo solo se e` nello stato giusto
		       .enable(states==2'b11),
		       .HEX0(HEX0),
		       .HEX1(HEX1),
		       .HEX2(HEX2),
		       .HEX3(HEX3),
		       .HEX4(HEX4),
		       .HEX5(HEX5)
		       );
   //selezione dello schermo:
   initial
     begin
	states = 2'b0;
     end

   always@(negedge KEY[3])
     begin
	states=states+2'b1;
	//volutamente il reset non riporta il counter al primo schermo
     end
   
endmodule
