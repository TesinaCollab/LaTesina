module rettangolo(
//Posizione del centro
input [10:0] X_POS,
input [10:0] Y_POS,
//Controllo
input [10:0] X_CONTROLLO,
input [10:0] Y_CONTROLLO,

output CONFERMA
);

parameter altezza = 100;
parameter larghezza = 100;
parameter H = 1280;
parameter V = 1024;


wire [10:0]xDiff = H - X_POS;
wire [10:0]yDiff = V - Y_POS;
wire xUnder, yUnder;

wire orizz,vert;
	

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

output CONFERMA, //disegna solo la cornicetta
output esterno, //conferma del rettangolo esterno 
output interno //conferma del rettangolo interno 
);

wire out, in;
assign esterno = out;
assign interno = in;

parameter altezza = 100;
parameter larghezza = 100;
parameter spessore = 6;

parameter spessore2 = spessore / 2;

parameter altint = altezza - spessore;
parameter largint = larghezza - spessore;

rettangolo#(altezza,larghezza) attorno(X_POS,Y_POS,X_CONTROLLO,Y_CONTROLLO,out);
rettangolo#(altint,largint) dentro(X_POS + spessore2,Y_POS + spessore2,X_CONTROLLO,Y_CONTROLLO,in);

assign CONFERMA = (out)? out && !in :0 ;

endmodule
