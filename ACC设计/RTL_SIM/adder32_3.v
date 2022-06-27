/**
----------------------------------------------------------------
Module Name  : adder32
----------------------------------------------------------------
**/

module adder32_3(
	input clk ,
	input rst_n ,
	
	input signed [31:0] in1 ,
	input signed [31:0] in2 ,
	input signed [31:0] in3 ,
	output signed [31:0] out
);

	reg signed [32:0] result33bit ;
	assign out = result33bit[31:0] ;

	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			result33bit <= 33'h0 ;
		else
			result33bit <= in1 + in2 + in3 ;
	end

endmodule
