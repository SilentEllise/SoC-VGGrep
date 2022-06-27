/**
----------------------------------------------------------------
Module Name  : crossBar
Sub Module	 : adder4 , a module adds four 32bit numbers together
----------------------------------------------------------------
**/

module crossBar(
	input clk ,
	input rst_n ,
	
	input valid_i ,
	
	input signed [31:0] data_i_1A ,
	input signed [31:0] data_i_1B ,
	input signed [31:0] data_i_1C ,
	input signed [31:0] data_i_1D ,
	input signed [31:0] data_i_1E ,
	input signed [31:0] data_i_1F ,
	input signed [31:0] data_i_1G ,
	input signed [31:0] data_i_1H ,
	input signed [31:0] data_i_1I ,
	input signed [31:0] data_i_1J ,
	input signed [31:0] data_i_1K ,
	input signed [31:0] data_i_1L ,
	input signed [31:0] data_i_1M ,
	input signed [31:0] data_i_1N ,
	input signed [31:0] data_i_1O ,
	input signed [31:0] data_i_1P ,
	input signed [31:0] data_i_2A ,
	input signed [31:0] data_i_2B ,
	input signed [31:0] data_i_2C ,
	input signed [31:0] data_i_2D ,
	input signed [31:0] data_i_2E ,
	input signed [31:0] data_i_2F ,
	input signed [31:0] data_i_2G ,
	input signed [31:0] data_i_2H ,
	input signed [31:0] data_i_2I ,
	input signed [31:0] data_i_2J ,
	input signed [31:0] data_i_2K ,
	input signed [31:0] data_i_2L ,
	input signed [31:0] data_i_2M ,
	input signed [31:0] data_i_2N ,
	input signed [31:0] data_i_2O ,
	input signed [31:0] data_i_2P ,
	input signed [31:0] data_i_3A ,
	input signed [31:0] data_i_3B ,
	input signed [31:0] data_i_3C ,
	input signed [31:0] data_i_3D ,
	input signed [31:0] data_i_3E ,
	input signed [31:0] data_i_3F ,
	input signed [31:0] data_i_3G ,
	input signed [31:0] data_i_3H ,
	input signed [31:0] data_i_3I ,
	input signed [31:0] data_i_3J ,
	input signed [31:0] data_i_3K ,
	input signed [31:0] data_i_3L ,
	input signed [31:0] data_i_3M ,
	input signed [31:0] data_i_3N ,
	input signed [31:0] data_i_3O ,
	input signed [31:0] data_i_3P ,
	input signed [31:0] data_i_4A ,
	input signed [31:0] data_i_4B ,
	input signed [31:0] data_i_4C ,
	input signed [31:0] data_i_4D ,
	input signed [31:0] data_i_4E ,
	input signed [31:0] data_i_4F ,
	input signed [31:0] data_i_4G ,
	input signed [31:0] data_i_4H ,
	input signed [31:0] data_i_4I ,
	input signed [31:0] data_i_4J ,
	input signed [31:0] data_i_4K ,
	input signed [31:0] data_i_4L ,
	input signed [31:0] data_i_4M ,
	input signed [31:0] data_i_4N ,
	input signed [31:0] data_i_4O ,
	input signed [31:0] data_i_4P ,
	
	output reg valid_o ,
	
	output signed [7:0] data_o_A ,
	output signed [7:0] data_o_B ,
	output signed [7:0] data_o_C ,
	output signed [7:0] data_o_D ,
	output signed [7:0] data_o_E ,
	output signed [7:0] data_o_F ,
	output signed [7:0] data_o_G ,
	output signed [7:0] data_o_H ,
	output signed [7:0] data_o_I ,
	output signed [7:0] data_o_J ,
	output signed [7:0] data_o_K ,
	output signed [7:0] data_o_L ,
	output signed [7:0] data_o_M ,
	output signed [7:0] data_o_N ,
	output signed [7:0] data_o_O ,
	output signed [7:0] data_o_P
);

	reg valid_buf ;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			valid_buf <= 1'h0 ;
		else
			valid_buf <= valid_i ;
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			valid_o <= 1'h0 ;
		else
			valid_o <= valid_buf ;
	end
	

	adder4 adder4_A(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i_1A),
		.in2 	(data_i_2A),
		.in3 	(data_i_3A),
		.in4 	(data_i_4A),
		.out	(data_o_A)
	);
	
	adder4 adder4_B(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i_1B),
		.in2 	(data_i_2B),
		.in3 	(data_i_3B),
		.in4 	(data_i_4B),
		.out	(data_o_B)
	);
	
	adder4 adder4_C(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i_1C),
		.in2 	(data_i_2C),
		.in3 	(data_i_3C),
		.in4 	(data_i_4C),
		.out	(data_o_C)
	);
	
	adder4 adder4_D(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i_1D),
		.in2 	(data_i_2D),
		.in3 	(data_i_3D),
		.in4 	(data_i_4D),
		.out	(data_o_D)
	);
	
	adder4 adder4_E(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i_1E),
		.in2 	(data_i_2E),
		.in3 	(data_i_3E),
		.in4 	(data_i_4E),
		.out	(data_o_E)
	);
	
	adder4 adder4_F(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i_1F),
		.in2 	(data_i_2F),
		.in3 	(data_i_3F),
		.in4 	(data_i_4F),
		.out	(data_o_F)
	);
	
	adder4 adder4_G(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i_1G),
		.in2 	(data_i_2G),
		.in3 	(data_i_3G),
		.in4 	(data_i_4G),
		.out	(data_o_G)
	);
	
	adder4 adder4_H(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i_1H),
		.in2 	(data_i_2H),
		.in3 	(data_i_3H),
		.in4 	(data_i_4H),
		.out	(data_o_H)
	);
	
	adder4 adder4_I(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i_1I),
		.in2 	(data_i_2I),
		.in3 	(data_i_3I),
		.in4 	(data_i_4I),
		.out	(data_o_I)
	);
	
	adder4 adder4_J(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i_1J),
		.in2 	(data_i_2J),
		.in3 	(data_i_3J),
		.in4 	(data_i_4J),
		.out	(data_o_J)
	);
	
	adder4 adder4_K(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i_1K),
		.in2 	(data_i_2K),
		.in3 	(data_i_3K),
		.in4 	(data_i_4K),
		.out	(data_o_K)
	);
	
	adder4 adder4_L(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i_1L),
		.in2 	(data_i_2L),
		.in3 	(data_i_3L),
		.in4 	(data_i_4L),
		.out	(data_o_L)
	);
	
	adder4 adder4_M(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i_1M),
		.in2 	(data_i_2M),
		.in3 	(data_i_3M),
		.in4 	(data_i_4M),
		.out	(data_o_M)
	);
	
	adder4 adder4_N(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i_1N),
		.in2 	(data_i_2N),
		.in3 	(data_i_3N),
		.in4 	(data_i_4N),
		.out	(data_o_N)
	);
	
	adder4 adder4_O(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i_1O),
		.in2 	(data_i_2O),
		.in3 	(data_i_3O),
		.in4 	(data_i_4O),
		.out	(data_o_O)
	);
	
	adder4 adder4_P(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i_1P),
		.in2 	(data_i_2P),
		.in3 	(data_i_3P),
		.in4 	(data_i_4P),
		.out	(data_o_P)
	);

endmodule


