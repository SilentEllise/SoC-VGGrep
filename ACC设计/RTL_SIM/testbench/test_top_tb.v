`timescale 1ns / 1ps
////////////////////////

module test_top_tb();

reg clk = 0 ;
reg rst_n = 0 ;
reg bus_free = 1 ;

wire weight_ing ;
wire [31:0] data_o ;
wire valid_o ;
wire [31:0] data_i_w ;
wire [31:0] data_i_fm ;
wire [31:0] data_i ;
wire conv_done ;

reg signed [7:0]fm_mem[0:401407];
reg signed [7:0]w_mem [0:799];
reg [7:0] weight_addr ;
reg [19:0] fm_addr ;
wire valid_i ;
reg weight_ing_buf ;
reg [2:0] batch_cnter ;


always #5 clk <= ~clk ;
always #10 bus_free <= ~bus_free ;

initial
begin
	rst_n = 0 ;
	#25 rst_n = 1 ;
end

initial
begin
	$readmemb ( "D:/MONE/SoC/Final_project/RTL/inputData/top_in/featureMap.txt" , fm_mem );
	$readmemb ( "D:/MONE/SoC/Final_project/RTL/inputData/top_in/weights.txt", w_mem );
end

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		weight_addr <= 8'b11111111 ;
	else
		begin
			if(weight_addr != 8'd200)
				weight_addr <= weight_addr + 1 ;
			else
				weight_addr <= weight_addr ;
		end
end

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
			fm_addr <= 20'b11111111111111111111 ;
			batch_cnter <= 3'b000 ;
		end
	else
		begin
			if(weight_ing == 1'b0)
				begin
					if(fm_addr == 20'd12543)
						begin
							fm_addr <= 20'd0 ;
							batch_cnter <= batch_cnter + 1 ;
						end
					else
						begin
							fm_addr <= fm_addr + 1 ;
							batch_cnter <= batch_cnter ;
						end
				end
			else
				begin
					fm_addr <= fm_addr ;
					batch_cnter <= batch_cnter ;
				end
		end
end

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		weight_ing_buf <= 1'b1 ;
	else
		weight_ing_buf <= weight_ing ;
end

//always@(posedge clk or negedge rst_n)
//begin
//	if(!rst_n)
//		valid_i <= 1'b0 ;
//	else
//		begin
//			if((weight_addr >= 8'd0 && weight_addr <= 8'd199)||(fm_addr >= 20'd0))
//				valid_i <= 1'b1 ;
//			else
//				valid_i <= 1'b0 ;
//		end
//end

assign valid_i = ((weight_addr >= 8'd0 && weight_addr <= 8'd199)||(fm_addr >= 20'd0 && fm_addr!=20'hFFFFF))? 1'b1 : 1'b0 ;
assign data_i = (weight_ing_buf==1'b1)? data_i_w : data_i_fm ;




assign data_i_w = {{w_mem[weight_addr*4+0]},
				   {w_mem[weight_addr*4+1]},
				   {w_mem[weight_addr*4+2]},
				   {w_mem[weight_addr*4+3]}} ;
				   
assign data_i_fm = {{fm_mem[(batch_cnter*4+0)*12544+fm_addr]},
				    {fm_mem[(batch_cnter*4+1)*12544+fm_addr]},
				    {fm_mem[(batch_cnter*4+2)*12544+fm_addr]},
				    {fm_mem[(batch_cnter*4+3)*12544+fm_addr]}} ;





top top_0(
	.clk 			(clk),
    .rst_n 			(rst_n),
    .data_i 		(data_i),
    .valid_i 		(valid_i),
    .bus_free 		(bus_free),
    .weight_ing 	(weight_ing),
	.data_o 		(data_o),
    .valid_o       	(valid_o) ,
	.conv_done		(conv_done)
);


endmodule





















