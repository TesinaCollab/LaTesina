module BIN20to6BCD(
	input [19:0] binary,//999999 e` il numero massimo visualizzabile
	output reg [3:0] D5,
	output reg [3:0] D4,
	output reg [3:0] D3,
	output reg [3:0] D2,
	output reg [3:0] D1,
	output reg [3:0] D0
);
integer i;
always@(binary)//ogni volta che cambia binary
	begin
	{D5,D4,D3,D2,D1,D0} = 24'd0;
	D0[0] = binary[19];//primo passo
	for(i=18; i>=0;i=i-1)
		begin
			if(D0 >= 4'd5)
				D0 = D0 + 4'd3;
			if(D1 >= 4'd5)
				D1 = D1 + 4'd3;
			if(D2 >= 4'd5)
				D2 = D2 + 4'd3;
			if(D3 >= 4'd5)
				D3 = D3 + 4'd3;
			if(D4 >= 4'd5)
				D4 = D4 + 4'd3;
			if(D5 >= 4'd5)
				D5 = D5 + 4'd3;
			//shifto a destra di 1
			{D5,D4,D3,D2,D1,D0} = {D5[2:0],D4,D3,D2,D1,D0,binary[i]};
			//chiedere se fare cosi` e` piu` rapido:
			//{D5,D4,D3,D2,D1,D0} <= {D5,D4,D3,D2,D1,D0} << 1;
			//D0[0] = binary[i];
		end
	end
endmodule


module bcdtoHex (
	input [3:0] inBCD,
	output [6:0] outHEX
	);
	reg [6:0] leds;
	
	assign outHEX = ~leds; // se bit==0 il led si accende
	always @(inBCD)
		case (inBCD)       //abcdefg
			0: leds = 7'b0111111;
			1: leds = 7'b0000110;
			2: leds = 7'b1011011;
			3: leds = 7'b1001111;
			4: leds = 7'b1100110;
			5: leds = 7'b1101101;
			6: leds = 7'b1111101;
			7: leds = 7'b0000111;
			8: leds = 7'b1111111;
			9: leds = 7'b1101111;
			10: leds = 7'b1110111;  // A
			11: leds = 7'b1111100;  // B
			12: leds = 7'b0111001;  // C
			13: leds = 7'b1011110;  // D
			14: leds = 7'b1111001;  // E
			15: leds = 7'b1110001;  // F
		endcase
		
endmodule

