module sequence2parallel(
	input clk ,
	input rst_n ,
	
	input signed [7:0] data_i ,
	input valid_i ,
	
	output [31:0] data_o ,
	output reg valid_o ,
	output reg read_signal
);

	reg signed [7:0] buf_r1c1 , buf_r1c2 , buf_r1c3 , buf_r1c4 ;
	reg signed [7:0] buf_r2c1 , buf_r2c2 , buf_r2c3 ;
	reg signed [7:0] buf_r3c1 , buf_r3c2 ;
	reg signed [7:0] buf_r4c1 ;
	
	reg [2:0] counter ;
	reg [2:0] counter_delay ;
	
	assign data_o = {buf_r1c4,buf_r2c3,buf_r3c2,buf_r4c1} ;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				buf_r1c1 <= 7'd0 ;
				buf_r1c2 <= 7'd0 ;
				buf_r1c3 <= 7'd0 ;
				buf_r1c4 <= 7'd0 ;
			end
		else
			begin
				if(valid_i==1'b1)
					begin
						buf_r1c1 <= data_i ;
						buf_r1c2 <= buf_r1c1 ;
						buf_r1c3 <= buf_r1c2 ;
						buf_r1c4 <= buf_r1c3 ;
					end
				else
					begin
						buf_r1c1 <= buf_r1c1 ;
						buf_r1c2 <= buf_r1c2 ;
						buf_r1c3 <= buf_r1c3 ;
						buf_r1c4 <= buf_r1c4 ;
					end
			end
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				buf_r2c1 <= 7'd0 ;
				buf_r2c2 <= 7'd0 ;
				buf_r2c3 <= 7'd0 ;
			end
		else
			begin
				if(valid_i==1'b1)
					begin
						buf_r2c1 <= data_i ;
						buf_r2c2 <= buf_r2c1 ;
						buf_r2c3 <= buf_r2c2 ;
					end
				else
					begin
						buf_r2c1 <= buf_r2c1 ;
						buf_r2c2 <= buf_r2c2 ;
						buf_r2c3 <= buf_r2c3 ;
					end
			end
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				buf_r3c1 <= 7'd0 ;
				buf_r3c2 <= 7'd0 ;
			end
		else
			begin
				if(valid_i==1'b1)
					begin
						buf_r3c1 <= data_i ;
						buf_r3c2 <= buf_r3c1 ;
					end
				else
					begin
						buf_r3c1 <= buf_r3c1 ;
						buf_r3c2 <= buf_r3c2 ;
					end
			end
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				buf_r4c1 <= 7'd0 ;
			end
		else
			begin
				if(valid_i==1'b1)
					buf_r4c1 <= data_i ;
				else
					buf_r4c1 <= buf_r4c1 ;
			end
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				counter <= 3'b000 ;
			end
		else
			begin
				if(valid_i==1'b1)
					begin
						if(counter==3'b100)
							counter <= 3'b001 ;
						else
							counter <= counter + 1 ;
					end
				else
					counter <= counter ;
			end
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				counter_delay <= 3'b000 ;
			end
		else
			counter_delay <= counter ;
	end

	always@(*)
	begin
		if(counter==3'b100 && counter_delay!=3'b100)
			valid_o = 1'b1 ;
		else
			valid_o = 1'b0 ;
	end
	
	always@(*)
	begin
		if(counter==3'b010 && counter_delay!=3'b010)
			read_signal = 1'b1 ;
		else
			read_signal = 1'b0 ;
	end

endmodule









