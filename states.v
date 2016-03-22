module states(
	input clk,
	input reset
);

reg stateholder;

always@(posedge clk or negedge reset) 
begin
	if(!reset)
		stateholder <= 0;
	else
		stateholder <= 1;
end

endmodule // states
