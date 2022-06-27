/**
----------------------------------------------------------------
Module Name  : adderTree
Sub Module   : 8 adder32
----------------------------------------------------------------
**/

module adderTree(
	input clk ,
	input rst_n ,
	
	input signed [14:0] in1 ,
	input signed [14:0] in2 ,
	input signed [14:0] in3 ,
	input signed [14:0] in4 ,
	input signed [14:0] in5 ,
	input signed [14:0] in6 ,
	input signed [14:0] in7 ,
	input signed [14:0] in8 ,
	input signed [14:0] in9 ,
	
	output signed [31:0] out 
	
);
	// Expending sign bit
	wire signed [31:0] in1_ex ;
	wire signed [31:0] in2_ex ;
	wire signed [31:0] in3_ex ;
	wire signed [31:0] in4_ex ;
	wire signed [31:0] in5_ex ;
	wire signed [31:0] in6_ex ;
	wire signed [31:0] in7_ex ;
	wire signed [31:0] in8_ex ;
	wire signed [31:0] in9_ex ;
	
	assign in1_ex = {{17{in1[14]}},{in1}} ;
	assign in2_ex = {{17{in2[14]}},{in2}} ;
	assign in3_ex = {{17{in3[14]}},{in3}} ;
	assign in4_ex = {{17{in4[14]}},{in4}} ;
	assign in5_ex = {{17{in5[14]}},{in5}} ;
	assign in6_ex = {{17{in6[14]}},{in6}} ;
	assign in7_ex = {{17{in7[14]}},{in7}} ;
	assign in8_ex = {{17{in8[14]}},{in8}} ;
	assign in9_ex = {{17{in9[14]}},{in9}} ;

	wire signed [31:0] bufA_L1 ;
	wire signed [31:0] bufB_L1 ;
	wire signed [31:0] bufC_L1 ;
	wire signed [31:0] bufD_L1 ;
	reg  signed [14:0] bufE_L1 ;
	
	adder32 adder32_1_0(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(in1_ex),
		.in2 	(in2_ex),
		.out	(bufA_L1)
	);
	
	adder32 adder32_1_1(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(in3_ex),
		.in2 	(in4_ex),
		.out	(bufB_L1)
	);
	
	adder32 adder32_1_2(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(in5_ex),
		.in2 	(in6_ex),
		.out	(bufC_L1)
	);
	
	adder32 adder32_1_3(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(in7_ex),
		.in2 	(in8_ex),
		.out	(bufD_L1)
	);
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			bufE_L1 <= 15'h0 ;
		else
			bufE_L1 <= in9 ;
	end
	
	wire signed [31:0] bufA_L2 ;
	wire signed [31:0] bufB_L2 ;
	reg  signed [14:0] bufC_L2 ;
	
	adder32 adder32_2_0(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(bufA_L1),
		.in2 	(bufB_L1),
		.out	(bufA_L2)
	);
	
	adder32 adder32_2_1(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(bufC_L1),
		.in2 	(bufD_L1),
		.out	(bufB_L2)
	);
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			bufC_L2 <= 15'h0 ;
		else
			bufC_L2 <= bufE_L1 ;
	end
	
	wire signed [31:0] bufA_L3 ;
	reg  signed [14:0] bufB_L3 ;
	wire signed [31:0] bufB_L3_ex ;
	
	assign bufB_L3_ex = {{17{bufB_L3[14]}},{bufB_L3}} ;
	
	adder32 adder32_3_0(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(bufA_L2),
		.in2 	(bufB_L2),
		.out	(bufA_L3)
	);
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			bufB_L3 <= 15'h0 ;
		else
			bufB_L3 <= bufC_L2 ;
	end
	
	wire signed [31:0] bufA_L4 ;
	assign out = bufA_L4 ;
	
	adder32 adder32_4_0(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(bufA_L3),
		.in2 	(bufB_L3_ex),
		.out	(bufA_L4)
	);
	

endmodule