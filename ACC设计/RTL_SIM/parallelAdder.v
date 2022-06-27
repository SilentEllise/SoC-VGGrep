/**
----------------------------------------------------------------
Module Name  : parallelAdder
Sub Module	 : 4 adder32
----------------------------------------------------------------
**/

module parallelAdder(
	input clk ,
	input rst_n ,
	
	input [31:0] in1 ,
	input [31:0] in2 ,
	output[31:0] out
);

	wire signed [31:0] in1_ex1 , in1_ex2 , in1_ex3 , in1_ex4 ;
	wire signed [31:0] in2_ex1 , in2_ex2 , in2_ex3 , in2_ex4 ;
	
	wire signed [31:0] out1 , out2 , out3 , out4 ;
	
	assign out = {{{out1[31]},{out1[6:0]}},{{out2[31]},{out2[6:0]}},{{out3[31]},{out3[6:0]}},{{out4[31]},{out4[6:0]}}} ;
	
	assign in1_ex1 = {{24{in1[31]}},{in1[31:24]}} ;
	assign in1_ex2 = {{24{in1[23]}},{in1[23:16]}} ;
	assign in1_ex3 = {{24{in1[15]}},{in1[15: 8]}} ;
	assign in1_ex4 = {{24{in1[ 7]}},{in1[ 7: 0]}} ;
	
	assign in2_ex1 = {{24{in2[31]}},{in2[31:24]}} ;
	assign in2_ex2 = {{24{in2[23]}},{in2[23:16]}} ;
	assign in2_ex3 = {{24{in2[15]}},{in2[15: 8]}} ;
	assign in2_ex4 = {{24{in2[ 7]}},{in2[ 7: 0]}} ;

	adder32 adder32_1(
		.clk(clk) ,
		.rst_n(rst_n) ,
		.in1(in1_ex1) ,
		.in2(in2_ex1) ,
		.out(out1)
	);
	
	adder32 adder32_2(
		.clk(clk) ,
		.rst_n(rst_n) ,
		.in1(in1_ex2) ,
		.in2(in2_ex2) ,
		.out(out2)
	);
	
	adder32 adder32_3(
		.clk(clk) ,
		.rst_n(rst_n) ,
		.in1(in1_ex3) ,
		.in2(in2_ex3) ,
		.out(out3)
	);
	
	adder32 adder32_4(
		.clk(clk) ,
		.rst_n(rst_n) ,
		.in1(in1_ex4) ,
		.in2(in2_ex4) ,
		.out(out4)
	);

endmodule



