`timescale 1ns / 1ps
////////////////////////

module test_conv_tb();

reg clk = 0 ;
reg rst_n = 0 ;

reg valid_i ;
wire [7:0] data_i ;
reg [19:0] featureMap_addr ;
//reg [9 :0] weight33_addr ;
//reg [9 :0] weight11_addr ;
reg signed [7:0]featureMap_mem[0:401407];
reg signed [7:0]weight33_mem[0:287];
reg signed [7:0]weight11_mem[0:511];
reg [1:0] counter_0_to_3 ;

wire valid_o ;
wire [7:0] data_o ;
wire chnl_done ;

always #5 clk <= ~clk ;

initial
begin
	rst_n = 0 ;
	#25 rst_n = 1 ;
end

assign data_i = featureMap_mem[featureMap_addr-1] ;

initial
begin
	$readmemb ( "D:/MONE/SoC/Final_project/data_dec_2_bin/data_bin/featureMap.txt", featureMap_mem );
	$readmemb ( "D:/MONE/SoC/Final_project/data_dec_2_bin/data_bin/weight33.txt", weight33_mem );
	$readmemb ( "D:/MONE/SoC/Final_project/data_dec_2_bin/data_bin/weight11.txt", weight11_mem );
end

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		counter_0_to_3 <= 2'b00 ;
	else
		counter_0_to_3 <= counter_0_to_3 + 1 ;
end

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		featureMap_addr <= 20'b0 ;
	else
		begin
			if(counter_0_to_3 != 2'b11)
				featureMap_addr <= featureMap_addr + 1 ;
			else
				featureMap_addr <= featureMap_addr ;
		end
		
end

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		valid_i <= 1'b0 ;
	else
		begin
			if(counter_0_to_3 != 2'b11)
				valid_i <= 1'b1 ;
			else
				valid_i <= 1'b0 ;
		end
end


conv conv_0(
	.clk 		(clk),
	.rst_n 		(rst_n),
	.data_i 	(data_i),
	.valid_i 	(valid_i),
	.weight1 	(weight33_mem[8]),
	.weight2 	(weight33_mem[7]),
	.weight3 	(weight33_mem[6]),
	.weight4 	(weight33_mem[5]),
	.weight5 	(weight33_mem[4]),
	.weight6 	(weight33_mem[3]),
	.weight7 	(weight33_mem[2]),
	.weight8 	(weight33_mem[1]),
	.weight9 	(weight33_mem[0]),
	.data_o 	(data_o),
	.valid_o    (valid_o),
	.chnl_done	(chnl_done)
);

endmodule