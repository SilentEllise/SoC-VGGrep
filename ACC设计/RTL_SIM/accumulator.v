/**
----------------------------------------------------------------
Module Name  : accumulator
Sub Module	 : 2 sram , 2 parallelAdder
----------------------------------------------------------------
**/

module accumulator(
	input clk , 
	input rst_n ,
	
	input [31:0] data_i_1 ,
	input [31:0] data_i_2 ,
	input valid_i ,
	input read_signal ,
	
	input bus_free ,
	output [63:0] data_o ,
	output valid_o ,
	output [31:0] r_addr_o ,
	input output_done ,
	output reg conv_done
);

	reg [31:0] addr ;
	reg [31:0] r_addr ;
	
	wire [31:0] addr_2_sram ;
	
	wire [63:0] data_i_sram ;
	wire [31:0] data_i_sram_1 ;
	wire [31:0] data_i_sram_2 ;
	wire [63:0] data_o_sram ;
	wire [31:0] data_o_sram_1 ;
	wire [31:0] data_o_sram_2 ;
	
	assign data_i_sram = {data_i_sram_1 , data_i_sram_2} ;
	assign data_o_sram_1 = data_o_sram[63:32] ;
	assign data_o_sram_2 = data_o_sram[31: 0] ;
	
	reg we ;
	reg chnl_done ;
	reg chnl_done_buf ;
	reg [3:0] chnl_done_cnter ;
	reg conv_done_buf ;
	reg bus_free_buf ;
	reg valid_o_reg ;
	
	assign data_o = data_o_sram ;
	assign addr_2_sram = (conv_done_buf==1'b1)? r_addr : addr ;
	assign r_addr_o = r_addr ;
	
	assign valid_o = valid_o_reg && (!output_done) ;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			addr <= 32'hFFFFFFFF ;
		else
			begin
				if(read_signal==1'b1)
					begin
						if(addr==32'd3135)
							addr <= 32'd0 ;
						else
							addr <= addr + 1 ;
					end
				else
					addr <= addr ;
			end
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			r_addr <= 32'hFFFFFFFF ;
		else
			begin
				if(conv_done==1'b1 && bus_free==1'b1)
					begin
						if(r_addr==32'd3135)
							r_addr <= 32'd0 ;
						else
							r_addr <= r_addr + 1 ;
					end
				else
					r_addr <= r_addr ;
			end
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			chnl_done <= 1'b0 ;
		else
			begin
				if(addr==32'd3135 && we==1'b1)
					chnl_done <= 1'b1 ;
				else
					chnl_done <= 1'b0 ;
			end
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			chnl_done_buf <= 1'b0 ;
		else
			chnl_done_buf <= chnl_done ;
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			conv_done_buf <= 1'b0 ;
		else
			conv_done_buf <= conv_done ;
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			bus_free_buf <= 1'b0 ;
		else
			bus_free_buf <= bus_free ;
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			valid_o_reg <= 1'b0 ;
		else
			valid_o_reg <=  conv_done_buf && bus_free_buf ;
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			chnl_done_cnter <= 4'b0000 ;
		else
			begin
				if(chnl_done==1'b1 && chnl_done_buf==1'b0)
					begin
						if(chnl_done_cnter==4'b1000)
							chnl_done_cnter <= chnl_done_cnter ;
						else
							chnl_done_cnter <= chnl_done_cnter + 1 ;
					end
				else
					chnl_done_cnter <= chnl_done_cnter ;
			end
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			conv_done <= 1'b0 ;
		else
			begin
				if(chnl_done_cnter==4'b1000)
					conv_done <= 1'b1 ;
				else
					conv_done <= conv_done ;
			end
	end
		
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			we <= 1'b0 ;
		else
			begin
				if(chnl_done_cnter==4'b1000)
					we <= 1'b0 ;
				else
					we <= valid_i ;
			end
	end

	parallelAdder parallelAdder_1(
		.clk(clk) ,
		.rst_n(rst_n) ,
		.in1(data_i_1) ,
		.in2(data_o_sram_1) ,
		.out(data_i_sram_1)
	);
	
	parallelAdder parallelAdder_2(
		.clk(clk) ,
		.rst_n(rst_n) ,
		.in1(data_i_2) ,
		.in2(data_o_sram_2) ,
		.out(data_i_sram_2)
	);
	
	

	sirv_sim_ram #(64,8,15) sram0(
		.clk	(clk), 
        	.cs	(1'b1),
        	.we	(we),
        	.wem	(8'b11111111),
        	.addr	(addr_2_sram[14:0]),
		.din	(data_i_sram), 
        	.dout	(data_o_sram)
	);

endmodule


