module icb_ctrl_mas(
	input 			clk ,
	input			rst_n ,
	input			running ,
	// icb port
	output			mas_icb_cmd_valid ,
	input			mas_icb_cmd_ready ,
	output [31:0]	mas_icb_cmd_addr  ,
	output			mas_icb_cmd_read  ,
	output [31:0]	mas_icb_cmd_wdata ,
	output [3:0]	mas_icb_cmd_wmask ,
	output			mas_icb_rsp_ready ,
	input			mas_icb_rsp_valid ,
	input [31:0]	mas_icb_rsp_rdata ,
	input			mas_icb_rsp_err   ,
	// accelator port
	output			valid_to_acce ,
	output [31:0]	data_to_acce  ,
	output 			bus_free_to_acce ,
	
	input 			weight_ing_from_acce ,
	input  [31:0] 	data_from_acce ,
	input 			valid_from_acce ,
	input			conv_done,

	output reg      conv_irq
	
);

	//reg conv_irq;
	localparam [31:0] SRAM1_BASE = 32'h2000_0000;
	localparam [31:0] SRAM2_BASE = 32'h3000_0000;
	localparam [31:0] WRITE_BASE = 32'h2000_0000;
	localparam [15:0] MAX_READ_ADDR = 16'hC657;
	localparam [15:0] MAX_WRITE_ADDR = 16'hC400;    //16'hC3FF+1
	
	reg  [15:0] read_addr_offset ;
	wire [31:0] read_addr_base ;
	wire [31:0] read_addr ;
	reg  [15:0] write_addr_offset ;
	wire [31:0] write_addr_base ;
	wire [31:0] write_addr ;
	
	reg read_sram_select ;
	
	wire mas_icb_cmd_shakehand ;
	
	assign valid_to_acce = mas_icb_rsp_valid && running ;
	assign data_to_acce = mas_icb_rsp_rdata ;
	assign bus_free_to_acce = mas_icb_cmd_shakehand ;
	
	assign mas_icb_cmd_wdata = data_from_acce ;
	assign mas_icb_cmd_wmask = 4'b1111 ;
	
	
	
	assign mas_icb_cmd_shakehand = mas_icb_cmd_valid && mas_icb_cmd_ready ;
	
	assign mas_icb_cmd_read = (conv_done == 1'b1)? 1'b0 : 1'b1 ;
	assign mas_icb_cmd_valid = running ;
	
	assign mas_icb_rsp_ready = 1'b1 ;
	
	// read
	
	assign read_addr_base = (read_sram_select==1'b0)? SRAM1_BASE : SRAM2_BASE ;
	assign read_addr = read_addr_base + read_addr_offset ;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				read_addr_offset <= 16'h0000 ;
				read_sram_select <= 1'b0 ;
			end
		else
			begin
				if(running && mas_icb_cmd_read)
					begin
						if(mas_icb_cmd_shakehand)
							begin
								if(read_addr_offset == MAX_READ_ADDR)
									begin
										read_addr_offset <= 16'h0 ;
										read_sram_select <= ~read_sram_select ;
									end
								else
									begin
									        //$display("***********************successful!!!***************************");
                                                                          	read_addr_offset <= read_addr_offset + 1 ;
										read_sram_select <= read_sram_select ;
									end
							end
						else
							begin
								read_addr_offset <= read_addr_offset ;
								read_sram_select <= read_sram_select ;
							end
					end
				else
					begin
						read_addr_offset <= read_addr_offset ;
						read_sram_select <= read_sram_select ;
					end
					
			end
	end
	
	
	
	
	// write
	assign write_addr_base = WRITE_BASE ;
	assign write_addr = write_addr_base + write_addr_offset ;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
		  begin
			write_addr_offset <= 16'h0000 ;
			conv_irq <= 1'b0;
		  end
		else
			begin
				if(mas_icb_cmd_read == 1'b0)
					begin
						if(mas_icb_cmd_shakehand)
							begin
								if(write_addr_offset == MAX_WRITE_ADDR)
								  begin
									write_addr_offset <= 16'h0 ;
									conv_irq <= 1'b1;
                                                                        //$display("************conv_irq****************");
								  end
								else
                                                                  begin
									write_addr_offset <= write_addr_offset + 1 ;
                                                                        conv_irq <= 1'b0;
                                                                  end
							end
						else
							write_addr_offset <= write_addr_offset ;
					end
				else
					write_addr_offset <= write_addr_offset ;
			end
	end
	
	assign mas_icb_cmd_addr = (conv_done == 1'b1)? write_addr : read_addr;
	
endmodule

