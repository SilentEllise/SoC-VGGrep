/**
----------------------------------------------------------------
Module Name  : multiplierBar
Sub Module   : 9 multiplier8bit , 1 adderTree
----------------------------------------------------------------
**/

module multiplierBar(
	input clk ,
	input rst_n ,
	
	input signed [7:0] in1 ,
	input signed [7:0] in2 ,
	input signed [7:0] in3 ,
	input signed [7:0] in4 ,
	input signed [7:0] in5 ,
	input signed [7:0] in6 ,
	input signed [7:0] in7 ,
	input signed [7:0] in8 ,
	input signed [7:0] in9 ,
	input signed [7:0] w1 ,
	input signed [7:0] w2 ,
	input signed [7:0] w3 ,
	input signed [7:0] w4 ,
	input signed [7:0] w5 ,
	input signed [7:0] w6 ,
	input signed [7:0] w7 ,
	input signed [7:0] w8 ,
	input signed [7:0] w9 ,
	
	input valid_i ,
	
	output signed [7:0] out ,
	output valid_o
	
);
	
	wire signed [14:0] multi1 ;
	wire signed [14:0] multi2 ;
	wire signed [14:0] multi3 ;
	wire signed [14:0] multi4 ;
	wire signed [14:0] multi5 ;
	wire signed [14:0] multi6 ;
	wire signed [14:0] multi7 ;
	wire signed [14:0] multi8 ;
	wire signed [14:0] multi9 ;
	
	wire signed [31:0] outFullBit ;
	
	assign out = {outFullBit[31],outFullBit[13:7]} ;
	
	reg valid_buf_L1 ;
	reg valid_buf_L2 ;
	reg valid_buf_L3 ;
	reg valid_buf_L4 ;
	//reg valid_buf_L5 ;
	
	assign valid_o = valid_buf_L4 ;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				valid_buf_L1 <= 1'h0 ;
				valid_buf_L2 <= 1'h0 ;
				valid_buf_L3 <= 1'h0 ;
				valid_buf_L4 <= 1'h0 ;
				//valid_buf_L5 <= 1'h0 ;
			end
		else
			begin
				valid_buf_L1 <= valid_i ;
				valid_buf_L2 <= valid_buf_L1 ;
				valid_buf_L3 <= valid_buf_L2 ;
				valid_buf_L4 <= valid_buf_L3 ;
				//valid_buf_L5 <= valid_buf_L4 ;
			end
	end
	
	

multiplier8bit multiplier8bit_1(
	.clk 	(clk),
	.rst_n 	(rst_n),
	.in1 	(in1),
	.in2 	(w1),
	.out 	(multi1)
);

multiplier8bit multiplier8bit_2(
	.clk 	(clk),
	.rst_n 	(rst_n),
	.in1 	(in2),
	.in2 	(w2),
	.out 	(multi2)
);

multiplier8bit multiplier8bit_3(
	.clk 	(clk),
	.rst_n 	(rst_n),
	.in1 	(in3),
	.in2 	(w3),
	.out 	(multi3)
);

multiplier8bit multiplier8bit_4(
	.clk 	(clk),
	.rst_n 	(rst_n),
	.in1 	(in4),
	.in2 	(w4),
	.out 	(multi4)
);

multiplier8bit multiplier8bit_5(
	.clk 	(clk),
	.rst_n 	(rst_n),
	.in1 	(in5),
	.in2 	(w5),
	.out 	(multi5)
);

multiplier8bit multiplier8bit_6(
	.clk 	(clk),
	.rst_n 	(rst_n) ,
	.in1 	(in6),
	.in2 	(w6),
	.out 	(multi6)
);

multiplier8bit multiplier8bit_7(
	.clk 	(clk),
	.rst_n 	(rst_n),
	.in1 	(in7),
	.in2 	(w7),
	.out 	(multi7)
);

multiplier8bit multiplier8bit_8(
	.clk 	(clk),
	.rst_n 	(rst_n),
	.in1 	(in8),
	.in2 	(w8),
	.out 	(multi8)
);

multiplier8bit multiplier8bit_9(
	.clk 	(clk),
	.rst_n 	(rst_n),
	.in1 	(in9),
	.in2 	(w9),
	.out 	(multi9)
);

adderTree adderTree_0(
	.clk 	(clk),
	.rst_n 	(rst_n),
	.in1 	(multi1),
	.in2 	(multi2),
	.in3 	(multi3),
	.in4 	(multi4),
	.in5 	(multi5),
	.in6 	(multi6),
	.in7 	(multi7),
	.in8 	(multi8),
	.in9 	(multi9),
	.out 	(outFullBit)
);


endmodule















