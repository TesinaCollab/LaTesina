module surrounded( //asincrono
	input [7:0] neightbours,
	output by_2,
	output by_3
	);
	wire [3:0] sum;
	assign sum = neightbours[0] + neightbours[1] + neightbours[2] + neightbours[3] + neightbours[4] + neightbours[5] + neightbours[6] + neightbours[7];
	assign by_2 = sum == 2;
	assign by_3 = sum == 3;
endmodule
	