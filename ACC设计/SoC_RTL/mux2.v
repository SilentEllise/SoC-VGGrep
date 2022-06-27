module mux2(
	input signed [7:0] in1 , 
	input signed [7:0] in2 ,
	
	input 		sel ,
	
	output signed [7:0] out
);

assign out = (sel==1'b0)?in1:in2 ;

endmodule