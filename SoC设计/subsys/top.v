module top(
	input clk ,
	input rst_n ,
	
	input [31:0] data_i ,
	input valid_i ,
	input bus_free ,
	
	output weight_ing ,
	output [31:0] data_o ,
	output valid_o ,
	output conv_done
);

	wire valid_2_conv_1 ;
	wire valid_2_conv_2 ;
	wire valid_2_conv_3 ;
	wire valid_2_conv_4 ;
	wire signed [7:0] data_o_33_1 ;
	wire signed [7:0] data_o_33_2 ;
	wire signed [7:0] data_o_33_3 ;
	wire signed [7:0] data_o_33_4 ;
	wire signed [7:0] data_o_ReLU_1 ;
	wire signed [7:0] data_o_ReLU_2 ;
	wire signed [7:0] data_o_ReLU_3 ;
	wire signed [7:0] data_o_ReLU_4 ;
	wire signed [7:0] data_o_POST_1 ;
	wire signed [7:0] data_o_POST_2 ;
	wire signed [7:0] data_o_POST_3 ;
	wire signed [7:0] data_o_POST_4 ;
	
	wire valid_o_conv33 ;
	wire valid_o_ReLU ;
	
	wire chnl_done_conv33 ;
	
	assign valid_2_conv_1 = (weight_ing==1'b1)? 1'b0 : valid_i ;
	assign valid_2_conv_2 = (weight_ing==1'b1)? 1'b0 : valid_i ;
	assign valid_2_conv_3 = (weight_ing==1'b1)? 1'b0 : valid_i ;
	assign valid_2_conv_4 = (weight_ing==1'b1)? 1'b0 : valid_i ;
	
	assign data_o = {{data_o_POST_1},{data_o_POST_2},{data_o_POST_3},{data_o_POST_4}} ;
	
	wire [7:0] w33_1_1 ;
	wire [7:0] w33_1_2 ;
	wire [7:0] w33_1_3 ;
	wire [7:0] w33_1_4 ;
	wire [7:0] w33_1_5 ;
	wire [7:0] w33_1_6 ;
	wire [7:0] w33_1_7 ;
	wire [7:0] w33_1_8 ;
	wire [7:0] w33_1_9 ;
	wire [7:0] w33_2_1 ;
	wire [7:0] w33_2_2 ;
	wire [7:0] w33_2_3 ;
	wire [7:0] w33_2_4 ;
	wire [7:0] w33_2_5 ;
	wire [7:0] w33_2_6 ;
	wire [7:0] w33_2_7 ;
	wire [7:0] w33_2_8 ;
	wire [7:0] w33_2_9 ;
	wire [7:0] w33_3_1 ;
	wire [7:0] w33_3_2 ;
	wire [7:0] w33_3_3 ;
	wire [7:0] w33_3_4 ;
	wire [7:0] w33_3_5 ;
	wire [7:0] w33_3_6 ;
	wire [7:0] w33_3_7 ;
	wire [7:0] w33_3_8 ;
	wire [7:0] w33_3_9 ;
	wire [7:0] w33_4_1 ;
	wire [7:0] w33_4_2 ;
	wire [7:0] w33_4_3 ;
	wire [7:0] w33_4_4 ;
	wire [7:0] w33_4_5 ;
	wire [7:0] w33_4_6 ;
	wire [7:0] w33_4_7 ;
	wire [7:0] w33_4_8 ;
	wire [7:0] w33_4_9 ;
	
	wire [7:0] w11_1_1 ;
	wire [7:0] w11_1_2 ;
	wire [7:0] w11_1_3 ;
	wire [7:0] w11_1_4 ;
	wire [7:0] w11_1_5 ;
	wire [7:0] w11_1_6 ;
	wire [7:0] w11_1_7 ;
	wire [7:0] w11_1_8 ;
	wire [7:0] w11_1_9 ;
	wire [7:0] w11_1_10 ;
	wire [7:0] w11_1_11 ;
	wire [7:0] w11_1_12 ;
	wire [7:0] w11_1_13 ;
	wire [7:0] w11_1_14 ;
	wire [7:0] w11_1_15 ;
	wire [7:0] w11_1_16 ;
	wire [7:0] w11_2_1 ;
	wire [7:0] w11_2_2 ;
	wire [7:0] w11_2_3 ;
	wire [7:0] w11_2_4 ;
	wire [7:0] w11_2_5 ;
	wire [7:0] w11_2_6 ;
	wire [7:0] w11_2_7 ;
	wire [7:0] w11_2_8 ;
	wire [7:0] w11_2_9 ;
	wire [7:0] w11_2_10 ;
	wire [7:0] w11_2_11 ;
	wire [7:0] w11_2_12 ;
	wire [7:0] w11_2_13 ;
	wire [7:0] w11_2_14 ;
	wire [7:0] w11_2_15 ;
	wire [7:0] w11_2_16 ;
	wire [7:0] w11_3_1 ;
	wire [7:0] w11_3_2 ;
	wire [7:0] w11_3_3 ;
	wire [7:0] w11_3_4 ;
	wire [7:0] w11_3_5 ;
	wire [7:0] w11_3_6 ;
	wire [7:0] w11_3_7 ;
	wire [7:0] w11_3_8 ;
	wire [7:0] w11_3_9 ;
	wire [7:0] w11_3_10 ;
	wire [7:0] w11_3_11 ;
	wire [7:0] w11_3_12 ;
	wire [7:0] w11_3_13 ;
	wire [7:0] w11_3_14 ;
	wire [7:0] w11_3_15 ;
	wire [7:0] w11_3_16 ;
	wire [7:0] w11_4_1 ;
	wire [7:0] w11_4_2 ;
	wire [7:0] w11_4_3 ;
	wire [7:0] w11_4_4 ;
	wire [7:0] w11_4_5 ;
	wire [7:0] w11_4_6 ;
	wire [7:0] w11_4_7 ;
	wire [7:0] w11_4_8 ;
	wire [7:0] w11_4_9 ;
	wire [7:0] w11_4_10 ;
	wire [7:0] w11_4_11 ;
	wire [7:0] w11_4_12 ;
	wire [7:0] w11_4_13 ;
	wire [7:0] w11_4_14 ;
	wire [7:0] w11_4_15 ;
	wire [7:0] w11_4_16 ;
	
	
	
	
	
	conv conv_1(
		.clk 		(clk),
		.rst_n 		(rst_n),
		.data_i 	(data_i[31:24]),
		.valid_i 	(valid_2_conv_1),
		.weight1 	(w33_1_1),
		.weight2 	(w33_1_2),
		.weight3 	(w33_1_3),
		.weight4 	(w33_1_4),
		.weight5 	(w33_1_5),
		.weight6 	(w33_1_6),
		.weight7 	(w33_1_7),
		.weight8 	(w33_1_8),
		.weight9 	(w33_1_9),
	    .data_o 	(data_o_33_1),	
        .valid_o 	(valid_o_conv33),
        .chnl_done	(chnl_done_conv33)
	);
	
	conv conv_2(
		.clk 		(clk),
		.rst_n 		(rst_n),
		.data_i 	(data_i[23:16]),
		.valid_i 	(valid_2_conv_2),
		.weight1 	(w33_2_1),
		.weight2 	(w33_2_2),
		.weight3 	(w33_2_3),
		.weight4 	(w33_2_4),
		.weight5 	(w33_2_5),
		.weight6 	(w33_2_6),
		.weight7 	(w33_2_7),
		.weight8 	(w33_2_8),
		.weight9 	(w33_2_9),
	    .data_o 	(data_o_33_2),	
        .valid_o 	(),
        .chnl_done	()
	);	 
	
	conv conv_3(
		.clk 		(clk),
		.rst_n 		(rst_n),
		.data_i 	(data_i[15:8]),
		.valid_i 	(valid_2_conv_3),
		.weight1 	(w33_3_1),
		.weight2 	(w33_3_2),
		.weight3 	(w33_3_3),
		.weight4 	(w33_3_4),
		.weight5 	(w33_3_5),
		.weight6 	(w33_3_6),
		.weight7 	(w33_3_7),
		.weight8 	(w33_3_8),
		.weight9 	(w33_3_9),
	    .data_o 	(data_o_33_3),	
        .valid_o 	(),
        .chnl_done	()
	);	 
	
	conv conv_4(
		.clk 		(clk),
		.rst_n 		(rst_n),
		.data_i 	(data_i[7:0]),
		.valid_i 	(valid_2_conv_4),
		.weight1 	(w33_4_1),
		.weight2 	(w33_4_2),
		.weight3 	(w33_4_3),
		.weight4 	(w33_4_4),
		.weight5 	(w33_4_5),
		.weight6 	(w33_4_6),
		.weight7 	(w33_4_7),
		.weight8 	(w33_4_8),
		.weight9 	(w33_4_9),
	    .data_o 	(data_o_33_4),	
        .valid_o 	(),
        .chnl_done	()
	);	
	
	ReLU ReLU_0(
		.clk 		(clk),
		.rst_n 		(rst_n),
		.data_i_1 	(data_o_33_1),
		.data_i_2 	(data_o_33_2),
		.data_i_3 	(data_o_33_3),
		.data_i_4 	(data_o_33_4),
		.valid_i 	(valid_o_conv33),	
		.data_o_1 	(data_o_ReLU_1),
		.data_o_2 	(data_o_ReLU_2),
		.data_o_3 	(data_o_ReLU_3),
		.data_o_4 	(data_o_ReLU_4),
		.valid_o	(valid_o_ReLU)
	);
		 
	conv_post conv_post_0(
		.clk 		(clk),
	    .rst_n 		(rst_n),
	    .data_i_1 	(data_o_ReLU_1),
	    .valid_i_1 	(valid_o_ReLU),
	    .data_i_2 	(data_o_ReLU_2),
	    .valid_i_2 	(valid_o_ReLU),
	    .data_i_3 	(data_o_ReLU_3),
	    .valid_i_3 	(valid_o_ReLU),
	    .data_i_4 	(data_o_ReLU_4),
	    .valid_i_4 	(valid_o_ReLU),
	    .wA_1 (w11_1_1 ),
	    .wB_1 (w11_1_2 ),
	    .wC_1 (w11_1_3 ),
	    .wD_1 (w11_1_4 ),
	    .wE_1 (w11_1_5 ),
	    .wF_1 (w11_1_6 ),
	    .wG_1 (w11_1_7 ),
	    .wH_1 (w11_1_8 ),
	    .wI_1 (w11_1_9 ),
	    .wJ_1 (w11_1_10),
	    .wK_1 (w11_1_11),
	    .wL_1 (w11_1_12),
	    .wM_1 (w11_1_13),
	    .wN_1 (w11_1_14),
	    .wO_1 (w11_1_15),
	    .wP_1 (w11_1_16),
	    .wA_2 (w11_2_1 ),
	    .wB_2 (w11_2_2 ),
	    .wC_2 (w11_2_3 ),
	    .wD_2 (w11_2_4 ),
	    .wE_2 (w11_2_5 ),
	    .wF_2 (w11_2_6 ),
	    .wG_2 (w11_2_7 ),
	    .wH_2 (w11_2_8 ),
	    .wI_2 (w11_2_9 ),
	    .wJ_2 (w11_2_10),
	    .wK_2 (w11_2_11),
	    .wL_2 (w11_2_12),
	    .wM_2 (w11_2_13),
	    .wN_2 (w11_2_14),
	    .wO_2 (w11_2_15),
	    .wP_2 (w11_2_16),
	    .wA_3 (w11_3_1 ),
	    .wB_3 (w11_3_2 ),
	    .wC_3 (w11_3_3 ),
	    .wD_3 (w11_3_4 ),
	    .wE_3 (w11_3_5 ),
	    .wF_3 (w11_3_6 ),
	    .wG_3 (w11_3_7 ),
	    .wH_3 (w11_3_8 ),
	    .wI_3 (w11_3_9 ),
	    .wJ_3 (w11_3_10),
	    .wK_3 (w11_3_11),
	    .wL_3 (w11_3_12),
	    .wM_3 (w11_3_13),
	    .wN_3 (w11_3_14),
	    .wO_3 (w11_3_15),
	    .wP_3 (w11_3_16),
	    .wA_4 (w11_4_1 ),
	    .wB_4 (w11_4_2 ),
	    .wC_4 (w11_4_3 ),
	    .wD_4 (w11_4_4 ),
	    .wE_4 (w11_4_5 ),
	    .wF_4 (w11_4_6 ),
	    .wG_4 (w11_4_7 ),
	    .wH_4 (w11_4_8 ),
	    .wI_4 (w11_4_9 ),
	    .wJ_4 (w11_4_10),
	    .wK_4 (w11_4_11),
	    .wL_4 (w11_4_12),
	    .wM_4 (w11_4_13),
	    .wN_4 (w11_4_14),
	    .wO_4 (w11_4_15),
	    .wP_4 (w11_4_16),
	    .bus_free (bus_free),
	    .data_o_1 (data_o_POST_1),
	    .data_o_2 (data_o_POST_2),
	    .data_o_3 (data_o_POST_3),
	    .data_o_4 (data_o_POST_4),
	    .valid_o  (valid_o) ,
		.conv_done(conv_done)
	);
		 

	weight_distribution weight_distribution_0(
		.clk 			(clk),
	    .rst_n 			(rst_n),
        .w1 			(data_i[31:24]),
        .w2 			(data_i[23:16]),
        .w3 			(data_i[15: 8]),
        .w4 			(data_i[ 7: 0]),
        .valid_i 		(valid_i),
        .switch_conv33 	(chnl_done_conv33),
        .weight_ing     (weight_ing),
        .w33_1_1 		(w33_1_1),
        .w33_1_2 		(w33_1_2),
        .w33_1_3 		(w33_1_3),
        .w33_1_4 		(w33_1_4),
        .w33_1_5 		(w33_1_5),
        .w33_1_6 		(w33_1_6),
        .w33_1_7 		(w33_1_7),
        .w33_1_8 		(w33_1_8),
        .w33_1_9 		(w33_1_9),
        .w33_2_1 		(w33_2_1),
        .w33_2_2 		(w33_2_2),
        .w33_2_3 		(w33_2_3),
        .w33_2_4 		(w33_2_4),
        .w33_2_5 		(w33_2_5),
        .w33_2_6 		(w33_2_6),
        .w33_2_7 		(w33_2_7),
        .w33_2_8 		(w33_2_8),
        .w33_2_9 		(w33_2_9),
        .w33_3_1 		(w33_3_1),
        .w33_3_2 		(w33_3_2),
        .w33_3_3 		(w33_3_3),
        .w33_3_4 		(w33_3_4),
        .w33_3_5 		(w33_3_5),
        .w33_3_6 		(w33_3_6),
        .w33_3_7 		(w33_3_7),
        .w33_3_8 		(w33_3_8),
        .w33_3_9 		(w33_3_9),
        .w33_4_1 		(w33_4_1),
        .w33_4_2 		(w33_4_2),
        .w33_4_3 		(w33_4_3),
        .w33_4_4 		(w33_4_4),
        .w33_4_5 		(w33_4_5),
        .w33_4_6 		(w33_4_6),
        .w33_4_7 		(w33_4_7),
        .w33_4_8 		(w33_4_8),
        .w33_4_9 		(w33_4_9),
        .w11_1_1 		(w11_1_1 ),
        .w11_1_2 		(w11_1_2 ),
        .w11_1_3 		(w11_1_3 ),
        .w11_1_4 		(w11_1_4 ),
        .w11_1_5 		(w11_1_5 ),
        .w11_1_6 		(w11_1_6 ),
        .w11_1_7 		(w11_1_7 ),
        .w11_1_8 		(w11_1_8 ),
        .w11_1_9 		(w11_1_9 ),
        .w11_1_10		(w11_1_10),
        .w11_1_11		(w11_1_11),
        .w11_1_12		(w11_1_12),
        .w11_1_13		(w11_1_13),
        .w11_1_14		(w11_1_14),
        .w11_1_15		(w11_1_15),
        .w11_1_16		(w11_1_16),
        .w11_2_1 		(w11_2_1 ),
        .w11_2_2 		(w11_2_2 ),
        .w11_2_3 		(w11_2_3 ),
        .w11_2_4 		(w11_2_4 ),
        .w11_2_5 		(w11_2_5 ),
        .w11_2_6 		(w11_2_6 ),
        .w11_2_7 		(w11_2_7 ),
        .w11_2_8 		(w11_2_8 ),
        .w11_2_9 		(w11_2_9 ),
        .w11_2_10		(w11_2_10),
        .w11_2_11		(w11_2_11),
        .w11_2_12		(w11_2_12),
        .w11_2_13		(w11_2_13),
        .w11_2_14		(w11_2_14),
        .w11_2_15		(w11_2_15),
        .w11_2_16		(w11_2_16),
        .w11_3_1 		(w11_3_1 ),
        .w11_3_2 		(w11_3_2 ),
        .w11_3_3 		(w11_3_3 ),
        .w11_3_4 		(w11_3_4 ),
        .w11_3_5 		(w11_3_5 ),
        .w11_3_6 		(w11_3_6 ),
        .w11_3_7 		(w11_3_7 ),
        .w11_3_8 		(w11_3_8 ),
        .w11_3_9 		(w11_3_9 ),
        .w11_3_10		(w11_3_10),
        .w11_3_11		(w11_3_11),
        .w11_3_12		(w11_3_12),
        .w11_3_13		(w11_3_13),
        .w11_3_14		(w11_3_14),
        .w11_3_15		(w11_3_15),
        .w11_3_16		(w11_3_16),
        .w11_4_1 		(w11_4_1 ),
        .w11_4_2 		(w11_4_2 ),
        .w11_4_3 		(w11_4_3 ),
        .w11_4_4 		(w11_4_4 ),
        .w11_4_5 		(w11_4_5 ),
        .w11_4_6 		(w11_4_6 ),
        .w11_4_7 		(w11_4_7 ),
        .w11_4_8 		(w11_4_8 ),
        .w11_4_9 		(w11_4_9 ),
        .w11_4_10		(w11_4_10),
        .w11_4_11		(w11_4_11),
        .w11_4_12		(w11_4_12),
        .w11_4_13		(w11_4_13),
        .w11_4_14		(w11_4_14),
        .w11_4_15		(w11_4_15),
        .w11_4_16		(w11_4_16)
	);

endmodule