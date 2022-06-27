/**
----------------------------------------------------------------
Module Name  : conv_post
Sub Module   : 4 multiplireGroup , 1 crossBar , 1 sramArray 
----------------------------------------------------------------
**/

module conv_post(
	input clk ,
	input rst_n ,
	
	input signed [7:0] data_i_1 ,
	input valid_i_1 ,
	input signed [7:0] data_i_2 ,
	input valid_i_2 ,
	input signed [7:0] data_i_3 ,
	input valid_i_3 ,
	input signed [7:0] data_i_4 ,
	input valid_i_4 ,
	
	input signed [7:0] wA_1 ,
	input signed [7:0] wB_1 ,
	input signed [7:0] wC_1 ,
	input signed [7:0] wD_1 ,
	input signed [7:0] wE_1 ,
	input signed [7:0] wF_1 ,
	input signed [7:0] wG_1 ,
	input signed [7:0] wH_1 ,
	input signed [7:0] wI_1 ,
	input signed [7:0] wJ_1 ,
	input signed [7:0] wK_1 ,
	input signed [7:0] wL_1 ,
	input signed [7:0] wM_1 ,
	input signed [7:0] wN_1 ,
	input signed [7:0] wO_1 ,
	input signed [7:0] wP_1 ,
	
	input signed [7:0] wA_2 ,
	input signed [7:0] wB_2 ,
	input signed [7:0] wC_2 ,
	input signed [7:0] wD_2 ,
	input signed [7:0] wE_2 ,
	input signed [7:0] wF_2 ,
	input signed [7:0] wG_2 ,
	input signed [7:0] wH_2 ,
	input signed [7:0] wI_2 ,
	input signed [7:0] wJ_2 ,
	input signed [7:0] wK_2 ,
	input signed [7:0] wL_2 ,
	input signed [7:0] wM_2 ,
	input signed [7:0] wN_2 ,
	input signed [7:0] wO_2 ,
	input signed [7:0] wP_2 ,
	
	input signed [7:0] wA_3 ,
	input signed [7:0] wB_3 ,
	input signed [7:0] wC_3 ,
	input signed [7:0] wD_3 ,
	input signed [7:0] wE_3 ,
	input signed [7:0] wF_3 ,
	input signed [7:0] wG_3 ,
	input signed [7:0] wH_3 ,
	input signed [7:0] wI_3 ,
	input signed [7:0] wJ_3 ,
	input signed [7:0] wK_3 ,
	input signed [7:0] wL_3 ,
	input signed [7:0] wM_3 ,
	input signed [7:0] wN_3 ,
	input signed [7:0] wO_3 ,
	input signed [7:0] wP_3 ,
	
	input signed [7:0] wA_4 ,
	input signed [7:0] wB_4 ,
	input signed [7:0] wC_4 ,
	input signed [7:0] wD_4 ,
	input signed [7:0] wE_4 ,
	input signed [7:0] wF_4 ,
	input signed [7:0] wG_4 ,
	input signed [7:0] wH_4 ,
	input signed [7:0] wI_4 ,
	input signed [7:0] wJ_4 ,
	input signed [7:0] wK_4 ,
	input signed [7:0] wL_4 ,
	input signed [7:0] wM_4 ,
	input signed [7:0] wN_4 ,
	input signed [7:0] wO_4 ,
	input signed [7:0] wP_4 ,
	
	input bus_free ,
	
	output signed [7:0] data_o_1 ,
	output signed [7:0] data_o_2 ,
	output signed [7:0] data_o_3 ,
	output signed [7:0] data_o_4 ,
	output valid_o ,
	output conv_done
);

	wire valid_1 ;
	wire valid_2 ;
	wire valid_3 ;
	wire valid_4 ;
	wire signed [31:0] data_1_A ;
	wire signed [31:0] data_1_B ;
	wire signed [31:0] data_1_C ;
	wire signed [31:0] data_1_D ;
	wire signed [31:0] data_1_E ;
	wire signed [31:0] data_1_F ;
	wire signed [31:0] data_1_G ;
	wire signed [31:0] data_1_H ;
	wire signed [31:0] data_1_I ;
	wire signed [31:0] data_1_J ;
	wire signed [31:0] data_1_K ;
	wire signed [31:0] data_1_L ;
	wire signed [31:0] data_1_M ;
	wire signed [31:0] data_1_N ;
	wire signed [31:0] data_1_O ;
	wire signed [31:0] data_1_P ;
	wire signed [31:0] data_2_A ;
	wire signed [31:0] data_2_B ;
	wire signed [31:0] data_2_C ;
	wire signed [31:0] data_2_D ;
	wire signed [31:0] data_2_E ;
	wire signed [31:0] data_2_F ;
	wire signed [31:0] data_2_G ;
	wire signed [31:0] data_2_H ;
	wire signed [31:0] data_2_I ;
	wire signed [31:0] data_2_J ;
	wire signed [31:0] data_2_K ;
	wire signed [31:0] data_2_L ;
	wire signed [31:0] data_2_M ;
	wire signed [31:0] data_2_N ;
	wire signed [31:0] data_2_O ;
	wire signed [31:0] data_2_P ;
	wire signed [31:0] data_3_A ;
	wire signed [31:0] data_3_B ;
	wire signed [31:0] data_3_C ;
	wire signed [31:0] data_3_D ;
	wire signed [31:0] data_3_E ;
	wire signed [31:0] data_3_F ;
	wire signed [31:0] data_3_G ;
	wire signed [31:0] data_3_H ;
	wire signed [31:0] data_3_I ;
	wire signed [31:0] data_3_J ;
	wire signed [31:0] data_3_K ;
	wire signed [31:0] data_3_L ;
	wire signed [31:0] data_3_M ;
	wire signed [31:0] data_3_N ;
	wire signed [31:0] data_3_O ;
	wire signed [31:0] data_3_P ;
	wire signed [31:0] data_4_A ;
	wire signed [31:0] data_4_B ;
	wire signed [31:0] data_4_C ;
	wire signed [31:0] data_4_D ;
	wire signed [31:0] data_4_E ;
	wire signed [31:0] data_4_F ;
	wire signed [31:0] data_4_G ;
	wire signed [31:0] data_4_H ;
	wire signed [31:0] data_4_I ;
	wire signed [31:0] data_4_J ;
	wire signed [31:0] data_4_K ;
	wire signed [31:0] data_4_L ;
	wire signed [31:0] data_4_M ;
	wire signed [31:0] data_4_N ;
	wire signed [31:0] data_4_O ;
	wire signed [31:0] data_4_P ;
	
	wire signed [7:0] data_from_cb_A ;
	wire signed [7:0] data_from_cb_B ;
	wire signed [7:0] data_from_cb_C ;
	wire signed [7:0] data_from_cb_D ;
	wire signed [7:0] data_from_cb_E ;
	wire signed [7:0] data_from_cb_F ;
	wire signed [7:0] data_from_cb_G ;
	wire signed [7:0] data_from_cb_H ;
	wire signed [7:0] data_from_cb_I ;
	wire signed [7:0] data_from_cb_J ;
	wire signed [7:0] data_from_cb_K ;
	wire signed [7:0] data_from_cb_L ;
	wire signed [7:0] data_from_cb_M ;
	wire signed [7:0] data_from_cb_N ;
	wire signed [7:0] data_from_cb_O ;
	wire signed [7:0] data_from_cb_P ;
	wire valid_from_cb ;
	
	wire [31:0] data_o ;
	
	assign data_o_1 = data_o[31:24] ;
	assign data_o_2 = data_o[23:16] ;
	assign data_o_3 = data_o[15: 8] ;
	assign data_o_4 = data_o[ 7: 0] ;

