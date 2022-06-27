module ReLU(
	input clk ,
	input rst_n ,
	
	input signed [7:0] data_i_1 ,
	input signed [7:0] data_i_2 ,
	input signed [7:0] data_i_3 ,
	input signed [7:0] data_i_4 ,
	input valid_i ,
	
	output reg signed [7:0] data_o_1 ,
	output reg signed [7:0] data_o_2 ,
	output reg signed [7:0] data_o_3 ,
	output reg signed [7:0] data_o_4 ,
	output reg valid_o
);

	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				valid_o <= 8'b0 ;
			end
		else
			begin
				valid_o <= valid_i ;
			end
	end

	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				data_o_1 <= 8'b0 ;
			end
		else
			begin
				data_o_1 <= (data_i_1[7] == 1'b0)? data_i_1 : 8'b0 ;
			end
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				data_o_2 <= 8'b0 ;
			end
		else
			begin
				data_o_2 <= (data_i_2[7] == 1'b0)? data_i_2 : 8'b0 ;
			end
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				data_o_3 <= 8'b0 ;
			end
		else
			begin
				data_o_3 <= (data_i_3[7] == 1'b0)? data_i_3 : 8'b0 ;
			end
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				data_o_4 <= 8'b0 ;
			end
		else
			begin
				data_o_4 <= (data_i_4[7] == 1'b0)? data_i_4 : 8'b0 ;
			end
	end
	
endmodule