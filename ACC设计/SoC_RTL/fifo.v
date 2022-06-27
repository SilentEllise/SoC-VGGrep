/**
----------------------------------------------------------------
Module Name  : fifo
----------------------------------------------------------------
**/

module fifo(
	input clk ,
	input rst_n ,
	
	input signed [7:0] data_i ,
	input signed valid_i ,
	
	output reg signed [7:0] data_o
);
	reg [6:0] r_addr ;
	reg [6:0] w_addr ;
	reg signed [7:0] memory [0:108] ;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				r_addr <= 7'd1 ;
				w_addr <= 7'd0 ;
			end
		else
			begin
				if(valid_i == 1'h1)
					begin
						if(r_addr == 7'd108)
							r_addr <= 7'd0 ;
						else
							r_addr <= r_addr + 1 ;
						if(w_addr == 7'd108)
							w_addr <= 7'd0 ;
						else
							w_addr <= w_addr + 1 ;
					end
				else
					begin
						r_addr <= r_addr ;
						w_addr <= w_addr ;
					end
			end
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			memory[w_addr] <= memory[w_addr] ;
		else
			if(valid_i == 1'h1)
				memory[w_addr] <= data_i ;
			else
				memory[w_addr] <= memory[w_addr] ;
	end

	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			data_o <= 8'h0 ;
		else
			begin
				if(valid_i == 1'h1)
					data_o <= memory[r_addr] ;
				else
					data_o <= data_o ;
			end
	end

endmodule

