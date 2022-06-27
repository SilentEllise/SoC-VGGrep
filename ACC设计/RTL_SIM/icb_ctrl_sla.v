module icb_ctrl_sla(
	input 			clk ,
	input			rst_n ,
	// icb port
	input			sla_icb_cmd_valid ,
	output			sla_icb_cmd_ready ,
	input [31:0]	sla_icb_cmd_addr  ,
	input			sla_icb_cmd_read  ,
	input [31:0]	sla_icb_cmd_wdata ,
	input [3:0]		sla_icb_cmd_wmask ,
	input			sla_icb_rsp_ready ,
	output reg		sla_icb_rsp_valid ,
	output [31:0]	sla_icb_rsp_rdata ,
	output			sla_icb_rsp_err   ,
	// accelator port
	output reg		running

);
    localparam [31:0] START_ADDR = 32'h1004_1008;
	wire sla_icb_cmd_handshake ;
	wire sla_icb_rsp_handshake ;
	
	assign sla_icb_cmd_ready = sla_icb_cmd_valid ;
	assign sla_icb_cmd_handshake = (sla_icb_cmd_ready&&sla_icb_cmd_valid)? 1'b1 : 1'b0 ;
	assign sla_icb_rsp_handshake = (sla_icb_rsp_ready&&sla_icb_rsp_valid)? 1'b1 : 1'b0 ;
	
	assign sla_icb_rsp_err = 1'b0 ;
	assign sla_icb_rsp_rdata = 32'h0 ;

	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			running <= 1'b0 ;
		else
			begin
				if(sla_icb_cmd_handshake && (sla_icb_cmd_wdata == 32'h00000001) && (sla_icb_cmd_addr==START_ADDR))
					begin
                                        $display("***********************acc start*****************************");
                                        running <= 1'b1 ;
                                        end
				else
					running <= running ;
			end
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			sla_icb_rsp_valid <= 1'b0 ;
		else
			begin
				if(sla_icb_cmd_handshake)
					sla_icb_rsp_valid <= 1'b1 ;
				else
					begin
						if(sla_icb_rsp_handshake)
							sla_icb_rsp_valid <= 1'b0 ;
						else
							sla_icb_rsp_valid <= sla_icb_rsp_valid ;
					end
			end
	end


endmodule