multiplierGroup multiplierGroup_1(
	.clk 		(clk),
	.rst_n 		(rst_n),
    .data_i 	(data_i_1),
    .valid_i 	(valid_i_1),
    .wA 		(wA_1),
    .wB 		(wB_1),
    .wC 		(wC_1),
    .wD 		(wD_1),
    .wE 		(wE_1),
    .wF 		(wF_1),
    .wG 		(wG_1),
    .wH 		(wH_1),
    .wI 		(wI_1),
    .wJ 		(wJ_1),
    .wK 		(wK_1),
    .wL 		(wL_1),
    .wM 		(wM_1),
    .wN 		(wN_1),
    .wO 		(wO_1),
    .wP 		(wP_1),
    .valid_o 	(valid_1),
    .data_o_A_ex(data_1_A),
    .data_o_B_ex(data_1_B),
    .data_o_C_ex(data_1_C),
    .data_o_D_ex(data_1_D),
    .data_o_E_ex(data_1_E),
    .data_o_F_ex(data_1_F),
    .data_o_G_ex(data_1_G),
    .data_o_H_ex(data_1_H),
    .data_o_I_ex(data_1_I),
    .data_o_J_ex(data_1_J),
    .data_o_K_ex(data_1_K),
    .data_o_L_ex(data_1_L),
    .data_o_M_ex(data_1_M),
    .data_o_N_ex(data_1_N),
    .data_o_O_ex(data_1_O),
    .data_o_P_ex(data_1_P)
);

