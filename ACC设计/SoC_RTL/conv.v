/**
----------------------------------------------------------------
Module Name  : conv
Sub Module   : 9 PE , 2 fifo , 1 counterGroup , 1 MultiplierBar  
----------------------------------------------------------------
**/

module conv(
	input clk ,
	input rst_n ,
	
	input [7:0] data_i ,
	input valid_i ,
	
	input signed [7:0] weight1 ,
	input signed [7:0] weight2 ,
	input signed [7:0] weight3 ,
	input signed [7:0] weight4 ,
	input signed [7:0] weight5 ,
	input signed [7:0] weight6 ,
	input signed [7:0] weight7 ,
	input signed [7:0] weight8 ,
	input signed [7:0] weight9 ,
	
	output signed [7:0] data_o ,
	output valid_o ,
	output chnl_done
);


	wire signed [7:0] data_pe1 , data_pe2 , data_pe3 ;
	wire signed [7:0] data_pe4 , data_pe5 , data_pe6 ;
	wire signed [7:0] data_pe7 , data_pe8 , data_pe9 ;
	wire signed [7:0] data_fifo1 ;
	wire signed [7:0] data_fifo2 ;
	wire enable1 ;
	wire enable2 ;
	wire enable3 ;
	wire enable4 ;
	wire enable5 ;
	wire enable6 ;
	wire enable7 ;
	wire enable8 ;
	wire enable9 ;
	wire signed [7:0] data_pe2multipleBar1 , data_pe2multipleBar2 , data_pe2multipleBar3 ;
	wire signed [7:0] data_pe2multipleBar4 , data_pe2multipleBar5 , data_pe2multipleBar6 ;
	wire signed [7:0] data_pe2multipleBar7 , data_pe2multipleBar8 , data_pe2multipleBar9 ;
	
	wire valid_o_counterGroup ;
	
	assign data_pe1 = data_i ;
	
	fifo fifo1(
		.clk 		(clk),
		.rst_n 		(rst_n),
		.data_i 	(data_fifo1),
		.valid_i 	(valid_i),
		.data_o		(data_pe4)
	);
	
	fifo fifo2(
		.clk 		(clk),
		.rst_n 		(rst_n),
		.data_i 	(data_fifo2),
		.valid_i 	(valid_i),
		.data_o		(data_pe7)
	);
	
	PE PE1(
		.clk					(clk) ,
		.rst_n					(rst_n) ,
		.valid 					(valid_i),
		.enable 				(enable1),
		.data_i 				(data_pe1),
		.data_o 				(data_pe2),
		.data_pe2multipleBar	(data_pe2multipleBar1)
	);
	
	PE PE2(
		.clk					(clk) ,
		.rst_n					(rst_n) ,
		.valid 					(valid_i),
		.enable 				(enable2),
		.data_i 				(data_pe2),
		.data_o 				(data_pe3),
		.data_pe2multipleBar	(data_pe2multipleBar2)
	);
	
	PE PE3(
		.clk					(clk) ,
		.rst_n					(rst_n) ,
		.valid 					(valid_i),
		.enable 				(enable3),
		.data_i 				(data_pe3),
		.data_o 				(data_fifo1),
		.data_pe2multipleBar	(data_pe2multipleBar3)
	);
	
	PE PE4(
		.clk					(clk) ,
		.rst_n					(rst_n) ,
		.valid 					(valid_i),
		.enable 				(enable4),
		.data_i 				(data_pe4),
		.data_o 				(data_pe5),
		.data_pe2multipleBar	(data_pe2multipleBar4)
	);
	
	PE PE5(
		.clk					(clk) ,
		.rst_n					(rst_n) ,
		.valid 					(valid_i),
		.enable 				(enable5),
		.data_i 				(data_pe5),
		.data_o 				(data_pe6),
		.data_pe2multipleBar	(data_pe2multipleBar5)
	);
	
	PE PE6(
		.clk					(clk) ,
		.rst_n					(rst_n) ,
		.valid 					(valid_i),
		.enable 				(enable6),
		.data_i 				(data_pe6),
		.data_o 				(data_fifo2),
		.data_pe2multipleBar	(data_pe2multipleBar6)
	);
	
	PE PE7(
		.clk					(clk) ,
		.rst_n					(rst_n) ,
		.valid 					(valid_i),
		.enable 				(enable7),
		.data_i 				(data_pe7),
		.data_o 				(data_pe8),
		.data_pe2multipleBar	(data_pe2multipleBar7)
	);
	
	PE PE8(
		.clk					(clk) ,
		.rst_n					(rst_n) ,
		.valid 					(valid_i),
		.enable 				(enable8),
		.data_i 				(data_pe8),
		.data_o 				(data_pe9),
		.data_pe2multipleBar	(data_pe2multipleBar8)
	);
	
	PE PE9(
		.clk					(clk) ,
		.rst_n					(rst_n) ,
		.valid 					(valid_i),
		.enable 				(enable9),
		.data_i 				(data_pe9),
		.data_o 				(),
		.data_pe2multipleBar	(data_pe2multipleBar9)
	);

	counterGroup counterGroup_0(
		.clk 		(clk),
		.rst_n 		(rst_n),
		.valid_i 	(valid_i),
		.enable1 	(enable1),
		.enable2 	(enable2),
		.enable3 	(enable3),
		.enable4 	(enable4),
		.enable5 	(enable5),
		.enable6 	(enable6),
		.enable7 	(enable7),
		.enable8 	(enable8),
		.enable9	(enable9),
		.valid_o	(valid_o_counterGroup) ,
		.chnl_done	(chnl_done)
	);

	multiplierBar multiplierBar_0(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_pe2multipleBar1),
		.in2 	(data_pe2multipleBar2),
		.in3 	(data_pe2multipleBar3),
		.in4 	(data_pe2multipleBar4),
		.in5 	(data_pe2multipleBar5),
		.in6 	(data_pe2multipleBar6),
		.in7 	(data_pe2multipleBar7),
		.in8 	(data_pe2multipleBar8),
		.in9 	(data_pe2multipleBar9),
		.w1 	(weight1),
		.w2 	(weight2),
		.w3 	(weight3),
		.w4 	(weight4),
		.w5 	(weight5),
		.w6 	(weight6),
		.w7 	(weight7),
		.w8 	(weight8),
		.w9 	(weight9),
		.valid_i(valid_o_counterGroup),
		.out 	(data_o),
		.valid_o(valid_o)
	);

endmodule




