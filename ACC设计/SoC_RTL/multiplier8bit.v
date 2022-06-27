module multiplier8bit(
	input clk ,
	input rst_n ,
	
	input signed [7:0] in1 ,
	input signed [7:0] in2 ,
	
	output signed [14:0] out 
	
);

	reg signed [15:0] out16bit ;

	assign out = out16bit[14:0] ;

	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			out16bit <= 16'h0000 ;
		else
			out16bit <= in1 * in2 ;
	end

endmodule