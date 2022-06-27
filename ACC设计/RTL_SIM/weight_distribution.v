module weight_distribution(
	input clk ,
	input rst_n ,
	
	input signed [7:0] w1 ,
	input signed [7:0] w2 ,
	input signed [7:0] w3 ,
	input signed [7:0] w4 ,
	input valid_i ,
	
	input switch_conv33 ,
	
	output weight_ing ,
	output signed [7:0] w33_1_1 ,
	output signed [7:0] w33_1_2 ,
	output signed [7:0] w33_1_3 ,
	output signed [7:0] w33_1_4 ,
	output signed [7:0] w33_1_5 ,
	output signed [7:0] w33_1_6 ,
	output signed [7:0] w33_1_7 ,
	output signed [7:0] w33_1_8 ,
	output signed [7:0] w33_1_9 ,
	output signed [7:0] w33_2_1 ,
	output signed [7:0] w33_2_2 ,
	output signed [7:0] w33_2_3 ,
	output signed [7:0] w33_2_4 ,
	output signed [7:0] w33_2_5 ,
	output signed [7:0] w33_2_6 ,
	output signed [7:0] w33_2_7 ,
	output signed [7:0] w33_2_8 ,
	output signed [7:0] w33_2_9 ,
	output signed [7:0] w33_3_1 ,
	output signed [7:0] w33_3_2 ,
	output signed [7:0] w33_3_3 ,
	output signed [7:0] w33_3_4 ,
	output signed [7:0] w33_3_5 ,
	output signed [7:0] w33_3_6 ,
	output signed [7:0] w33_3_7 ,
	output signed [7:0] w33_3_8 ,
	output signed [7:0] w33_3_9 ,
	output signed [7:0] w33_4_1 ,
	output signed [7:0] w33_4_2 ,
	output signed [7:0] w33_4_3 ,
	output signed [7:0] w33_4_4 ,
	output signed [7:0] w33_4_5 ,
	output signed [7:0] w33_4_6 ,
	output signed [7:0] w33_4_7 ,
	output signed [7:0] w33_4_8 ,
	output signed [7:0] w33_4_9 ,
	
	output signed [7:0] w11_1_1 ,
	output signed [7:0] w11_1_2 ,
	output signed [7:0] w11_1_3 ,
	output signed [7:0] w11_1_4 ,
	output signed [7:0] w11_1_5 ,
	output signed [7:0] w11_1_6 ,
	output signed [7:0] w11_1_7 ,
	output signed [7:0] w11_1_8 ,
	output signed [7:0] w11_1_9 ,
	output signed [7:0] w11_1_10 ,
	output signed [7:0] w11_1_11 ,
	output signed [7:0] w11_1_12 ,
	output signed [7:0] w11_1_13 ,
	output signed [7:0] w11_1_14 ,
	output signed [7:0] w11_1_15 ,
	output signed [7:0] w11_1_16 ,
	output signed [7:0] w11_2_1 ,
	output signed [7:0] w11_2_2 ,
	output signed [7:0] w11_2_3 ,
	output signed [7:0] w11_2_4 ,
	output signed [7:0] w11_2_5 ,
	output signed [7:0] w11_2_6 ,
	output signed [7:0] w11_2_7 ,
	output signed [7:0] w11_2_8 ,
	output signed [7:0] w11_2_9 ,
	output signed [7:0] w11_2_10 ,
	output signed [7:0] w11_2_11 ,
	output signed [7:0] w11_2_12 ,
	output signed [7:0] w11_2_13 ,
	output signed [7:0] w11_2_14 ,
	output signed [7:0] w11_2_15 ,
	output signed [7:0] w11_2_16 ,
	output signed [7:0] w11_3_1 ,
	output signed [7:0] w11_3_2 ,
	output signed [7:0] w11_3_3 ,
	output signed [7:0] w11_3_4 ,
	output signed [7:0] w11_3_5 ,
	output signed [7:0] w11_3_6 ,
	output signed [7:0] w11_3_7 ,
	output signed [7:0] w11_3_8 ,
	output signed [7:0] w11_3_9 ,
	output signed [7:0] w11_3_10 ,
	output signed [7:0] w11_3_11 ,
	output signed [7:0] w11_3_12 ,
	output signed [7:0] w11_3_13 ,
	output signed [7:0] w11_3_14 ,
	output signed [7:0] w11_3_15 ,
	output signed [7:0] w11_3_16 ,
	output signed [7:0] w11_4_1 ,
	output signed [7:0] w11_4_2 ,
	output signed [7:0] w11_4_3 ,
	output signed [7:0] w11_4_4 ,
	output signed [7:0] w11_4_5 ,
	output signed [7:0] w11_4_6 ,
	output signed [7:0] w11_4_7 ,
	output signed [7:0] w11_4_8 ,
	output signed [7:0] w11_4_9 ,
	output signed [7:0] w11_4_10 ,
	output signed [7:0] w11_4_11 ,
	output signed [7:0] w11_4_12 ,
	output signed [7:0] w11_4_13 ,
	output signed [7:0] w11_4_14 ,
	output signed [7:0] w11_4_15 ,
	output signed [7:0] w11_4_16
);

	reg signed [7:0] w_memory [0:799] ;
	reg [7:0] input_cnter ;
	reg [2:0] batch_33 ;
	reg [2:0] batch_11 ;
	reg switch_conv33_buf1 ;
	reg switch_conv33_buf2 ;
	reg switch_conv33_buf3 ;
	reg switch_conv33_buf4 ;
	reg switch_conv33_buf5 ;
	reg switch_conv33_buf6 ;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				switch_conv33_buf1 <= 1'b0 ;
				switch_conv33_buf2 <= 1'b0 ;
				switch_conv33_buf3 <= 1'b0 ;
				switch_conv33_buf4 <= 1'b0 ;
				switch_conv33_buf5 <= 1'b0 ;
				switch_conv33_buf6 <= 1'b0 ;
			end
		else
			begin
				switch_conv33_buf1 <= switch_conv33 ;
				switch_conv33_buf2 <= switch_conv33_buf1 ;
				switch_conv33_buf3 <= switch_conv33_buf2 ;
				switch_conv33_buf4 <= switch_conv33_buf3 ;
				switch_conv33_buf5 <= switch_conv33_buf4 ;
				switch_conv33_buf6 <= switch_conv33_buf5 ;
			end
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			input_cnter <= 8'd0 ;
		else
			if(valid_i == 1'b1)
				begin
					if(input_cnter == 8'd200)
						input_cnter <= input_cnter ;
					else
						input_cnter <= input_cnter + 1 ;
				end
			else
				input_cnter <= input_cnter ;
	end
	
	always@(posedge clk)
	begin
		if(valid_i && weight_ing)
			begin
				w_memory[input_cnter*4+0] <= w1 ;
				w_memory[input_cnter*4+1] <= w2 ;
				w_memory[input_cnter*4+2] <= w3 ;
				w_memory[input_cnter*4+3] <= w4 ;
			end
	end
	
	assign weight_ing = (input_cnter<8'd200)? 1'b1 : 1'b0 ;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			batch_33 <= 3'b000 ;
		else
			begin
				if(switch_conv33==1'b1)
					batch_33 <= batch_33 + 1 ;
				else
					batch_33 <= batch_33 ;
			end
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			batch_11 <= 3'b000 ;
		else
			begin
				if(switch_conv33_buf6==1'b1)
					batch_11 <= batch_11 + 1 ;
				else
					batch_11 <= batch_11 ;
			end
	end
	
	assign w33_1_1 = w_memory[batch_33*36 +  0] ;
	assign w33_1_2 = w_memory[batch_33*36 +  1] ;
	assign w33_1_3 = w_memory[batch_33*36 +  2] ;
	assign w33_1_4 = w_memory[batch_33*36 +  3] ;
	assign w33_1_5 = w_memory[batch_33*36 +  4] ;
	assign w33_1_6 = w_memory[batch_33*36 +  5] ;
	assign w33_1_7 = w_memory[batch_33*36 +  6] ;
	assign w33_1_8 = w_memory[batch_33*36 +  7] ;
	assign w33_1_9 = w_memory[batch_33*36 +  8] ;
	assign w33_2_1 = w_memory[batch_33*36 +  9] ;
    assign w33_2_2 = w_memory[batch_33*36 + 10] ; 
    assign w33_2_3 = w_memory[batch_33*36 + 11] ; 
    assign w33_2_4 = w_memory[batch_33*36 + 12] ; 
    assign w33_2_5 = w_memory[batch_33*36 + 13] ; 
    assign w33_2_6 = w_memory[batch_33*36 + 14] ; 
    assign w33_2_7 = w_memory[batch_33*36 + 15] ; 
    assign w33_2_8 = w_memory[batch_33*36 + 16] ; 
    assign w33_2_9 = w_memory[batch_33*36 + 17] ; 
    assign w33_3_1 = w_memory[batch_33*36 + 18] ; 
    assign w33_3_2 = w_memory[batch_33*36 + 19] ;
    assign w33_3_3 = w_memory[batch_33*36 + 20] ;
    assign w33_3_4 = w_memory[batch_33*36 + 21] ;
    assign w33_3_5 = w_memory[batch_33*36 + 22] ;
    assign w33_3_6 = w_memory[batch_33*36 + 23] ;
    assign w33_3_7 = w_memory[batch_33*36 + 24] ;
    assign w33_3_8 = w_memory[batch_33*36 + 25] ;
    assign w33_3_9 = w_memory[batch_33*36 + 26] ;
    assign w33_4_1 = w_memory[batch_33*36 + 27] ;
    assign w33_4_2 = w_memory[batch_33*36 + 28] ;
    assign w33_4_3 = w_memory[batch_33*36 + 29] ;
    assign w33_4_4 = w_memory[batch_33*36 + 30] ;
    assign w33_4_5 = w_memory[batch_33*36 + 31] ;
    assign w33_4_6 = w_memory[batch_33*36 + 32] ;
    assign w33_4_7 = w_memory[batch_33*36 + 33] ;
    assign w33_4_8 = w_memory[batch_33*36 + 34] ;
    assign w33_4_9 = w_memory[batch_33*36 + 35] ;
	
	assign w11_1_1  = w_memory[288 + batch_11*4+ 0 +  0*32] ;
    assign w11_1_2  = w_memory[288 + batch_11*4+ 0 +  1*32] ;
    assign w11_1_3  = w_memory[288 + batch_11*4+ 0 +  2*32] ;
    assign w11_1_4  = w_memory[288 + batch_11*4+ 0 +  3*32] ;
    assign w11_1_5  = w_memory[288 + batch_11*4+ 0 +  4*32] ;
    assign w11_1_6  = w_memory[288 + batch_11*4+ 0 +  5*32] ;
    assign w11_1_7  = w_memory[288 + batch_11*4+ 0 +  6*32] ;
    assign w11_1_8  = w_memory[288 + batch_11*4+ 0 +  7*32] ;
    assign w11_1_9  = w_memory[288 + batch_11*4+ 0 +  8*32] ;
    assign w11_1_10 = w_memory[288 + batch_11*4+ 0 +  9*32] ;
    assign w11_1_11 = w_memory[288 + batch_11*4+ 0 + 10*32] ;
    assign w11_1_12 = w_memory[288 + batch_11*4+ 0 + 11*32] ;
    assign w11_1_13 = w_memory[288 + batch_11*4+ 0 + 12*32] ;
    assign w11_1_14 = w_memory[288 + batch_11*4+ 0 + 13*32] ;
    assign w11_1_15 = w_memory[288 + batch_11*4+ 0 + 14*32] ;
    assign w11_1_16 = w_memory[288 + batch_11*4+ 0 + 15*32] ;
    assign w11_2_1  = w_memory[288 + batch_11*4+ 1 +  0*32] ;
    assign w11_2_2  = w_memory[288 + batch_11*4+ 1 +  1*32] ;
    assign w11_2_3  = w_memory[288 + batch_11*4+ 1 +  2*32] ;
    assign w11_2_4  = w_memory[288 + batch_11*4+ 1 +  3*32] ;
    assign w11_2_5  = w_memory[288 + batch_11*4+ 1 +  4*32] ;
    assign w11_2_6  = w_memory[288 + batch_11*4+ 1 +  5*32] ;
    assign w11_2_7  = w_memory[288 + batch_11*4+ 1 +  6*32] ;
    assign w11_2_8  = w_memory[288 + batch_11*4+ 1 +  7*32] ;
    assign w11_2_9  = w_memory[288 + batch_11*4+ 1 +  8*32] ;
    assign w11_2_10 = w_memory[288 + batch_11*4+ 1 +  9*32] ;
    assign w11_2_11 = w_memory[288 + batch_11*4+ 1 + 10*32] ;
    assign w11_2_12 = w_memory[288 + batch_11*4+ 1 + 11*32] ;
    assign w11_2_13 = w_memory[288 + batch_11*4+ 1 + 12*32] ;
    assign w11_2_14 = w_memory[288 + batch_11*4+ 1 + 13*32] ;
    assign w11_2_15 = w_memory[288 + batch_11*4+ 1 + 14*32] ;
    assign w11_2_16 = w_memory[288 + batch_11*4+ 1 + 15*32] ;
    assign w11_3_1  = w_memory[288 + batch_11*4+ 2 +  0*32] ;
    assign w11_3_2  = w_memory[288 + batch_11*4+ 2 +  1*32] ;
    assign w11_3_3  = w_memory[288 + batch_11*4+ 2 +  2*32] ;
    assign w11_3_4  = w_memory[288 + batch_11*4+ 2 +  3*32] ;
    assign w11_3_5  = w_memory[288 + batch_11*4+ 2 +  4*32] ;
    assign w11_3_6  = w_memory[288 + batch_11*4+ 2 +  5*32] ;
    assign w11_3_7  = w_memory[288 + batch_11*4+ 2 +  6*32] ;
    assign w11_3_8  = w_memory[288 + batch_11*4+ 2 +  7*32] ;
    assign w11_3_9  = w_memory[288 + batch_11*4+ 2 +  8*32] ;
    assign w11_3_10 = w_memory[288 + batch_11*4+ 2 +  9*32] ;
    assign w11_3_11 = w_memory[288 + batch_11*4+ 2 + 10*32] ;
    assign w11_3_12 = w_memory[288 + batch_11*4+ 2 + 11*32] ;
    assign w11_3_13 = w_memory[288 + batch_11*4+ 2 + 12*32] ;
    assign w11_3_14 = w_memory[288 + batch_11*4+ 2 + 13*32] ;
    assign w11_3_15 = w_memory[288 + batch_11*4+ 2 + 14*32] ;
    assign w11_3_16 = w_memory[288 + batch_11*4+ 2 + 15*32] ;
    assign w11_4_1  = w_memory[288 + batch_11*4+ 3 +  0*32] ;
    assign w11_4_2  = w_memory[288 + batch_11*4+ 3 +  1*32] ;
    assign w11_4_3  = w_memory[288 + batch_11*4+ 3 +  2*32] ;
    assign w11_4_4  = w_memory[288 + batch_11*4+ 3 +  3*32] ;
    assign w11_4_5  = w_memory[288 + batch_11*4+ 3 +  4*32] ;
    assign w11_4_6  = w_memory[288 + batch_11*4+ 3 +  5*32] ;
    assign w11_4_7  = w_memory[288 + batch_11*4+ 3 +  6*32] ;
    assign w11_4_8  = w_memory[288 + batch_11*4+ 3 +  7*32] ;
    assign w11_4_9  = w_memory[288 + batch_11*4+ 3 +  8*32] ;
    assign w11_4_10 = w_memory[288 + batch_11*4+ 3 +  9*32] ;
    assign w11_4_11 = w_memory[288 + batch_11*4+ 3 + 10*32] ;
    assign w11_4_12 = w_memory[288 + batch_11*4+ 3 + 11*32] ;
    assign w11_4_13 = w_memory[288 + batch_11*4+ 3 + 12*32] ;
    assign w11_4_14 = w_memory[288 + batch_11*4+ 3 + 13*32] ;
    assign w11_4_15 = w_memory[288 + batch_11*4+ 3 + 14*32] ;
    assign w11_4_16 = w_memory[288 + batch_11*4+ 3 + 15*32] ;
	
endmodule