/**
----------------------------------------------------------------
Date         : 2021.6.29
Author       : Guo Mengyuan
----------------------------------------------------------------
Description  : 

Update Log   : 
----------------------------------------------------------------
Module Name  : top_icb
Sub Module	 : 1 top , 2 icb_controller
----------------------------------------------------------------
**/

module top(
	input 			clk ,
	input			rst_n ,
	// MASTER PORT
	output			m_icb_cmd_valid ,
	input			m_icb_cmd_ready ,
	output [31:0]	m_icb_cmd_addr  ,
	output			m_icb_cmd_read  ,
	output [31:0]	m_icb_cmd_wdata ,
	output [3:0]	m_icb_cmd_wmask ,
	output			m_icb_rsp_ready ,
	input			m_icb_rsp_valid ,
	input [31:0]	m_icb_rsp_rdata ,
	input			m_icb_rsp_err   ,
	// SLAVE PORT
	input			i_icb_cmd_valid ,
	output			i_icb_cmd_ready ,
	input [31:0]	i_icb_cmd_addr  ,
	input			i_icb_cmd_read  ,
	input [31:0]	i_icb_cmd_wdata ,
	input [3:0]		i_icb_cmd_wmask ,
	input			i_icb_rsp_ready ,
	output			i_icb_rsp_valid ,
	output [31:0]	i_icb_rsp_rdata ,
	output			i_icb_rsp_err   ,
	
	output			conv_irq
);

	wire running ;
	wire valid_to_acce;
	wire [31:0] data_to_acce;
	wire bus_free_to_acce;
	wire weight_ing_from_acce;
	wire [31:0] data_from_acce;
	wire valid_from_acce;
	wire conv_done ;

	top_acce top_acce_0(
		.clk 		(clk),
		.rst_n 		(rst_n),
		.data_i 	(data_to_acce),
		.valid_i 	(valid_to_acce),
		.bus_free 	(bus_free_to_acce),
		.weight_ing (weight_ing_from_acce),
		.data_o 	(data_from_acce),
		.valid_o	(valid_from_acce),
		.conv_done	(conv_done)
	);

	icb_ctrl_sla icb_ctrl_sla_0(
		.clk 				(clk),
		.rst_n 				(rst_n),
		.sla_icb_cmd_valid 	(i_icb_cmd_valid),
		.sla_icb_cmd_ready 	(i_icb_cmd_ready),
		.sla_icb_cmd_addr  	(i_icb_cmd_addr),
		.sla_icb_cmd_read  	(i_icb_cmd_read),
		.sla_icb_cmd_wdata 	(i_icb_cmd_wdata),
		.sla_icb_cmd_wmask 	(i_icb_cmd_wmask),
		.sla_icb_rsp_ready 	(i_icb_rsp_ready),
		.sla_icb_rsp_valid 	(i_icb_rsp_valid),
		.sla_icb_rsp_rdata 	(i_icb_rsp_rdata),
		.sla_icb_rsp_err   	(i_icb_rsp_err),
		.running			(running)
	);

    icb_ctrl_mas icb_ctrl_mas_0(
	    .clk               (clk),
	    .rst_n             (rst_n),
	    .running           (running),
	    // icb port
	    .mas_icb_cmd_valid (m_icb_cmd_valid),
	    .mas_icb_cmd_ready (m_icb_cmd_ready),
	    .mas_icb_cmd_addr  (m_icb_cmd_addr),
	    .mas_icb_cmd_read  (m_icb_cmd_read),
	    .mas_icb_cmd_wdata (m_icb_cmd_wdata),
	    .mas_icb_cmd_wmask (m_icb_cmd_wmask),
	    .mas_icb_rsp_ready (m_icb_rsp_ready),
	    .mas_icb_rsp_valid (m_icb_rsp_valid),
	    .mas_icb_rsp_rdata (m_icb_rsp_rdata),
	    .mas_icb_rsp_err   (m_icb_rsp_err),
	    // accelator port
	    .valid_to_acce     (valid_to_acce),
	    .data_to_acce      (data_to_acce),
	    .bus_free_to_acce  (bus_free_to_acce),
	
	    .weight_ing_from_acce(weight_ing_from_acce) ,
	    .data_from_acce    (data_from_acce),
	    .valid_from_acce   (valid_from_acce),
	    .conv_done         (conv_done),
		.conv_irq          (conv_irq)
	
);


endmodule




