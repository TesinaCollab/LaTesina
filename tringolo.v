/**Disegna un triangolo rettangolo isoscele*****
 * Il modulo riceve in input la posizione dell'angolo superiore del triangolo
 * e il punto attuale dello schermo
 * l'uscita e` positiva se la posizione del controllo e` all'interno del
 * triangolo
 * |\
 * | \
 * ----
 ***********************************************/
module triangolo(
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
   
   parameter lato = 100;
   
   //=============================
   //fili
   //=============================
   
   wire 		      okY, okX;
   wire [10:0] 		      diff;
   
   //=============================
   //struttura
   //=============================
   
   assign diff = Y_CONTROLLO-Y_POS;
   
   assign okY = (Y_CONTROLLO>Y_POS)&&(Y_CONTROLLO<(Y_POS+lato));
   assign okX = (X_CONTROLLO>X_POS)&&(X_CONTROLLO<(X_POS+diff));
   
   assign CONFERMA = okY && okX;

endmodule
