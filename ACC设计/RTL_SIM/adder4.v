/**
----------------------------------------------------------------
Module Name  : adder4
Sub Module   : adder32
----------------------------------------------------------------
**/

module adder4(
	input clk ,
	input rst_n ,
	input signed [31:0] in1 ,
	input signed [31:0] in2 ,
	input signed [31:0] in3 ,
	input signed [31:0] in4 ,
	
	output signed [7:0] out
);

	wire signed [31:0] buf1 ;
	wire signed [31:0] buf2 ;
	wire signed [31:0] out_32bit  ;
	
	assign out = {{out_32bit[31]},{out_32bit[13:7]}} ;

	adder32 adder32_1_0(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(in1),
		.in2 	(in2),
		.out	(buf1)
	);
	
	adder32 adder32_1_1(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(in3),
		.in2 	(in4),
		.out	(buf2)
	);
	
	adder32 adder32_2(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(buf1),
		.in2 	(buf2),
		.out	(out_32bit)
	);

endmodule
