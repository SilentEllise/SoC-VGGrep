`timescale 1ns / 1ps
////////////////////////

module test_topData_tb();

reg clk = 0 ;
reg rst_n = 0 ;
reg bus_free ;

wire weight_ing ;
wire [31:0] data_o ;
wire valid_o ;
wire [31:0] data_i ;
wire conv_done ;

reg signed [31:0]memory[0:100551];
reg [19:0] mem_addr ;
wire valid_i ;
reg [1:0] input_counter ;

integer file_write ;


always #5 clk <= ~clk ;
//always #10 bus_free <= ~bus_free ;

initial
begin
	file_write = $fopen("D:/MONE/SoC/Final_project/RTL/outputData/outputData.txt","w") ;
	rst_n = 0 ;
	#25 rst_n = 1 ;
end

initial
begin
	$readmemb ( "D:/MONE/SoC/Final_project/RTL/inputData/top_in/data_top_in.txt" , memory );
end

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
			mem_addr <= 20'b11111111111111111111 ;
			bus_free <= 1'b0 ;
		end
	else
		begin
			if(input_counter == 2'b10)
				begin
					bus_free <= 1'b1 ;
					if(mem_addr == 20'd101552)
						mem_addr <= mem_addr ;
					else
						mem_addr <= mem_addr + 1 ;
				end
			else
				begin
					mem_addr <= mem_addr ;
					bus_free <= 1'b0 ;
				end
		end
end

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		input_counter <= 2'b00 ;
	else
		begin
			if(input_counter == 2'b10)
				input_counter <= 2'b00 ;
			else
				input_counter <= input_counter + 1 ;
		end
end

always@(posedge clk)
begin
	if(valid_o)
		$fwrite(file_write,"%h\n",data_o) ;
end

assign valid_i = (mem_addr >= 20'd0 && mem_addr<20'd101552 && input_counter==2'b00)? 1'b1 : 1'b0 ;
assign data_i = memory[mem_addr] ;


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





















