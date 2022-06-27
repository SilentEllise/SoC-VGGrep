module multiplierGroup(
	input clk ,
	input rst_n ,
	
	input signed [7:0] data_i ,
	input valid_i ,
	
	input signed [7:0] wA ,
	input signed [7:0] wB ,
	input signed [7:0] wC ,
	input signed [7:0] wD ,
	input signed [7:0] wE ,
	input signed [7:0] wF ,
	input signed [7:0] wG ,
	input signed [7:0] wH ,
	input signed [7:0] wI ,
	input signed [7:0] wJ ,
	input signed [7:0] wK ,
	input signed [7:0] wL ,
	input signed [7:0] wM ,
	input signed [7:0] wN ,
	input signed [7:0] wO ,
	input signed [7:0] wP ,
	
	output reg valid_o ,
	
	output signed [31:0] data_o_A_ex ,
	output signed [31:0] data_o_B_ex ,
	output signed [31:0] data_o_C_ex ,
	output signed [31:0] data_o_D_ex ,
	output signed [31:0] data_o_E_ex ,
	output signed [31:0] data_o_F_ex ,
	output signed [31:0] data_o_G_ex ,
	output signed [31:0] data_o_H_ex ,
	output signed [31:0] data_o_I_ex ,
	output signed [31:0] data_o_J_ex ,
	output signed [31:0] data_o_K_ex ,
	output signed [31:0] data_o_L_ex ,
	output signed [31:0] data_o_M_ex ,
	output signed [31:0] data_o_N_ex ,
	output signed [31:0] data_o_O_ex ,
	output signed [31:0] data_o_P_ex
);

	wire signed [14:0] data_o_A ;
    wire signed [14:0] data_o_B ;
    wire signed [14:0] data_o_C ;
    wire signed [14:0] data_o_D ;
    wire signed [14:0] data_o_E ;
    wire signed [14:0] data_o_F ;
    wire signed [14:0] data_o_G ;
    wire signed [14:0] data_o_H ;
    wire signed [14:0] data_o_I ;
    wire signed [14:0] data_o_J ;
    wire signed [14:0] data_o_K ;
    wire signed [14:0] data_o_L ;
    wire signed [14:0] data_o_M ;
    wire signed [14:0] data_o_N ;
    wire signed [14:0] data_o_O ;
    wire signed [14:0] data_o_P ;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			valid_o <= 1'h0 ;
		else
			valid_o <= valid_i ;
	end
	
	multiplier8bit multiplier8bit_A(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i),
		.in2 	(wA),
	    .out 	(data_o_A)
	);
	multiplier8bit multiplier8bit_B(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i),
		.in2 	(wB),
	    .out 	(data_o_B)
	);
	multiplier8bit multiplier8bit_C(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i),
		.in2 	(wC),
	    .out 	(data_o_C)
	);
	multiplier8bit multiplier8bit_D(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i),
		.in2 	(wD),
	    .out 	(data_o_D)
	);
	multiplier8bit multiplier8bit_E(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i),
		.in2 	(wE),
	    .out 	(data_o_E)
	);
	multiplier8bit multiplier8bit_F(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i),
		.in2 	(wF),
	    .out 	(data_o_F)
	);
	multiplier8bit multiplier8bit_G(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i),
		.in2 	(wG),
	    .out 	(data_o_G)
	);
	multiplier8bit multiplier8bit_H(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i),
		.in2 	(wH),
	    .out 	(data_o_H)
	);
	multiplier8bit multiplier8bit_I(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i),
		.in2 	(wI),
	    .out 	(data_o_I)
	);
	multiplier8bit multiplier8bit_J(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i),
		.in2 	(wJ),
	    .out 	(data_o_J)
	);
	multiplier8bit multiplier8bit_K(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i),
		.in2 	(wK),
	    .out 	(data_o_K)
	);
	multiplier8bit multiplier8bit_L(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i),
		.in2 	(wL),
	    .out 	(data_o_L)
	);
	multiplier8bit multiplier8bit_M(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i),
		.in2 	(wM),
	    .out 	(data_o_M)
	);
	multiplier8bit multiplier8bit_N(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i),
		.in2 	(wN),
	    .out 	(data_o_N)
	);
	multiplier8bit multiplier8bit_O(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i),
		.in2 	(wO),
	    .out 	(data_o_O)
	);
	multiplier8bit multiplier8bit_P(
		.clk 	(clk),
		.rst_n 	(rst_n),
		.in1 	(data_i),
		.in2 	(wP),
	    .out 	(data_o_P)
	);
	
	
	assign data_o_A_ex = {{17{data_o_A[14]}},{data_o_A}} ;
	assign data_o_B_ex = {{17{data_o_B[14]}},{data_o_B}} ;
	assign data_o_C_ex = {{17{data_o_C[14]}},{data_o_C}} ;
	assign data_o_D_ex = {{17{data_o_D[14]}},{data_o_D}} ;
	assign data_o_E_ex = {{17{data_o_E[14]}},{data_o_E}} ;
	assign data_o_F_ex = {{17{data_o_F[14]}},{data_o_F}} ;
	assign data_o_G_ex = {{17{data_o_G[14]}},{data_o_G}} ;
	assign data_o_H_ex = {{17{data_o_H[14]}},{data_o_H}} ;
	assign data_o_I_ex = {{17{data_o_I[14]}},{data_o_I}} ;
	assign data_o_J_ex = {{17{data_o_J[14]}},{data_o_J}} ;
	assign data_o_K_ex = {{17{data_o_K[14]}},{data_o_K}} ;
	assign data_o_L_ex = {{17{data_o_L[14]}},{data_o_L}} ;
	assign data_o_M_ex = {{17{data_o_M[14]}},{data_o_M}} ;
	assign data_o_N_ex = {{17{data_o_N[14]}},{data_o_N}} ;
	assign data_o_O_ex = {{17{data_o_O[14]}},{data_o_O}} ;
	assign data_o_P_ex = {{17{data_o_P[14]}},{data_o_P}} ;
	
	
endmodule
	
	
	
	
	
	
	