 /*                                                                      
 Copyright 2018 Nuclei System Technology, Inc.                
                                                                         
 Licensed under the Apache License, Version 2.0 (the "License");         
 you may not use this file except in compliance with the License.        
 You may obtain a copy of the License at                                 
                                                                         
     http://www.apache.org/licenses/LICENSE-2.0                          
                                                                         
  Unless required by applicable law or agreed to in writing, software    
 distributed under the License is distributed on an "AS IS" BASIS,       
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and     
 limitations under the License.                                          
 */                                                                      
                                                                         
                                                                         
                                                                         
//=====================================================================
//
// Designer   : Bob Hu
//
// Description:
//  The peirpheral bus and the connected devices 
//
// ====================================================================

`include "e203_defines.v"


module e203_subsys_perips(
  input                          ppi_icb_cmd_valid,
  output                         ppi_icb_cmd_ready,
  input  [`E203_ADDR_SIZE-1:0]   ppi_icb_cmd_addr, 
  input                          ppi_icb_cmd_read, 
  input  [`E203_XLEN-1:0]        ppi_icb_cmd_wdata,
  input  [`E203_XLEN/8-1:0]      ppi_icb_cmd_wmask,
  //
  output                         ppi_icb_rsp_valid,
  input                          ppi_icb_rsp_ready,
  output                         ppi_icb_rsp_err,
  output [`E203_XLEN-1:0]        ppi_icb_rsp_rdata,
 /* 
  output                         dma_icb_cmd_valid,
  input                          dma_icb_cmd_ready,
  output  [`E203_ADDR_SIZE-1:0]  dma_icb_cmd_addr, 
  output                         dma_icb_cmd_read, 
  output  [`E203_XLEN-1:0]       dma_icb_cmd_wdata,
  output  [`E203_XLEN/8-1:0]       dma_icb_cmd_wmask,
  //
  input                          dma_icb_rsp_valid,
  output                         dma_icb_rsp_ready,
  input                          dma_icb_rsp_err,
  input [`E203_XLEN-1:0]         dma_icb_rsp_rdata,
*/
  output                         dma_irq,
  output                         i2c_irq,
  output                         conv_irq,  //acc


  input   			 uart_pins_0_io_pins_rxd_i_ival,
  output  			 uart_pins_0_io_pins_rxd_o_oval,
  output  			 uart_pins_0_io_pins_rxd_o_oe,
  output  			 uart_pins_0_io_pins_rxd_o_ie,

  input   			 uart_pins_1_io_pins_rxd_i_ival,
  output  			 uart_pins_1_io_pins_rxd_o_oval,
  output  			 uart_pins_1_io_pins_rxd_o_oe,
  output  			 uart_pins_1_io_pins_rxd_o_ie,

  input   			 uart_pins_0_io_pins_txd_i_ival,
  output  			 uart_pins_0_io_pins_txd_o_oval,
  output  			 uart_pins_0_io_pins_txd_o_oe,
  output  			 uart_pins_0_io_pins_txd_o_ie,

  input   			 uart_pins_1_io_pins_txd_i_ival,
  output  			 uart_pins_1_io_pins_txd_o_oval,
  output  			 uart_pins_1_io_pins_txd_o_oe,
  output  			 uart_pins_1_io_pins_txd_o_ie,
  
  output                         m_icb_cmd_valid ,
  input                          m_icb_cmd_ready ,
  output [31:0]                  m_icb_cmd_addr  ,
  output                         m_icb_cmd_read  ,
  output [31:0]                  m_icb_cmd_wdata ,
  output [3:0]                   m_icb_cmd_wmask ,
  output                         m_icb_rsp_ready ,
  input                          m_icb_rsp_valid ,
  input [31:0]                   m_icb_rsp_rdata ,
  input                          m_icb_rsp_err   ,


  input  clk,
  input  bus_rst_n,
  input  rst_n
  );

  



  wire  uart0_txd;
  wire  uart0_rxd;
  wire  uart_pins_0_io_pins_rxd_o_pue;
  wire  uart_pins_0_io_pins_rxd_o_ds;
  wire  uart_pins_0_io_pins_txd_o_pue;
  wire  uart_pins_0_io_pins_txd_o_ds;
  wire  uart1_txd;
  wire  uart1_rxd;
  wire  uart_pins_1_io_pins_rxd_o_pue;
  wire  uart_pins_1_io_pins_rxd_o_ds;
  wire  uart_pins_1_io_pins_txd_o_pue;
  wire  uart_pins_1_io_pins_txd_o_ds;



  wire                     uart0_icb_cmd_valid;
  wire                     uart0_icb_cmd_ready;
  wire [32-1:0]            uart0_icb_cmd_addr; 
  wire                     uart0_icb_cmd_read; 
  wire [32-1:0]            uart0_icb_cmd_wdata;
  
  wire                     uart0_icb_rsp_valid;
  wire                     uart0_icb_rsp_ready;
  wire [32-1:0]            uart0_icb_rsp_rdata;


  wire                     uart1_icb_cmd_valid;
  wire                     uart1_icb_cmd_ready;
  wire [32-1:0]            uart1_icb_cmd_addr; 
  wire                     uart1_icb_cmd_read; 
  wire [32-1:0]            uart1_icb_cmd_wdata;
  
  wire                     uart1_icb_rsp_valid;
  wire                     uart1_icb_rsp_ready;
  wire [32-1:0]            uart1_icb_rsp_rdata;

  wire                     dma_cfg_icb_cmd_valid;
  wire                     dma_cfg_icb_cmd_ready;
  wire [32-1:0]            dma_cfg_icb_cmd_addr; 
  wire                     dma_cfg_icb_cmd_read; 
  wire [32-1:0]            dma_cfg_icb_cmd_wdata;
  wire [4-1:0]             dma_cfg_icb_cmd_wmask;
  
  wire                     dma_cfg_icb_rsp_valid;
  wire                     dma_cfg_icb_rsp_ready;
  wire                     dma_cfg_icb_rsp_err;
  wire [32-1:0]            dma_cfg_icb_rsp_rdata;

  wire                     i2c_wishb_icb_cmd_valid;
  wire                     i2c_wishb_icb_cmd_ready;
  wire [32-1:0]            i2c_wishb_icb_cmd_addr; 
  wire                     i2c_wishb_icb_cmd_read; 
  wire [32-1:0]            i2c_wishb_icb_cmd_wdata;
  wire [4 -1:0]            i2c_wishb_icb_cmd_wmask;
  
  wire                     i2c_wishb_icb_rsp_valid;
  wire                     i2c_wishb_icb_rsp_ready;
  wire [32-1:0]            i2c_wishb_icb_rsp_rdata;
  wire                     i2c_wishb_icb_rsp_err;
/*
  wire m_icb_cmd_valid;
  wire m_icb_cmd_ready;
  wire m_icb_cmd_read;
  wire [31:0] m_icb_cmd_addr;
  wire [31:0] m_icb_cmd_wdata;
  wire [3:0] m_icb_cmd_wmask;

  wire m_icb_rsp_valid;
  wire m_icb_rsp_ready;
  wire m_icb_rsp_err;
  wire [31:0] m_icb_rsp_rdata;  
*/
  wire i_icb_cmd_valid;
  wire i_icb_cmd_ready;
  wire i_icb_cmd_read;
  wire [31:0] i_icb_cmd_addr;
  wire [31:0] i_icb_cmd_wdata;
  wire [3:0] i_icb_cmd_wmask;

  wire i_icb_rsp_valid;
  wire i_icb_rsp_ready;
  wire i_icb_rsp_err;
  wire [31:0] i_icb_rsp_rdata;
  // The total address range for the PPI is from/to
  //  **************0x1000 0000 -- 0x1FFF FFFF
  // There are several slaves for PPI bus, including:
  //  * DMA       : 0x1000 0000 -- 0x1000 7FFF
  //  * Example-WishBone : 0x1004 2000 -- 0x1004 2FFF 
  //  * UART0     : 0x1001 3000 -- 0x1001 3FFF  
  //  * UART1     : 0x1002 3000 -- 0x1002 3FFF  

  sirv_icb1to8_bus # (
  .ICB_FIFO_DP        (2),// We add a ping-pong buffer here to cut down the timing path
  .ICB_FIFO_CUT_READY (1),// We configure it to cut down the back-pressure ready signal

  .AW                   (32),
  .DW                   (`E203_XLEN),
  .SPLT_FIFO_OUTS_NUM   (1),// The peirpherals only allow 1 oustanding
  .SPLT_FIFO_CUT_READY  (1),// The peirpherals always cut ready
  //  * DMA       : 0x1000 0000 -- 0x1000 7FFF
  .O0_BASE_ADDR       (32'h1000_0000),       
  .O0_BASE_REGION_LSB (15),
   // * Here is an I2C WishBone Peripheral
  .O1_BASE_ADDR       (32'h1004_2000),       
  .O1_BASE_REGION_LSB (3),// I2C only have 3 bits address width
  //  * UART0     : 0x1001 3000 -- 0x1001 3FFF
  .O2_BASE_ADDR       (32'h1001_3000),       
  .O2_BASE_REGION_LSB (12),
  //  * UART1     : 0x1002 3000 -- 0x1002 3FFF
  .O3_BASE_ADDR       (32'h1002_3000),       
  .O3_BASE_REGION_LSB (12),
  //  acc
  .O4_BASE_ADDR       (32'h1004_1000),       
  .O4_BASE_REGION_LSB (12),
  //  *not used
  .O5_BASE_ADDR       (32'h0000_0000),       
  .O5_BASE_REGION_LSB (12),
  //  *not used
  .O6_BASE_ADDR       (32'h0000_0000),       
  .O6_BASE_REGION_LSB (0),
  //  *not used
  .O7_BASE_ADDR       (32'h0000_0000),       
  .O7_BASE_REGION_LSB (0)

  )u_sirv_ppi_fab(

    .i_icb_cmd_valid  (ppi_icb_cmd_valid),
    .i_icb_cmd_ready  (ppi_icb_cmd_ready),
    .i_icb_cmd_addr   (ppi_icb_cmd_addr ),
    .i_icb_cmd_read   (ppi_icb_cmd_read ),
    .i_icb_cmd_wdata  (ppi_icb_cmd_wdata),
    .i_icb_cmd_wmask  (ppi_icb_cmd_wmask),
    .i_icb_cmd_lock   (1'b0),
    .i_icb_cmd_excl   (1'b0 ),
    .i_icb_cmd_size   (2'b0 ),
    .i_icb_cmd_burst  (2'b0 ),
    .i_icb_cmd_beat   (2'b0 ),
    
    .i_icb_rsp_valid  (ppi_icb_rsp_valid),
    .i_icb_rsp_ready  (ppi_icb_rsp_ready),
    .i_icb_rsp_err    (ppi_icb_rsp_err  ),
    .i_icb_rsp_excl_ok(),
    .i_icb_rsp_rdata  (ppi_icb_rsp_rdata),
    
  //  * DMA 
    .o0_icb_enable     (1'b1),

        //
    .o0_icb_cmd_valid  (dma_cfg_icb_cmd_valid),
    .o0_icb_cmd_ready  (dma_cfg_icb_cmd_ready),
    .o0_icb_cmd_addr   (dma_cfg_icb_cmd_addr),
    .o0_icb_cmd_read   (dma_cfg_icb_cmd_read),
    .o0_icb_cmd_wdata  (dma_cfg_icb_cmd_wdata),
    .o0_icb_cmd_wmask  (dma_cfg_icb_cmd_wmask),
    .o0_icb_cmd_lock   (),
    .o0_icb_cmd_excl   (),
    .o0_icb_cmd_size   (),
    .o0_icb_cmd_burst  (),
    .o0_icb_cmd_beat   (),
    
    .o0_icb_rsp_valid  (dma_cfg_icb_rsp_valid),
    .o0_icb_rsp_ready  (dma_cfg_icb_rsp_ready),
    .o0_icb_rsp_err    (dma_cfg_icb_rsp_err),
    .o0_icb_rsp_excl_ok(1'b0  ),
    .o0_icb_rsp_rdata  (dma_cfg_icb_rsp_rdata),


   //  * I2C WishBone    
    .o1_icb_enable     (1'b1),

    .o1_icb_cmd_valid  (i2c_wishb_icb_cmd_valid),
    .o1_icb_cmd_ready  (i2c_wishb_icb_cmd_ready),
    .o1_icb_cmd_addr   (i2c_wishb_icb_cmd_addr ),
    .o1_icb_cmd_read   (i2c_wishb_icb_cmd_read ),
    .o1_icb_cmd_wdata  (i2c_wishb_icb_cmd_wdata),
    .o1_icb_cmd_wmask  (i2c_wishb_icb_cmd_wmask),
    .o1_icb_cmd_lock   (),
    .o1_icb_cmd_excl   (),
    .o1_icb_cmd_size   (),
    .o1_icb_cmd_burst  (),
    .o1_icb_cmd_beat   (),
    
    .o1_icb_rsp_valid  (i2c_wishb_icb_rsp_valid),
    .o1_icb_rsp_ready  (i2c_wishb_icb_rsp_ready),
    .o1_icb_rsp_err    (i2c_wishb_icb_rsp_err),
    .o1_icb_rsp_excl_ok(1'b0  ),
    .o1_icb_rsp_rdata  (i2c_wishb_icb_rsp_rdata),


  //  * UART0     
    .o2_icb_enable     (1'b1),

    .o2_icb_cmd_valid  (uart0_icb_cmd_valid),
    .o2_icb_cmd_ready  (uart0_icb_cmd_ready),
    .o2_icb_cmd_addr   (uart0_icb_cmd_addr ),
    .o2_icb_cmd_read   (uart0_icb_cmd_read ),
    .o2_icb_cmd_wdata  (uart0_icb_cmd_wdata),
    .o2_icb_cmd_wmask  (),
    .o2_icb_cmd_lock   (),
    .o2_icb_cmd_excl   (),
    .o2_icb_cmd_size   (),
    .o2_icb_cmd_burst  (),
    .o2_icb_cmd_beat   (),
    
    .o2_icb_rsp_valid  (uart0_icb_rsp_valid),
    .o2_icb_rsp_ready  (uart0_icb_rsp_ready),
    .o2_icb_rsp_err    (1'b0  ),
    .o2_icb_rsp_excl_ok(1'b0  ),
    .o2_icb_rsp_rdata  (uart0_icb_rsp_rdata),



  //  * UART1     
    .o3_icb_enable     (1'b1),

    .o3_icb_cmd_valid  (uart1_icb_cmd_valid),
    .o3_icb_cmd_ready  (uart1_icb_cmd_ready),
    .o3_icb_cmd_addr   (uart1_icb_cmd_addr ),
    .o3_icb_cmd_read   (uart1_icb_cmd_read ),
    .o3_icb_cmd_wdata  (uart1_icb_cmd_wdata),
    .o3_icb_cmd_wmask  (),
    .o3_icb_cmd_lock   (),
    .o3_icb_cmd_excl   (),
    .o3_icb_cmd_size   (),
    .o3_icb_cmd_burst  (),
    .o3_icb_cmd_beat   (),
    
    .o3_icb_rsp_valid  (uart1_icb_rsp_valid),
    .o3_icb_rsp_ready  (uart1_icb_rsp_ready),
    .o3_icb_rsp_err    (1'b0  ),
    .o3_icb_rsp_excl_ok(1'b0  ),
    .o3_icb_rsp_rdata  (uart1_icb_rsp_rdata),

  //  acc     
    .o4_icb_enable     (1'b1),

    .o4_icb_cmd_valid  (i_icb_cmd_valid),
    .o4_icb_cmd_ready  (i_icb_cmd_ready),
    .o4_icb_cmd_addr   (i_icb_cmd_addr),
    .o4_icb_cmd_read   (i_icb_cmd_read),
    .o4_icb_cmd_wdata  (i_icb_cmd_wdata),
    .o4_icb_cmd_wmask  (i_icb_cmd_wmask),
    .o4_icb_cmd_lock   (),
    .o4_icb_cmd_excl   (),
    .o4_icb_cmd_size   (),
    .o4_icb_cmd_burst  (),
    .o4_icb_cmd_beat   (),
    
    .o4_icb_rsp_valid  (i_icb_rsp_valid),
    .o4_icb_rsp_ready  (i_icb_rsp_ready),
    .o4_icb_rsp_err    (i_icb_rsp_err),
    .o4_icb_rsp_excl_ok(1'b0  ),
    .o4_icb_rsp_rdata  (i_icb_rsp_rdata),
  //  * not used      
    .o5_icb_enable     (1'b0),

    .o5_icb_cmd_valid  (),
    .o5_icb_cmd_ready  (1'b0),
    .o5_icb_cmd_addr   (),
    .o5_icb_cmd_read   (),
    .o5_icb_cmd_wdata  (),
    .o5_icb_cmd_wmask  (),
    .o5_icb_cmd_lock   (),
    .o5_icb_cmd_excl   (),
    .o5_icb_cmd_size   (),
    .o5_icb_cmd_burst  (),
    .o5_icb_cmd_beat   (),
    
    .o5_icb_rsp_valid  (1'b0),
    .o5_icb_rsp_ready  (),
    .o5_icb_rsp_err    (1'b0  ),
    .o5_icb_rsp_excl_ok(1'b0  ),
    .o5_icb_rsp_rdata  (`E203_XLEN'b0),

  //  * not used      
    .o6_icb_enable     (1'b0),

    .o6_icb_cmd_valid  (),
    .o6_icb_cmd_ready  (1'b0),
    .o6_icb_cmd_addr   (),
    .o6_icb_cmd_read   (),
    .o6_icb_cmd_wdata  (),
    .o6_icb_cmd_wmask  (),
    .o6_icb_cmd_lock   (),
    .o6_icb_cmd_excl   (),
    .o6_icb_cmd_size   (),
    .o6_icb_cmd_burst  (),
    .o6_icb_cmd_beat   (),
    
    .o6_icb_rsp_valid  (1'b0),
    .o6_icb_rsp_ready  (),
    .o6_icb_rsp_err    (1'b0  ),
    .o6_icb_rsp_excl_ok(1'b0  ),
    .o6_icb_rsp_rdata  (`E203_XLEN'b0),

  //  * not used      
    .o7_icb_enable     (1'b0),

    .o7_icb_cmd_valid  (),
    .o7_icb_cmd_ready  (1'b0),
    .o7_icb_cmd_addr   (),
    .o7_icb_cmd_read   (),
    .o7_icb_cmd_wdata  (),
    .o7_icb_cmd_wmask  (),
    .o7_icb_cmd_lock   (),
    .o7_icb_cmd_excl   (),
    .o7_icb_cmd_size   (),
    .o7_icb_cmd_burst  (),
    .o7_icb_cmd_beat   (),
    
    .o7_icb_rsp_valid  (1'b0),
    .o7_icb_rsp_ready  (),
    .o7_icb_rsp_err    (1'b0  ),
    .o7_icb_rsp_excl_ok(1'b0  ),
    .o7_icb_rsp_rdata  (`E203_XLEN'b0),

    .clk           (clk  ),
    .rst_n         (bus_rst_n) 
  );

/*
e203_dma i_dma(
    .clk(clk),
    .rst_n(rst_n),
    .dma_icb_cmd_valid (dma_icb_cmd_valid),
    .dma_icb_cmd_ready (dma_icb_cmd_ready),
    .dma_icb_cmd_addr  (dma_icb_cmd_addr ),
    .dma_icb_cmd_read  (dma_icb_cmd_read ),
    .dma_icb_cmd_wdata (dma_icb_cmd_wdata),
    .dma_icb_cmd_wmask (dma_icb_cmd_wmask),
    
    .dma_icb_rsp_valid (dma_icb_rsp_valid),
    .dma_icb_rsp_ready (dma_icb_rsp_ready),
    .dma_icb_rsp_err   (dma_icb_rsp_err),
    .dma_icb_rsp_rdata (dma_icb_rsp_rdata),
    .dma_irq           (dma_irq),


    .dma_cfg_icb_cmd_valid (dma_cfg_icb_cmd_valid),
    .dma_cfg_icb_cmd_ready (dma_cfg_icb_cmd_ready),
    .dma_cfg_icb_cmd_addr  (dma_cfg_icb_cmd_addr ),
    .dma_cfg_icb_cmd_read  (dma_cfg_icb_cmd_read ),
    .dma_cfg_icb_cmd_wdata (dma_cfg_icb_cmd_wdata),
    .dma_cfg_icb_cmd_wmask (dma_cfg_icb_cmd_wmask),
    
    .dma_cfg_icb_rsp_valid (dma_cfg_icb_rsp_valid),
    .dma_cfg_icb_rsp_ready (dma_cfg_icb_rsp_ready),
    .dma_cfg_icb_rsp_err   (dma_cfg_icb_rsp_err  ),
    .dma_cfg_icb_rsp_rdata (dma_cfg_icb_rsp_rdata)

);
*/
e203_dma i_dma(
    .clk(clk),
    .rst_n(rst_n),
    .dma_icb_cmd_valid (),
    .dma_icb_cmd_ready (),
    .dma_icb_cmd_addr  (),
    .dma_icb_cmd_read  (),
    .dma_icb_cmd_wdata (),
    .dma_icb_cmd_wmask (),
    
    .dma_icb_rsp_valid (),
    .dma_icb_rsp_ready (),
    .dma_icb_rsp_err   (),
    .dma_icb_rsp_rdata (),
    .dma_irq           (dma_irq),


    .dma_cfg_icb_cmd_valid (dma_cfg_icb_cmd_valid),
    .dma_cfg_icb_cmd_ready (dma_cfg_icb_cmd_ready),
    .dma_cfg_icb_cmd_addr  (dma_cfg_icb_cmd_addr ),
    .dma_cfg_icb_cmd_read  (dma_cfg_icb_cmd_read ),
    .dma_cfg_icb_cmd_wdata (dma_cfg_icb_cmd_wdata),
    .dma_cfg_icb_cmd_wmask (dma_cfg_icb_cmd_wmask),
    
    .dma_cfg_icb_rsp_valid (dma_cfg_icb_rsp_valid),
    .dma_cfg_icb_rsp_ready (dma_cfg_icb_rsp_ready),
    .dma_cfg_icb_rsp_err   (dma_cfg_icb_rsp_err  ),
    .dma_cfg_icb_rsp_rdata (dma_cfg_icb_rsp_rdata)

);
/////////////////////   UART part    /////////////////////
  //  * UART0     
sirv_uart_top u_sirv_uart0_top (
    .clk           (clk  ),
    .rst_n         (rst_n),

    .i_icb_cmd_valid (uart0_icb_cmd_valid),
    .i_icb_cmd_ready (uart0_icb_cmd_ready),
    .i_icb_cmd_addr  (uart0_icb_cmd_addr ),
    .i_icb_cmd_read  (uart0_icb_cmd_read ),
    .i_icb_cmd_wdata (uart0_icb_cmd_wdata),
    
    .i_icb_rsp_valid (uart0_icb_rsp_valid),
    .i_icb_rsp_ready (uart0_icb_rsp_ready),
    .i_icb_rsp_rdata (uart0_icb_rsp_rdata),

    .io_interrupts_0_0 (),                
    .io_port_txd       (uart0_txd),
    .io_port_rxd       (uart0_rxd)
);



  //  * UART1     
sirv_uart_top u_sirv_uart1_top (
    .clk           (clk  ),
    .rst_n         (rst_n),

    .i_icb_cmd_valid (uart1_icb_cmd_valid),
    .i_icb_cmd_ready (uart1_icb_cmd_ready),
    .i_icb_cmd_addr  (uart1_icb_cmd_addr ),
    .i_icb_cmd_read  (uart1_icb_cmd_read ),
    .i_icb_cmd_wdata (uart1_icb_cmd_wdata),
    
    .i_icb_rsp_valid (uart1_icb_rsp_valid),
    .i_icb_rsp_ready (uart1_icb_rsp_ready),
    .i_icb_rsp_rdata (uart1_icb_rsp_rdata),

    .io_interrupts_0_0 (),                
    .io_port_txd       (uart1_txd),
    .io_port_rxd       (uart1_rxd)
);




  sirv_uartgpioport u_uart0_pins (
    .clock(clk),
    .reset(~rst_n),
    .io_uart_txd(uart0_txd),
    .io_uart_rxd(uart0_rxd),
    .io_pins_rxd_i_ival(uart_pins_0_io_pins_rxd_i_ival),
    .io_pins_rxd_o_oval(uart_pins_0_io_pins_rxd_o_oval),
    .io_pins_rxd_o_oe(uart_pins_0_io_pins_rxd_o_oe),
    .io_pins_rxd_o_ie(uart_pins_0_io_pins_rxd_o_ie),
    .io_pins_rxd_o_pue(uart_pins_0_io_pins_rxd_o_pue),
    .io_pins_rxd_o_ds(uart_pins_0_io_pins_rxd_o_ds),
    .io_pins_txd_i_ival(uart_pins_0_io_pins_txd_i_ival),
    .io_pins_txd_o_oval(uart_pins_0_io_pins_txd_o_oval),
    .io_pins_txd_o_oe(uart_pins_0_io_pins_txd_o_oe),
    .io_pins_txd_o_ie(uart_pins_0_io_pins_txd_o_ie),
    .io_pins_txd_o_pue(uart_pins_0_io_pins_txd_o_pue),
    .io_pins_txd_o_ds(uart_pins_0_io_pins_txd_o_ds)
  );

  sirv_uartgpioport u_uart1_pins (
    .clock(clk),
    .reset(~rst_n),
    .io_uart_txd(uart1_txd),
    .io_uart_rxd(uart1_rxd),
    .io_pins_rxd_i_ival(uart_pins_1_io_pins_rxd_i_ival),
    .io_pins_rxd_o_oval(uart_pins_1_io_pins_rxd_o_oval),
    .io_pins_rxd_o_oe(uart_pins_1_io_pins_rxd_o_oe),
    .io_pins_rxd_o_ie(uart_pins_1_io_pins_rxd_o_ie),
    .io_pins_rxd_o_pue(uart_pins_1_io_pins_rxd_o_pue),
    .io_pins_rxd_o_ds(uart_pins_1_io_pins_rxd_o_ds),
    .io_pins_txd_i_ival(uart_pins_1_io_pins_txd_i_ival),
    .io_pins_txd_o_oval(uart_pins_1_io_pins_txd_o_oval),
    .io_pins_txd_o_oe(uart_pins_1_io_pins_txd_o_oe),
    .io_pins_txd_o_ie(uart_pins_1_io_pins_txd_o_ie),
    .io_pins_txd_o_pue(uart_pins_1_io_pins_txd_o_pue),
    .io_pins_txd_o_ds(uart_pins_1_io_pins_txd_o_ds)
  );


//////////////  iic part//////////////////////////
      // * Here is an example WishBone Peripheral
  wire  [`E203_ADDR_SIZE-1:0] i2c_wishb_adr;     // lower address bits
  wire  [8-1:0] i2c_wishb_dat_w;   // databus input
  wire  [8-1:0] i2c_wishb_dat_r;   // databus output
  wire           i2c_wishb_we;      // write enable input
  wire           i2c_wishb_stb;     // stobe/core select signal
  wire           i2c_wishb_cyc;     // valid bus cycle input
  wire           i2c_wishb_ack;     // bus cycle acknowledge output

sirv_gnrl_icb32towishb8 # (
  .AW   (`E203_ADDR_SIZE) 
) u_i2c_wishb_icb32towishb8(
    .i_icb_cmd_valid (i2c_wishb_icb_cmd_valid),
    .i_icb_cmd_ready (i2c_wishb_icb_cmd_ready),
    .i_icb_cmd_addr  (i2c_wishb_icb_cmd_addr ),
    .i_icb_cmd_read  (i2c_wishb_icb_cmd_read ),
    .i_icb_cmd_wdata (i2c_wishb_icb_cmd_wdata),
    .i_icb_cmd_wmask (i2c_wishb_icb_cmd_wmask),
    .i_icb_cmd_size  (2'b0),
    
    .i_icb_rsp_valid (i2c_wishb_icb_rsp_valid),
    .i_icb_rsp_ready (i2c_wishb_icb_rsp_ready),
    .i_icb_rsp_rdata (i2c_wishb_icb_rsp_rdata),
    .i_icb_rsp_err   (i2c_wishb_icb_rsp_err),

    .wb_adr   (i2c_wishb_adr),
    .wb_dat_w (i2c_wishb_dat_w[7:0]),
    .wb_dat_r (i2c_wishb_dat_r[7:0]),
    .wb_we    (i2c_wishb_we   ),
    .wb_stb   (i2c_wishb_stb  ),
    .wb_cyc   (i2c_wishb_cyc  ),
    .wb_ack   (i2c_wishb_ack  ),

    .clk           (clk  ),
    .rst_n         (bus_rst_n) 
  );

  wire			 i2c_scl_pad_i   ; 
  wire 			 i2c_scl_pad_o   ;
  wire 			 i2c_scl_padoen_o;
  wire			 i2c_sda_pad_i   ;
  wire 			 i2c_sda_pad_o   ;
  wire 			 i2c_sda_padoen_o;

 assign i2c_scl_pad_i = i2c_scl_padoen_o? 1'bz:i2c_scl_pad_o;
 pullup p1(i2c_scl_pad_i);
 assign i2c_sda_pad_i = i2c_sda_padoen_o? 1'bz:i2c_sda_pad_o;
 pullup p2(i2c_sda_pad_i);

  i2c_master_top u_i2c_master_top (
	.wb_clk_i (clk),
	.wb_rst_i (1'b0),
	.arst_i   (rst_n),
	.wb_adr_i (i2c_wishb_adr[2:0]),
	.wb_dat_i (i2c_wishb_dat_w[7:0]),
	.wb_dat_o (i2c_wishb_dat_r[7:0]),
	.wb_we_i  (i2c_wishb_we),
	.wb_stb_i (i2c_wishb_stb),
	.wb_cyc_i (i2c_wishb_cyc),
	.wb_ack_o (i2c_wishb_ack),

	.scl_pad_i   (i2c_scl_pad_i),
	.scl_pad_o   (i2c_scl_pad_o   ),
	.scl_padoen_o(i2c_scl_padoen_o),
                              
	.sda_pad_i   (i2c_sda_pad_i),
	.sda_pad_o   (i2c_sda_pad_o   ),
	.sda_padoen_o(i2c_sda_padoen_o),

	.wb_inta_o(i2c_irq) 
  );
  
  i2c_slave_model u_i2c_slave_model(
      .scl(i2c_scl_pad_i),
      .sda(i2c_sda_pad_i)
    );
  



//--------------accelerator---------------//
/*
wire i_icb_cmd_valid;
wire i_icb_cmd_ready;
wire i_icb_cmd_read;
wire [31:0] i_icb_cmd_addr;
wire [31:0] i_icb_cmd_wdata;
wire [3:0] i_icb_cmd_wmask;

wire i_icb_rsp_valid;
wire i_icb_rsp_ready;
wire i_icb_rsp_err;
wire [31:0] i_icb_rsp_rdata;


conv_icb_warper icb0(
  .i_icb_cmd_valid(i_icb_cmd_valid),
  .i_icb_cmd_ready(i_icb_cmd_ready),
  .i_icb_cmd_read(i_icb_cmd_read),
  .i_icb_cmd_addr(i_icb_cmd_addr),
  .i_icb_cmd_wdata(i_icb_cmd_wdata),
  .i_icb_cmd_wmask(i_icb_cmd_wmask),

  .i_icb_rsp_valid(i_icb_rsp_valid),
  .i_icb_rsp_ready(i_icb_rsp_ready),
  .i_icb_rsp_err(i_icb_rsp_err),
  .i_icb_rsp_rdata(i_icb_rsp_rdata),

  .clk(clk),
  .rst_n(rst_n),
  .conv_irq(conv_irq)

);*/
top_icb icb0(
  .clk(clk),
  .rst_n(rst_n),
  //MASTER PORT
  .m_icb_cmd_valid(m_icb_cmd_valid),
  .m_icb_cmd_ready(m_icb_cmd_ready),
  .m_icb_cmd_addr(m_icb_cmd_addr),
  .m_icb_cmd_read(m_icb_cmd_read),
  .m_icb_cmd_wdata(m_icb_cmd_wdata),
  .m_icb_cmd_wmask(m_icb_cmd_wmask),
  .m_icb_rsp_ready(m_icb_rsp_ready),
  .m_icb_rsp_valid(m_icb_rsp_valid),
  .m_icb_rsp_rdata(m_icb_rsp_rdata),
  .m_icb_rsp_err(m_icb_rsp_err),
  //SLAVE PORT
  .i_icb_cmd_valid(i_icb_cmd_valid),
  .i_icb_cmd_ready(i_icb_cmd_ready),
  .i_icb_cmd_addr(i_icb_cmd_addr),
  .i_icb_cmd_read(i_icb_cmd_read),
  .i_icb_cmd_wdata(i_icb_cmd_wdata),
  .i_icb_cmd_wmask(i_icb_cmd_wmask),
  .i_icb_rsp_ready(i_icb_rsp_ready),
  .i_icb_rsp_valid(i_icb_rsp_valid),
  .i_icb_rsp_rdata(i_icb_rsp_rdata),
  .i_icb_rsp_err(i_icb_rsp_err),
  .conv_irq(conv_irq)
);
endmodule