multiplierGroup multiplierGroup_2(
	.clk 		(clk),
	.rst_n 		(rst_n),
    .data_i 	(data_i_2),
    .valid_i 	(valid_i_2),
    .wA 		(wA_2),
    .wB 		(wB_2),
    .wC 		(wC_2),
    .wD 		(wD_2),
    .wE 		(wE_2),
    .wF 		(wF_2),
    .wG 		(wG_2),
    .wH 		(wH_2),
    .wI 		(wI_2),
    .wJ 		(wJ_2),
    .wK 		(wK_2),
    .wL 		(wL_2),
    .wM 		(wM_2),
    .wN 		(wN_2),
    .wO 		(wO_2),
    .wP 		(wP_2),
    .valid_o 	(valid_2),
    .data_o_A_ex(data_2_A),
    .data_o_B_ex(data_2_B),
    .data_o_C_ex(data_2_C),
    .data_o_D_ex(data_2_D),
    .data_o_E_ex(data_2_E),
    .data_o_F_ex(data_2_F),
    .data_o_G_ex(data_2_G),
    .data_o_H_ex(data_2_H),
    .data_o_I_ex(data_2_I),
    .data_o_J_ex(data_2_J),
    .data_o_K_ex(data_2_K),
    .data_o_L_ex(data_2_L),
    .data_o_M_ex(data_2_M),
    .data_o_N_ex(data_2_N),
    .data_o_O_ex(data_2_O),
    .data_o_P_ex(data_2_P)
);

multiplierGroup multiplierGroup_3(
	.clk 		(clk),
	.rst_n 		(rst_n),
    .data_i 	(data_i_3),
    .valid_i 	(valid_i_3),
    .wA 		(wA_3),
    .wB 		(wB_3),
    .wC 		(wC_3),
    .wD 		(wD_3),
    .wE 		(wE_3),
    .wF 		(wF_3),
    .wG 		(wG_3),
    .wH 		(wH_3),
    .wI 		(wI_3),
    .wJ 		(wJ_3),
    .wK 		(wK_3),
    .wL 		(wL_3),
    .wM 		(wM_3),
    .wN 		(wN_3),
    .wO 		(wO_3),
    .wP 		(wP_3),
    .valid_o 	(valid_3),
    .data_o_A_ex(data_3_A),
    .data_o_B_ex(data_3_B),
    .data_o_C_ex(data_3_C),
    .data_o_D_ex(data_3_D),
    .data_o_E_ex(data_3_E),
    .data_o_F_ex(data_3_F),
    .data_o_G_ex(data_3_G),
    .data_o_H_ex(data_3_H),
    .data_o_I_ex(data_3_I),
    .data_o_J_ex(data_3_J),
    .data_o_K_ex(data_3_K),
    .data_o_L_ex(data_3_L),
    .data_o_M_ex(data_3_M),
    .data_o_N_ex(data_3_N),
    .data_o_O_ex(data_3_O),
    .data_o_P_ex(data_3_P)
);

multiplierGroup multiplierGroup_4(
	.clk 		(clk),
	.rst_n 		(rst_n),
    .data_i 	(data_i_4),
    .valid_i 	(valid_i_4),
    .wA 		(wA_4),
    .wB 		(wB_4),
    .wC 		(wC_4),
    .wD 		(wD_4),
    .wE 		(wE_4),
    .wF 		(wF_4),
    .wG 		(wG_4),
    .wH 		(wH_4),
    .wI 		(wI_4),
    .wJ 		(wJ_4),
    .wK 		(wK_4),
    .wL 		(wL_4),
    .wM 		(wM_4),
    .wN 		(wN_4),
    .wO 		(wO_4),
    .wP 		(wP_4),
    .valid_o 	(valid_4),
    .data_o_A_ex(data_4_A),
    .data_o_B_ex(data_4_B),
    .data_o_C_ex(data_4_C),
    .data_o_D_ex(data_4_D),
    .data_o_E_ex(data_4_E),
    .data_o_F_ex(data_4_F),
    .data_o_G_ex(data_4_G),
    .data_o_H_ex(data_4_H),
    .data_o_I_ex(data_4_I),
    .data_o_J_ex(data_4_J),
    .data_o_K_ex(data_4_K),
    .data_o_L_ex(data_4_L),
    .data_o_M_ex(data_4_M),
    .data_o_N_ex(data_4_N),
    .data_o_O_ex(data_4_O),
    .data_o_P_ex(data_4_P)
);

