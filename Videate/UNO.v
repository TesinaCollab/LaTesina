/*visualizziamo i tre colori in tre rettangoli sullo schermo*/
module megapixel(
		 input 		  VGA_CLK,
		 input 		  disp_en,
		 //coordinate
		 input [10:0] 	  x,
		 input [10:0] 	  y,
		 //colori
		 output reg [7:0] r,
		 output reg [7:0] g,
		 output reg [7:0] b
		 );
   //================
   //parametri
   //================
   
   parameter H = 1280;
   parameter V = 1024;
   parameter H3 = 1260/3;//1280 non e` divisibile per 3
   parameter diff = 5;   
   
   //questi non adrebbero modificati
   parameter full = 8'hff;
   parameter empty = 8'b0;
   
   //================
   //Struttura
   //================

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
	   if (x >diff&&x<(diff+H3))
	     begin
		r <= full;
		b <= empty;
		g <= empty;
	     end
	   else if (x >(diff+H3+diff)&&x<(diff+H3+diff+H3))
	     begin
		r <= empty;
		b <= empty;
		g <= full;
	     end
	   else if (x >(diff+H3+diff+H3+diff)&&x<(diff+H3+diff+H3+diff+H3))
	     begin
		r <= empty;
		b <= full;
		g <= empty;
	     end
	   else
	     begin
		r <= empty;
		b <= empty;
		g <= empty;
	     end
	end // if (disp_en)
	else// in realta` e` ridondante se consideriamo il mux che abbiamo inculuso nem modulo principale
	  begin
	     r <= empty;
	     b <= empty;
	     g <= empty;
	  end // else: !if(disp_en)
     end // always@ (posedge VGA_CLK)
endmodule
