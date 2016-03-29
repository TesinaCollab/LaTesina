module conway(
	input clk,
	input rst_n,
	input deposit,
	input en_deposit,
	input [7:0] neightbours,
	output reg me
	);
	wire three, two,
	surrounded much(neightbours, two, three);
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n)
			me <= 0;//reset
		else if(en_deposit) beginbegin//viviamo?
			casex({two,three,me})begin
			3'bx0_0://non cambia nulla
				me <= 0;
			3'b00_1://morte per isolamento o per sovrapopolazione
				me <= 0;
			3'b01_1,3'b10_1://sopravvivenza
				me <= 1;
			3'b01_0://riproduzione
				me <= 1;
				/*compattabile in :
			3'bx0_0,3'b00_1:
				me <= 0;
			3'b01_1,3'b10_1,3'b01_0:
				me <= 1;
				*/
		end
	end
endmodule