crossBar crossBar_0(
	.clk 		(clk),
	.rst_n 		(rst_n),
	.valid_i 	(valid_1),
	.data_i_1A 	(data_1_A),
	.data_i_1B 	(data_1_B),
	.data_i_1C 	(data_1_C),
	.data_i_1D 	(data_1_D),
	.data_i_1E 	(data_1_E),
	.data_i_1F 	(data_1_F),
	.data_i_1G 	(data_1_G),
	.data_i_1H 	(data_1_H),
	.data_i_1I 	(data_1_I),
	.data_i_1J 	(data_1_J),
	.data_i_1K 	(data_1_K),
	.data_i_1L 	(data_1_L),
	.data_i_1M 	(data_1_M),
	.data_i_1N 	(data_1_N),
	.data_i_1O 	(data_1_O),
	.data_i_1P 	(data_1_P),
	.data_i_2A 	(data_2_A),
	.data_i_2B 	(data_2_B),
	.data_i_2C 	(data_2_C),
	.data_i_2D 	(data_2_D),
	.data_i_2E 	(data_2_E),
	.data_i_2F 	(data_2_F),
	.data_i_2G 	(data_2_G),
	.data_i_2H 	(data_2_H),
	.data_i_2I 	(data_2_I),
	.data_i_2J 	(data_2_J),
	.data_i_2K 	(data_2_K),
	.data_i_2L 	(data_2_L),
	.data_i_2M 	(data_2_M),
	.data_i_2N 	(data_2_N),
	.data_i_2O 	(data_2_O),
	.data_i_2P 	(data_2_P),
	.data_i_3A 	(data_3_A),
	.data_i_3B 	(data_3_B),
	.data_i_3C 	(data_3_C),
	.data_i_3D 	(data_3_D),
	.data_i_3E 	(data_3_E),
	.data_i_3F 	(data_3_F),
	.data_i_3G 	(data_3_G),
	.data_i_3H 	(data_3_H),
	.data_i_3I 	(data_3_I),
	.data_i_3J 	(data_3_J),
	.data_i_3K 	(data_3_K),
	.data_i_3L 	(data_3_L),
	.data_i_3M 	(data_3_M),
	.data_i_3N 	(data_3_N),
	.data_i_3O 	(data_3_O),
	.data_i_3P 	(data_3_P),
	.data_i_4A 	(data_4_A),
	.data_i_4B 	(data_4_B),
	.data_i_4C 	(data_4_C),
	.data_i_4D 	(data_4_D),
	.data_i_4E 	(data_4_E),
	.data_i_4F 	(data_4_F),
	.data_i_4G 	(data_4_G),
	.data_i_4H 	(data_4_H),
	.data_i_4I 	(data_4_I),
	.data_i_4J 	(data_4_J),
	.data_i_4K 	(data_4_K),
	.data_i_4L 	(data_4_L),
	.data_i_4M 	(data_4_M),
	.data_i_4N 	(data_4_N),
	.data_i_4O 	(data_4_O),
	.data_i_4P 	(data_4_P),
	.valid_o   	(valid_from_cb),
	.data_o_A 	(data_from_cb_A),
	.data_o_B 	(data_from_cb_B),
	.data_o_C 	(data_from_cb_C),
	.data_o_D 	(data_from_cb_D),
	.data_o_E 	(data_from_cb_E),
	.data_o_F 	(data_from_cb_F),
	.data_o_G 	(data_from_cb_G),
	.data_o_H 	(data_from_cb_H),
	.data_o_I 	(data_from_cb_I),
	.data_o_J 	(data_from_cb_J),
	.data_o_K 	(data_from_cb_K),
	.data_o_L 	(data_from_cb_L),
	.data_o_M 	(data_from_cb_M),
	.data_o_N 	(data_from_cb_N),
	.data_o_O 	(data_from_cb_O),
	.data_o_P	(data_from_cb_P)
);

sramArray sramArray_0(
	.clk 	  (clk),
    .rst_n 	  (rst_n),
    .valid_i  (valid_from_cb),
	.data_i_A (data_from_cb_A),
    .data_i_B (data_from_cb_B),
    .data_i_C (data_from_cb_C),
    .data_i_D (data_from_cb_D),
    .data_i_E (data_from_cb_E),
    .data_i_F (data_from_cb_F),
    .data_i_G (data_from_cb_G),
    .data_i_H (data_from_cb_H),
    .data_i_I (data_from_cb_I),
    .data_i_J (data_from_cb_J),
    .data_i_K (data_from_cb_K),
    .data_i_L (data_from_cb_L),
    .data_i_M (data_from_cb_M),
    .data_i_N (data_from_cb_N),
    .data_i_O (data_from_cb_O),
    .data_i_P (data_from_cb_P),
	.bus_free (bus_free),
    .valid_o  (valid_o),
    .data_o   (data_o) ,
	.conv_done(conv_done)
);

endmodule


