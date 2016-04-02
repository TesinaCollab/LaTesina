/********************************************
 * realizzo una cornice attorno allo schermo
 ********************************************/
module attorno(
	       input 		VGA_CLK,
	       input 		disp_en,
	       //coordinate
	       input [10:0] 	x,
	       input [10:0] 	y,
	       //colori
	       output reg [7:0] r,
	       output reg [7:0] g,
	       output reg [7:0] b
	       );
   //=============
   //parametri
   //=============
   parameter H = 1280;
   parameter V = 1024;

   parameter spessore = 21;
   
   parameter full = 8'hff;
   parameter empty = 8'b0;
   //=============
   //struttura
   //=============
   
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
	   if (x < spessore&&!(y > V-spessore))begin
	      r <= full;
	      b <= full;
	      g <= full;
	   end
	   else if (y < spessore)begin
	      r <= empty;
	      b <= full;
	      g <= full;
	   end
	   else if (x > H-spessore)begin
	      r <= full;
	      b <= full;
	      g <= empty;
	   end
	   else if (y > V-spessore)begin
	      r <= full;
	      b <= empty;
	      g <= full;
	   end
	   else begin//all'interno della cornice sfumo il blu
	      r <= empty;
	      b <= (full - y[10:2]);
	      g <= empty;
	   end
	end // if (disp_en)
	else begin
	   r <= empty;
	   b <= empty;
	   g <= empty;
	end // else: !if(disp_en)
     end // always@ (posedge VGA_CLK)
endmodule


/* alternativa che abbiamo deciso di non utilizzare
 //QUADRATI
 always@(posedge VGA_CLK or negedge reset)begin
 if(!reset)begin
 r <= empty;
 b <= empty;
 g <= empty;
	end else if(disp_en) begin
 
 if (x < (H/2-4) && y < (V/2-4))begin
 r <= full;
 b <= empty;
 g <= empty;
		end
 else if (x > (H/2+4) && y < (V/2-4))begin
 r <= empty;
 b <= full;
 g <= empty;
		end
 else if (x<(H/2-4) && y>(V/2+4))begin
 r <= empty;
 b <= empty;
 g <= full;
		end
 else if (x>(H/2+4) && y>(V/2+4))begin
 r <= full;
 b <= empty;
 g <= full;
		end
 else begin
 r <= full;
 b <= full;
 g <= full;
		end
	end
end
 */
