module PE(
	input  clk ,
	input  rst_n ,
	
	input  valid ,
	input  enable ,
	input  signed [7:0] data_i ,
	output signed [7:0] data_o ,
	output signed [7:0] data_pe2multipleBar
);

	reg signed [7:0] data_buf ;
	assign data_o = data_buf ;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			data_buf <= 8'h00 ;
		else
			begin
				if(valid==1'h1)
					data_buf <= data_i ;
				else
					data_buf <= data_buf ;
			end
	end
	
	mux2 mux2_0(
		.in1(8'h00) ,
		.in2(data_i) ,
		.sel(enable) ,
		.out(data_pe2multipleBar)
	);

endmodule


















