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
parameter alt2 = altezza/2;
parameter larg2 = larghezza/2;
wire xUnder, yUnder;
wire xDiff = larg2- X_POS;
assign xUnder = (X_POS < larg2);
assign yUnder = Y_POS < alt2;
wire orizz,vert;
assign orizz = (xUnder)?((X_CONTROLLO > 0) && (X_CONTROLLO +< (X_POS + larg2))||(X_CONTROLLO > (H-diff))):((X_CONTROLLO > X_POS-larg2) && (X_CONTROLLO < (X_POS + larg2)));
assign vert = ((Y_CONTROLLO + alt2 > Y_POS) && (Y_CONTROLLO < (Y_POS + alt2)));
assign CONFERMA = orizz && vert;
		
		
endmodule //rettangolo

module cornicetta(
//Posizione del centro
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
rettangolo#(altint,largint) dentro(X_POS,Y_POS,X_CONTROLLO,Y_CONTROLLO,in);

assign CONFERMA = (out)? out && !in :0 ;

endmodule
