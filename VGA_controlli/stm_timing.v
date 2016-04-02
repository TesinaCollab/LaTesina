/**************************************************************************************
 *  Questo modulo fornisce in uscita il display time e il segnale di sincronia(negato)
 * seguendo le indicazioni per usare una vga:
 * prima del segnale di sincronia devo attendere un tempo detto "front porch",
 * manfare il segnale di sincronia per un tempo preciso,
 * attendere per un altro intervallo detto "back porch",
 * dopo il quale invio allo schermo le informazioni sui pixel (e questo viene detto display time).
 * durante il display time per il segnale orizzontale invio i colori del pixel della linea
 * durante il display time per il segnale verticale invio le informazioni allo schermo
 * i tempi "morti" servono ai vecchi tubi catodici per allineare il cannone a inizio riga/colonna
 * ogni segnale di sincronia verticale indica che e` il momento di visualizzare il frame sucessivo
 * ogni segnale di sincronia orizzontale indica allo schermo che sta per ricevere le informazioni relative alla riga sucessiva
 ***********************************************************************************/

module stm_timing(
		  input      clk,
		  input      rst_n,

		  output     o_sync,
		  output reg o_disp      
		  );
   //==========================
   // PARAMETRI
   //==========================
   parameter Disp = 1280;
   parameter Front = 48;
   parameter Sync = 112;
   parameter Back = 248;
   parameter Total = Disp + Front + Sync + Back;
   //==========================
   // REG E WIRES
   //==========================
   reg [10:0] 		     count;
   reg 			     sync;
   //==========================
   // INT STRUCT
   //==========================
   //cosi` quando resetto sync viene cambiato sul valore 0
   assign	o_sync = ~sync;
   
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
	     //aumento il timer o lo resetto
	     if(count < Total)
	       count <= count + 11'd1;
	     else
	       begin
		  count <= 11'd0;
		  o_disp <= 0;
	       end
	     //controlli per il segnale di sincronia
	     if(count == (Front - 1))//impulso sincronia dopo il front
	       sync <= 1;
	     if(count == (Front + Sync - 1))//fine impulso sincronia
	       sync <= 0;
	     //il segnale del display inizia dopo il back e finisce prima del front, assieme al timer che si resetta
	     if(count == (Back + Front + Sync - 1))
	       o_disp <= 1;
	  end//else rst_n
     end //always
endmodule //stm_timing
