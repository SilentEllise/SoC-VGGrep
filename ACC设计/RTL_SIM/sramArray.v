/**
----------------------------------------------------------------
Module Name  : sramArray
Sub Module   : 16 accumulators , 1 counterArray , 16 sequence2parallel
----------------------------------------------------------------
**/

module sramArray(
	input clk ,
	input rst_n ,
	
	input valid_i ,
	input signed [7:0] data_i_A ,
    input signed [7:0] data_i_B ,
    input signed [7:0] data_i_C ,
    input signed [7:0] data_i_D ,
    input signed [7:0] data_i_E ,
    input signed [7:0] data_i_F ,
    input signed [7:0] data_i_G ,
    input signed [7:0] data_i_H ,
    input signed [7:0] data_i_I ,
    input signed [7:0] data_i_J ,
    input signed [7:0] data_i_K ,
    input signed [7:0] data_i_L ,
    input signed [7:0] data_i_M ,
    input signed [7:0] data_i_N ,
    input signed [7:0] data_i_O ,
    input signed [7:0] data_i_P ,
	
	input  bus_free ,
	output valid_o ,
	output [31:0] data_o ,
	output conv_done
	
);
	
	wire [31:0] data_s2p_A ;
	wire [31:0] data_s2p_B ;
	wire [31:0] data_s2p_C ;
	wire [31:0] data_s2p_D ;
	wire [31:0] data_s2p_E ;
	wire [31:0] data_s2p_F ;
	wire [31:0] data_s2p_G ;
	wire [31:0] data_s2p_H ;
	wire [31:0] data_s2p_I ;
	wire [31:0] data_s2p_J ;
	wire [31:0] data_s2p_K ;
	wire [31:0] data_s2p_L ;
	wire [31:0] data_s2p_M ;
	wire [31:0] data_s2p_N ;
	wire [31:0] data_s2p_O ;
	wire [31:0] data_s2p_P ;
	
	wire valid_A ;
	wire valid_B ;
	wire valid_C ;
	wire valid_D ;
	wire valid_E ;
	wire valid_F ;
	wire valid_G ;
	wire valid_H ;
	wire valid_I ;
	wire valid_J ;
	wire valid_K ;
	wire valid_L ;
	wire valid_M ;
	wire valid_N ;
	wire valid_O ;
	wire valid_P ;
	
	wire read_signal_A ;
	wire read_signal_B ;
	wire read_signal_C ;
	wire read_signal_D ;
	wire read_signal_E ;
	wire read_signal_F ;
	wire read_signal_G ;
	wire read_signal_H ;
	wire read_signal_I ;
	wire read_signal_J ;
	wire read_signal_K ;
	wire read_signal_L ;
	wire read_signal_M ;
	wire read_signal_N ;
	wire read_signal_O ;
	wire read_signal_P ;
	
	wire [63:0] data_o_1 ;
	wire [63:0] data_o_2 ;
	wire [63:0] data_o_3 ;
	wire [63:0] data_o_4 ;
	wire [63:0] data_o_5 ;
	wire [63:0] data_o_6 ;
	wire [63:0] data_o_7 ;
	wire [63:0] data_o_8 ;
	
	wire [31:0] r_addr ;
	reg  [31:0] r_addr_buf ;
	reg  [31:0] r_addr_buf_buf ;
	reg  [4:0]  blockSelect ;
	wire output_done ;
	
	wire [63:0] data_o_64bit ;
	
	mux8 mux8_0(
		.select (blockSelect[4:1]),
		.in_1 	(data_o_1),
		.in_2 	(data_o_2),
		.in_3 	(data_o_3),
		.in_4 	(data_o_4),
		.in_5 	(data_o_5),
		.in_6 	(data_o_6),
		.in_7 	(data_o_7),
		.in_8 	(data_o_8),
	    .out	(data_o_64bit)
	);
	
	mux2_64bit mux2_64bit_0(
		.in1(data_o_64bit[63:32]) ,
		.in2(data_o_64bit[31: 0]) ,
		.sel(blockSelect[0]) ,
		.out(data_o) 
	);
	
	assign output_done = (blockSelect==5'b10000)? 1 : 0 ;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			blockSelect <= 5'b00000 ;
		else
			begin
				if(r_addr_buf==32'd3135 && r_addr_buf_buf!=32'd3135)
					begin
						if(blockSelect==5'b10000)
							blockSelect <= blockSelect ;
						else
							blockSelect <= blockSelect + 1 ;
					end
				else
					blockSelect <= blockSelect ;
			end
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			r_addr_buf <= 32'd0 ;
		else
			r_addr_buf <= r_addr ;
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			r_addr_buf_buf <= 32'd0 ;
		else
			r_addr_buf_buf <= r_addr_buf ;
	end
	
	sequence2parallel sequence2parallel_A(
		.clk 		(clk),
		.rst_n 		(rst_n),
	    .data_i 	(data_i_A),
	    .valid_i 	(valid_i),
	    .data_o 	(data_s2p_A),
	    .valid_o 	(valid_A),
	    .read_signal(read_signal_A)
	);
	
	sequence2parallel sequence2parallel_B(
		.clk 		(clk),
		.rst_n 		(rst_n),
	    .data_i 	(data_i_B),
	    .valid_i 	(valid_i),
	    .data_o 	(data_s2p_B),
	    .valid_o 	(valid_B),
	    .read_signal(read_signal_B)
	);
	
	sequence2parallel sequence2parallel_C(
		.clk 		(clk),
		.rst_n 		(rst_n),
	    .data_i 	(data_i_C),
	    .valid_i 	(valid_i),
	    .data_o 	(data_s2p_C),
	    .valid_o 	(valid_C),
	    .read_signal(read_signal_C)
	);
	
	sequence2parallel sequence2parallel_D(
		.clk 		(clk),
		.rst_n 		(rst_n),
	    .data_i 	(data_i_D),
	    .valid_i 	(valid_i),
	    .data_o 	(data_s2p_D),
	    .valid_o 	(valid_D),
	    .read_signal(read_signal_D)
	);
	
	sequence2parallel sequence2parallel_E(
		.clk 		(clk),
		.rst_n 		(rst_n),
	    .data_i 	(data_i_E),
	    .valid_i 	(valid_i),
	    .data_o 	(data_s2p_E),
	    .valid_o 	(valid_E),
	    .read_signal(read_signal_E)
	);
	
	sequence2parallel sequence2parallel_F(
		.clk 		(clk),
		.rst_n 		(rst_n),
	    .data_i 	(data_i_F),
	    .valid_i 	(valid_i),
	    .data_o 	(data_s2p_F),
	    .valid_o 	(valid_F),
	    .read_signal(read_signal_F)
	);
	
	sequence2parallel sequence2parallel_G(
		.clk 		(clk),
		.rst_n 		(rst_n),
	    .data_i 	(data_i_G),
	    .valid_i 	(valid_i),
	    .data_o 	(data_s2p_G),
	    .valid_o 	(valid_G),
	    .read_signal(read_signal_G)
	);
	
	sequence2parallel sequence2parallel_H(
		.clk 		(clk),
		.rst_n 		(rst_n),
	    .data_i 	(data_i_H),
	    .valid_i 	(valid_i),
	    .data_o 	(data_s2p_H),
	    .valid_o 	(valid_H),
	    .read_signal(read_signal_H)
	);
	
	sequence2parallel sequence2parallel_I(
		.clk 		(clk),
		.rst_n 		(rst_n),
	    .data_i 	(data_i_I),
	    .valid_i 	(valid_i),
	    .data_o 	(data_s2p_I),
	    .valid_o 	(valid_I),
	    .read_signal(read_signal_I)
	);
	
	sequence2parallel sequence2parallel_J(
		.clk 		(clk),
		.rst_n 		(rst_n),
	    .data_i 	(data_i_J),
	    .valid_i 	(valid_i),
	    .data_o 	(data_s2p_J),
	    .valid_o 	(valid_J),
	    .read_signal(read_signal_J)
	);
	
	sequence2parallel sequence2parallel_K(
		.clk 		(clk),
		.rst_n 		(rst_n),
	    .data_i 	(data_i_K),
	    .valid_i 	(valid_i),
	    .data_o 	(data_s2p_K),
	    .valid_o 	(valid_K),
	    .read_signal(read_signal_K)
	);
	
	sequence2parallel sequence2parallel_L(
		.clk 		(clk),
		.rst_n 		(rst_n),
	    .data_i 	(data_i_L),
	    .valid_i 	(valid_i),
	    .data_o 	(data_s2p_L),
	    .valid_o 	(valid_L),
	    .read_signal(read_signal_L)
	);
	
	sequence2parallel sequence2parallel_M(
		.clk 		(clk),
		.rst_n 		(rst_n),
	    .data_i 	(data_i_M),
	    .valid_i 	(valid_i),
	    .data_o 	(data_s2p_M),
	    .valid_o 	(valid_M),
	    .read_signal(read_signal_M)
	);
	
	sequence2parallel sequence2parallel_N(
		.clk 		(clk),
		.rst_n 		(rst_n),
	    .data_i 	(data_i_N),
	    .valid_i 	(valid_i),
	    .data_o 	(data_s2p_N),
	    .valid_o 	(valid_N),
	    .read_signal(read_signal_N)
	);
	
	sequence2parallel sequence2parallel_O(
		.clk 		(clk),
		.rst_n 		(rst_n),
	    .data_i 	(data_i_O),
	    .valid_i 	(valid_i),
	    .data_o 	(data_s2p_O),
	    .valid_o 	(valid_O),
	    .read_signal(read_signal_O)
	);
	
	sequence2parallel sequence2parallel_P(
		.clk 		(clk),
		.rst_n 		(rst_n),
	    .data_i 	(data_i_P),
	    .valid_i 	(valid_i),
	    .data_o 	(data_s2p_P),
	    .valid_o 	(valid_P),
	    .read_signal(read_signal_P)
	);
	
	
	accumulator accumulator_1(
		.clk 			(clk), 
		.rst_n 			(rst_n),
		.data_i_1 		(data_s2p_A),
		.data_i_2 		(data_s2p_B),
		.valid_i	 	(valid_A),
		.read_signal 	(read_signal_A),
		.bus_free		(bus_free),
		.data_o 		(data_o_1),
		.valid_o		(valid_o),
		.r_addr_o 		(r_addr),
		.output_done	(output_done) ,
		.conv_done		(conv_done)
	);
	
	accumulator accumulator_2(
		.clk 			(clk), 
		.rst_n 			(rst_n),
		.data_i_1 		(data_s2p_C),
		.data_i_2 		(data_s2p_D),
		.valid_i	 	(valid_C),
		.read_signal 	(read_signal_C),
		.bus_free		(bus_free),
		.data_o 		(data_o_2),
		.valid_o		(),
		.r_addr_o 		(),
		.output_done	(output_done) ,
		.conv_done		()
		);
	
	accumulator accumulator_3(
		.clk 			(clk), 
		.rst_n 			(rst_n),
		.data_i_1 		(data_s2p_E),
		.data_i_2 		(data_s2p_F),
		.valid_i	 	(valid_E),
		.read_signal 	(read_signal_E),
		.bus_free		(bus_free),
		.data_o 		(data_o_3),
		.valid_o		(),
		.r_addr_o 		(),
		.output_done	(output_done) ,
		.conv_done		()
	);
	
	accumulator accumulator_4(
		.clk 			(clk), 
		.rst_n 			(rst_n),
		.data_i_1 		(data_s2p_G),
		.data_i_2 		(data_s2p_H),
		.valid_i	 	(valid_G),
		.read_signal 	(read_signal_G),
		.bus_free		(bus_free),
		.data_o 		(data_o_4),
		.valid_o		(),
		.r_addr_o 		(),
		.output_done	(output_done) ,
		.conv_done		()
	);
	
	accumulator accumulator_5(
		.clk 			(clk), 
		.rst_n 			(rst_n),
		.data_i_1 		(data_s2p_I),
		.data_i_2 		(data_s2p_J),
		.valid_i	 	(valid_I),
		.read_signal 	(read_signal_I),
		.bus_free		(bus_free),
		.data_o 		(data_o_5),
		.valid_o		(),
		.r_addr_o 		(),
		.output_done	(output_done) ,
		.conv_done		()
	);
	
	accumulator accumulator_6(
		.clk 			(clk), 
		.rst_n 			(rst_n),
		.data_i_1 		(data_s2p_K),
		.data_i_2 		(data_s2p_L),
		.valid_i	 	(valid_K),
		.read_signal 	(read_signal_L),
		.bus_free		(bus_free),
		.data_o 		(data_o_6),
		.valid_o		(),
		.r_addr_o 		(),
		.output_done	(output_done) ,
		.conv_done		()
	);
	
	accumulator accumulator_7(
		.clk 			(clk), 
		.rst_n 			(rst_n),
		.data_i_1 		(data_s2p_M),
		.data_i_2 		(data_s2p_N),
		.valid_i	 	(valid_M),
		.read_signal 	(read_signal_M),
		.bus_free		(bus_free),
		.data_o 		(data_o_7),
		.valid_o		(),
		.r_addr_o 		(),
		.output_done	(output_done) ,
		.conv_done		()
	);
	
	accumulator accumulator_8(
		.clk 			(clk), 
		.rst_n 			(rst_n),
		.data_i_1 		(data_s2p_O),
		.data_i_2 		(data_s2p_P),
		.valid_i	 	(valid_O),
		.read_signal 	(read_signal_O),
		.bus_free		(bus_free),
		.data_o 		(data_o_8),
		.valid_o		(),
		.r_addr_o 		(),
		.output_done	(output_done) ,
		.conv_done		()
	);
	
endmodule