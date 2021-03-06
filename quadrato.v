/*Disegna un rettangolo
 * Se i parametri di controllo sono all'interno del rettangolo
 * l'ouput CONTROLLO e` alto
 * in piu` se in rettangolo si sovrappone a un lato dello schermo viene 
 * visualizato su quello opposto
 */

module rettangolo(
		  //Posizione del centro
		  input [10:0] X_POS,
		  input [10:0] Y_POS,
		  //Controllo
		  input [10:0] X_CONTROLLO,
		  input [10:0] Y_CONTROLLO,

		  output       CONFERMA
		  );
   //=============================
   //parametri
   //=============================
   
   parameter altezza = 100;
   parameter larghezza = 100;
   parameter H = 1280;
   parameter V = 1024;

   //=============================
   // Fili
   //=============================

   wire [10:0] 		       xDiff = H - X_POS;
   wire [10:0] 		       yDiff = V - Y_POS;
   wire 		       xUnder, yUnder;

   wire 		       orizz,vert;

   //=============================
   //Struttura
   //=============================

   assign xUnder = (xDiff < larghezza);
   assign yUnder = (yDiff < altezza);


   assign orizz = (xUnder)?
		  ((X_CONTROLLO > X_POS)||(X_CONTROLLO < (larghezza - xDiff)))
     :((X_CONTROLLO > X_POS) && (X_CONTROLLO < (X_POS + larghezza)));

   assign vert = (yUnder)?
		 ((Y_CONTROLLO > Y_POS)||(Y_CONTROLLO < (altezza - yDiff)))
     :((Y_CONTROLLO > Y_POS) && (Y_CONTROLLO < (Y_POS + altezza)));

   assign CONFERMA = orizz && vert;
   

endmodule //rettangolo

module cornicetta(
		  //Posizione del centro
		  input [10:0] X_POS,
		  input [10:0] Y_POS,
		  //Controllo
		  input [10:0] X_CONTROLLO,
		  input [10:0] Y_CONTROLLO,

		  output       CONFERMA, //disegna solo la cornicetta
		  output       esterno, //conferma del rettangolo esterno 
		  output       interno //conferma del rettangolo interno 
		  );
   //=============================
   //parametri
   //=============================
   
   parameter altezza = 100;
   parameter larghezza = 100;
   parameter spessore = 6;
   parameter H = 1280;
   parameter V = 1024;
   //non modificare:
   parameter altint = altezza - spessore;
   parameter largint = larghezza - spessore;
   
   //=============================
   //Fili
   //=============================
   
   wire 		       out, in;
   parameter spessore2 = spessore / 2;
   wire [10:0] 		       Xint = ((X_POS + spessore2)>H)?(X_POS + spessore2-H):(X_POS + spessore2);
   wire [10:0] 		       Yint = ((Y_POS + spessore2)>V)?(Y_POS + spessore2-V):(Y_POS + spessore2);
   
   //=============================
   //Struttura
   //=============================
   assign esterno = out;
   assign interno = in;


   rettangolo#(altezza,larghezza,H,V) attorno(X_POS,Y_POS,X_CONTROLLO,Y_CONTROLLO,out);
   rettangolo#(altint,largint,H,V) dentro(Xint,Yint,X_CONTROLLO,Y_CONTROLLO,in);

   assign CONFERMA = (out)? out && !in :0 ;

endmodule
