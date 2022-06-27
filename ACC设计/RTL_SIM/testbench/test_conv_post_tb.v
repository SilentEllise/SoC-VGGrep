`timescale 1ns / 1ps
////////////////////////

module test_conv_post_tb();

reg clk = 0 ;
reg rst_n = 0 ;
reg valid_i ;
wire signed [7:0] data_i_1 ;
wire signed [7:0] data_i_2 ;
wire signed [7:0] data_i_3 ;
wire signed [7:0] data_i_4 ;

reg [17:0] data_i_addr ;

reg signed [7:0]data_i_1_mem[0:100351];
reg signed [7:0]data_i_2_mem[0:100351];
reg signed [7:0]data_i_3_mem[0:100351];
reg signed [7:0]data_i_4_mem[0:100351];

reg [1:0] counter_0_to_3 ;

always #5 clk <= ~clk ;

initial
begin
	rst_n = 0 ;
	#25 rst_n = 1 ;
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
		data_i_addr <= 18'd0 ;
	else
		begin
			if(counter_0_to_3 != 2'b11)
				begin
					if(data_i_addr != 18'd100352)
						data_i_addr <= data_i_addr + 1 ;
					else
						data_i_addr <= data_i_addr ;
				end
			else
				data_i_addr <= data_i_addr ;
		end
end

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		valid_i <= 1'b0 ;
	else
		begin
			if(counter_0_to_3 != 2'b11)
				begin
					if(data_i_addr != 18'd100352)
						valid_i <= 1'b1 ;
					else
						valid_i <= 1'b0 ;
				end
			else
				valid_i <= 1'b0 ;
		end
end

assign data_i_1 = data_i_1_mem[data_i_addr-1] ;
assign data_i_2 = data_i_2_mem[data_i_addr-1] ;
assign data_i_3 = data_i_3_mem[data_i_addr-1] ;
assign data_i_4 = data_i_4_mem[data_i_addr-1] ;

initial
begin
	$readmemb ( "D:/MONE/SoC/Final_project/RTL/inputData/inputData1.txt", data_i_1_mem );
	$readmemb ( "D:/MONE/SoC/Final_project/RTL/inputData/inputData2.txt", data_i_2_mem );
	$readmemb ( "D:/MONE/SoC/Final_project/RTL/inputData/inputData3.txt", data_i_3_mem );
	$readmemb ( "D:/MONE/SoC/Final_project/RTL/inputData/inputData4.txt", data_i_4_mem );
end



wire [7:0] data_o_1 ;
wire [7:0] data_o_2 ;
wire [7:0] data_o_3 ;
wire [7:0] data_o_4 ;
wire valid_o ;





conv_post conv_post_0(
	.clk 	(clk),
    .rst_n 	(rst_n),
    .data_i_1 	(data_i_1),
    .valid_i_1 	(valid_i),
    .data_i_2 	(data_i_2),
    .valid_i_2 	(valid_i),
    .data_i_3 	(data_i_3),	
    .valid_i_3 	(valid_i),
    .data_i_4 	(data_i_4),
    .valid_i_4 	(valid_i),
    .wA(8'b01111111) ,
    .wB(8'b01111111) ,
    .wC(8'b01111111) ,
    .wD(8'b01111111) ,
    .wE(8'b01111111) ,
    .wF(8'b01111111) ,
    .wG(8'b01111111) ,
    .wH(8'b01111111) ,
    .wI(8'b01111111) ,
    .wJ(8'b01111111) ,
    .wK(8'b01111111) ,
    .wL(8'b01111111) ,
    .wM(8'b01111111) ,
    .wN(8'b01111111) ,
    .wO(8'b01111111) ,
    .wP(8'b01111111) ,
	.bus_free(1'b1) ,
    .data_o_1(data_o_1) ,
    .data_o_2(data_o_2) ,
    .data_o_3(data_o_3) ,
    .data_o_4(data_o_4) ,
    .valid_o(valid_o)
);

endmodule








