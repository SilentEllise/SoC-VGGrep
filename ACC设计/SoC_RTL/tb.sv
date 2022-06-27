`timescale 1ns/1ps
module tb();

	logic clk ;
	logic rst_n ;
	
	logic [31:0] data_i ;
	logic valid_i ;
	logic bus_free ;
	
	logic weight_ing ;
	logic [31:0] data_o ;
	logic valid_o ;
	logic conv_done;

	top_acce top_acce_0(
		.clk 		(clk),
		.rst_n 		(rst_n),
		.data_i 	(data_i),
		.valid_i 	(valid_i),
		.bus_free 	(bus_free),
		.weight_ing (weight_ing),
		.data_o 	(data_o),
		.valid_o	(valid_o),
		.conv_done	(conv_done)
	);
	
	
	
	initial begin
		clk = 0 ;
		forever #5 clk = ~clk ;
	end
	
	initial begin
		rst_n = 0 ;
		repeat(3) @(posedge clk) ;
		rst_n = 1 ;
	end
	
	initial begin
		@(posedge rst_n) ;
		repeat(2) @(posedge clk) ;
		forever begin
			@(posedge clk)
			valid_i=1;
			bus_free=1;
			data_i=$urandom;
		end
	end
endmodule