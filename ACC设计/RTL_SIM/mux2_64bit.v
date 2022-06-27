

module mux2_64bit(
	input signed [31:0] in1 , 
	input signed [31:0] in2 ,
	
	input sel ,
	
	output signed [31:0] out
);

assign out = (sel==1'b0)?in1:in2 ;

endmodule