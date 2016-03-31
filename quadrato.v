module rettangolo(
//Posizione del rettangolo dall'angolo alto a sinistra
input [10:0] X_POS,
input [10:0] Y_POS,
//Controllo
input [10:0] X_CONTROLLO,
input [10:0] Y_CONTROLLO,

output CONFERMA
);

parameter altezza = 100;
parameter larghezza = 100;

assign CONFERMA = ((X_CONTROLLO > X_POS) && (Y_CONTROLLO > Y_POS))&&((X_CONTROLLO < (X_POS + larghezza)) && (Y_CONTROLLO < (Y_POS + altezza)));
		
		
endmodule

module cornicetta(
//Posizione del rettangolo dall'angolo alto a sinistra
input [10:0] X_POS,
input [10:0] Y_POS,
//Controllo
input [10:0] X_CONTROLLO,
input [10:0] Y_CONTROLLO,

output CONFERMA,
output esterno,
output interno
);
wire out, in;
assign esterno = out;
assign interno = in;
parameter altezza = 100;
parameter larghezza = 100;
parameter spessore = 6;
parameter altint = altezza-spessore;
parameter largint = larghezza-spessore;
rettangolo#(altezza,larghezza) attorno(X_POS,Y_POS,X_CONTROLLO,Y_CONTROLLO,out);
rettangolo#(altint,largint) dentro(X_POS+(spessore/2),Y_POS+(spessore/2),X_CONTROLLO,Y_CONTROLLO,in);

assign CONFERMA = (out)? out && !in :0 ;

endmodule
