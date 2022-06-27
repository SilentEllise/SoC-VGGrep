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
//  The Subsystem-TOP module to implement CPU and some closely coupled devices
//
// ====================================================================


`include "e203_defines.v"


module e203_subsys_top(



   input core_mhartid,

  `ifdef E203_HAS_ITCM_EXTITF //{
  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////
  // External-agent ICB to ITCM
  //    * Bus cmd channel
  input                          ext2itcm_icb_cmd_valid,
  output                         ext2itcm_icb_cmd_ready,
  input  [`E203_ITCM_ADDR_WIDTH-1:0]   ext2itcm_icb_cmd_addr, 
  input                          ext2itcm_icb_cmd_read, 
  input  [`E203_XLEN-1:0]        ext2itcm_icb_cmd_wdata,
  input  [`E203_XLEN/8-1:0]      ext2itcm_icb_cmd_wmask,
  //
  //    * Bus RSP channel
  output                         ext2itcm_icb_rsp_valid,
  input                          ext2itcm_icb_rsp_ready,
  output                         ext2itcm_icb_rsp_err  ,
  output [`E203_XLEN-1:0]        ext2itcm_icb_rsp_rdata,
  `endif//}

  `ifdef E203_HAS_DTCM_EXTITF //{
  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////
  // External-agent ICB to DTCM
  //    * Bus cmd channel
  input                          ext2dtcm_icb_cmd_valid,
  output                         ext2dtcm_icb_cmd_ready,
  input  [`E203_DTCM_ADDR_WIDTH-1:0]   ext2dtcm_icb_cmd_addr, 
  input                          ext2dtcm_icb_cmd_read, 
  input  [`E203_XLEN-1:0]        ext2dtcm_icb_cmd_wdata,
  input  [`E203_XLEN/8-1:0]      ext2dtcm_icb_cmd_wmask,
  //
  //    * Bus RSP channel
  output                         ext2dtcm_icb_rsp_valid,
  input                          ext2dtcm_icb_rsp_ready,
  output                         ext2dtcm_icb_rsp_err  ,
  output [`E203_XLEN-1:0]        ext2dtcm_icb_rsp_rdata,
  `endif//}

  
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




  input  corerst, // The original async reset
  input hfclk // The generated clock by HCLKGEN


  );



  
  //This is to reset the main domain
  wire main_rst;
 sirv_ResetCatchAndSync_2 u_main_ResetCatchAndSync_2_1 (
    .test_mode(1'b0),
    .clock(hfclk),
    .reset(corerst),
    .io_sync_reset(main_rst)
  );

  wire main_rst_n = ~main_rst;

  wire                         mem_icb_cmd_valid;
  wire                         mem_icb_cmd_ready;
  wire [`E203_ADDR_SIZE-1:0]   mem_icb_cmd_addr; 
  wire                         mem_icb_cmd_read; 
  wire [`E203_XLEN-1:0]        mem_icb_cmd_wdata;
  wire [`E203_XLEN/8-1:0]      mem_icb_cmd_wmask;
  
  wire                         mem_icb_rsp_valid;
  wire                         mem_icb_rsp_ready;
  wire                         mem_icb_rsp_err  ;
  wire [`E203_XLEN-1:0]        mem_icb_rsp_rdata;


//dma part
/*  wire                        dma_icb_cmd_valid;
  wire                        dma_icb_cmd_ready;
  wire[`E203_ADDR_SIZE-1:0]   dma_icb_cmd_addr; 
  wire                        dma_icb_cmd_read; 
  wire[`E203_XLEN-1:0]        dma_icb_cmd_wdata;
  wire[`E203_XLEN/8-1:0]      dma_icb_cmd_wmask;
  */
  wire 			      dma_irq;
  wire 			      i2c_irq;
  wire                        conv_irq;
/*
  wire                         dma_icb_rsp_valid;
  wire                         dma_icb_rsp_ready;
  wire                         dma_icb_rsp_err  ;
  wire  [`E203_XLEN-1:0]       dma_icb_rsp_rdata;
*/
  wire                         ppi_icb_cmd_valid;
  wire                         ppi_icb_cmd_ready;
  wire [`E203_ADDR_SIZE-1:0]   ppi_icb_cmd_addr;
  wire                         ppi_icb_cmd_read;
  wire [`E203_XLEN-1:0]        ppi_icb_cmd_wdata;
  wire [`E203_XLEN/8-1:0]      ppi_icb_cmd_wmask;

  wire                         ppi_icb_rsp_valid;
  wire                         ppi_icb_rsp_ready;
  wire                         ppi_icb_rsp_err  ;
  wire [`E203_XLEN-1:0]        ppi_icb_rsp_rdata;

  wire                         m_icb_cmd_valid ;
  wire                         m_icb_cmd_ready ;
  wire [31:0]                  m_icb_cmd_addr  ;
  wire                         m_icb_cmd_read  ;
  wire [31:0]                  m_icb_cmd_wdata ;
  wire [3:0]                   m_icb_cmd_wmask ;
  wire                         m_icb_rsp_ready ;
  wire                         m_icb_rsp_valid ;
  wire [31:0]                  m_icb_rsp_rdata ;
  wire                         m_icb_rsp_err   ;


  e203_cpu_top u_e203_cpu_top(

  .inspect_pc               (), 
  .inspect_dbg_irq          (),
  .inspect_mem_cmd_valid    (), 
  .inspect_mem_cmd_ready    (), 
  .inspect_mem_rsp_valid    (),
  .inspect_mem_rsp_ready    (),
  .inspect_core_clk         (),

  .core_csr_clk          ( ),

    .tm_stop         (),
    .pc_rtvec        (32'h0000_1000),

    .tcm_sd          (1'b0),
    .tcm_ds          (1'b0),
    
    .core_wfi        (),

    .dbg_irq_r       (     ),

    .cmt_dpc         (),
    .cmt_dpc_ena     (),
    .cmt_dcause      (),
    .cmt_dcause_ena  (),

    .wr_dcsr_ena     (),
    .wr_dpc_ena      (),
    .wr_dscratch_ena (),



                                     
    .wr_csr_nxt      (),
                                     
    .dcsr_r          (32'h4000_0403),
    .dpc_r           (32'h0),
    .dscratch_r      (32'h0),

    .dbg_mode        (1'b0),
    .dbg_halt_r      (1'b0),
    .dbg_step_r      (1'b0),
    .dbg_ebreakm_r   (1'b0),
    .dbg_stopcycle   (1'b1),

    .core_mhartid            (1'b0),  
    .dbg_irq_a               (1'b0),
    .ext_irq_a               (conv_irq),
    .sft_irq_a               (1'b0),
    .tmr_irq_a               (1'b0),

  `ifdef E203_HAS_ITCM_EXTITF //{
    .ext2itcm_icb_cmd_valid  (ext2itcm_icb_cmd_valid),
    .ext2itcm_icb_cmd_ready  (ext2itcm_icb_cmd_ready),
    .ext2itcm_icb_cmd_addr   (ext2itcm_icb_cmd_addr ),
    .ext2itcm_icb_cmd_read   (ext2itcm_icb_cmd_read ),
    .ext2itcm_icb_cmd_wdata  (ext2itcm_icb_cmd_wdata),
    .ext2itcm_icb_cmd_wmask  (ext2itcm_icb_cmd_wmask),
    
    .ext2itcm_icb_rsp_valid  (ext2itcm_icb_rsp_valid),
    .ext2itcm_icb_rsp_ready  (ext2itcm_icb_rsp_ready),
    .ext2itcm_icb_rsp_err    (ext2itcm_icb_rsp_err  ),
    .ext2itcm_icb_rsp_rdata  (ext2itcm_icb_rsp_rdata),
  `endif//}

  `ifdef E203_HAS_DTCM_EXTITF //{
    .ext2dtcm_icb_cmd_valid  (ext2dtcm_icb_cmd_valid),
    .ext2dtcm_icb_cmd_ready  (ext2dtcm_icb_cmd_ready),
    .ext2dtcm_icb_cmd_addr   (ext2dtcm_icb_cmd_addr ),
    .ext2dtcm_icb_cmd_read   (ext2dtcm_icb_cmd_read ),
    .ext2dtcm_icb_cmd_wdata  (ext2dtcm_icb_cmd_wdata),
    .ext2dtcm_icb_cmd_wmask  (ext2dtcm_icb_cmd_wmask),
    
    .ext2dtcm_icb_rsp_valid  (ext2dtcm_icb_rsp_valid),
    .ext2dtcm_icb_rsp_ready  (ext2dtcm_icb_rsp_ready),
    .ext2dtcm_icb_rsp_err    (ext2dtcm_icb_rsp_err  ),
    .ext2dtcm_icb_rsp_rdata  (ext2dtcm_icb_rsp_rdata),
  `endif//}


    .ppi_icb_cmd_valid     (ppi_icb_cmd_valid),
    .ppi_icb_cmd_ready     (ppi_icb_cmd_ready),
    .ppi_icb_cmd_addr      (ppi_icb_cmd_addr ),
    .ppi_icb_cmd_read      (ppi_icb_cmd_read ),
    .ppi_icb_cmd_wdata     (ppi_icb_cmd_wdata),
    .ppi_icb_cmd_wmask     (ppi_icb_cmd_wmask),
  
    .ppi_icb_rsp_valid     (ppi_icb_rsp_valid),
    .ppi_icb_rsp_ready     (ppi_icb_rsp_ready),
    .ppi_icb_rsp_err       (ppi_icb_rsp_err  ),
    .ppi_icb_rsp_rdata     (ppi_icb_rsp_rdata),


    .plic_icb_cmd_valid     (),
    .plic_icb_cmd_ready     (1'b0),
    .plic_icb_cmd_addr      (),
    .plic_icb_cmd_read      (),
    .plic_icb_cmd_wdata     (),
    .plic_icb_cmd_wmask     (),
    
    .plic_icb_rsp_valid     (1'b0),
    .plic_icb_rsp_ready     (),
    .plic_icb_rsp_err       (),
    .plic_icb_rsp_rdata     (),

    .clint_icb_cmd_valid     (),
    .clint_icb_cmd_ready     (1'b0),
    .clint_icb_cmd_addr      (),
    .clint_icb_cmd_read      (),
    .clint_icb_cmd_wdata     (),
    .clint_icb_cmd_wmask     (),
    
    .clint_icb_rsp_valid     (1'b0),
    .clint_icb_rsp_ready     (),
    .clint_icb_rsp_err       (),
    .clint_icb_rsp_rdata     (),

    .fio_icb_cmd_valid     (),
    .fio_icb_cmd_ready     (1'b0),
    .fio_icb_cmd_addr      (),
    .fio_icb_cmd_read      (),
    .fio_icb_cmd_wdata     (),
    .fio_icb_cmd_wmask     (),
    
    .fio_icb_rsp_valid     (1'b0),
    .fio_icb_rsp_ready     (),
    .fio_icb_rsp_err       (),
    .fio_icb_rsp_rdata     (),

    .mem_icb_cmd_valid  (mem_icb_cmd_valid),
    .mem_icb_cmd_ready  (mem_icb_cmd_ready),
    .mem_icb_cmd_addr   (mem_icb_cmd_addr ),
    .mem_icb_cmd_read   (mem_icb_cmd_read ),
    .mem_icb_cmd_wdata  (mem_icb_cmd_wdata),
    .mem_icb_cmd_wmask  (mem_icb_cmd_wmask),
    
    .mem_icb_rsp_valid  (mem_icb_rsp_valid),
    .mem_icb_rsp_ready  (mem_icb_rsp_ready),
    .mem_icb_rsp_err    (mem_icb_rsp_err  ),
    .mem_icb_rsp_rdata  (mem_icb_rsp_rdata),

    .test_mode     (1'b0), 
    .clk           (hfclk  ),
    .rst_n         (main_rst_n) 
  );
  
  wire [31:0] dma_apb_paddr;
  wire        dma_apb_pwrite;
  wire        dma_apb_pselx;
  wire        dma_apb_penable;
  wire [31:0] dma_apb_pwdata;
  wire [31:0] dma_apb_prdata;

e203_subsys_mems u_e203_subsys_mems(

    .mem_icb_cmd_valid  (mem_icb_cmd_valid),
    .mem_icb_cmd_ready  (mem_icb_cmd_ready),
    .mem_icb_cmd_addr   (mem_icb_cmd_addr ),
    .mem_icb_cmd_read   (mem_icb_cmd_read ),
    .mem_icb_cmd_wdata  (mem_icb_cmd_wdata),
    .mem_icb_cmd_wmask  (mem_icb_cmd_wmask),
    
    .mem_icb_rsp_valid  (mem_icb_rsp_valid),
    .mem_icb_rsp_ready  (mem_icb_rsp_ready),
    .mem_icb_rsp_err    (mem_icb_rsp_err  ),
    .mem_icb_rsp_rdata  (mem_icb_rsp_rdata),

    .dma_icb_cmd_valid  (m_icb_cmd_valid),
    .dma_icb_cmd_ready  (m_icb_cmd_ready),
    .dma_icb_cmd_addr   (m_icb_cmd_addr ),
    .dma_icb_cmd_read   (m_icb_cmd_read ),
    .dma_icb_cmd_wdata  (m_icb_cmd_wdata),
    .dma_icb_cmd_wmask  (m_icb_cmd_wmask),
    
    .dma_icb_rsp_valid  (m_icb_rsp_valid),
    .dma_icb_rsp_ready  (m_icb_rsp_ready),
    .dma_icb_rsp_err    (m_icb_rsp_err  ),
    .dma_icb_rsp_rdata  (m_icb_rsp_rdata),

 

    .clk           (hfclk  ),
    .bus_rst_n     (main_rst_n), 
    .rst_n         (main_rst_n) 
  );

e203_subsys_perips i_perips(
    .ppi_icb_cmd_valid  (ppi_icb_cmd_valid),
    .ppi_icb_cmd_ready  (ppi_icb_cmd_ready),
    .ppi_icb_cmd_addr   (ppi_icb_cmd_addr ),
    .ppi_icb_cmd_read   (ppi_icb_cmd_read ),
    .ppi_icb_cmd_wdata  (ppi_icb_cmd_wdata),
    .ppi_icb_cmd_wmask  (ppi_icb_cmd_wmask),
    
    .ppi_icb_rsp_valid  (ppi_icb_rsp_valid),
    .ppi_icb_rsp_ready  (ppi_icb_rsp_ready),
    .ppi_icb_rsp_err    (ppi_icb_rsp_err  ),
    .ppi_icb_rsp_rdata  (ppi_icb_rsp_rdata),
    /*
    .dma_icb_cmd_valid  (dma_icb_cmd_valid),
    .dma_icb_cmd_ready  (dma_icb_cmd_ready),
    .dma_icb_cmd_addr   (dma_icb_cmd_addr ),
    .dma_icb_cmd_read   (dma_icb_cmd_read ),
    .dma_icb_cmd_wdata  (dma_icb_cmd_wdata),
    .dma_icb_cmd_wmask  (dma_icb_cmd_wmask),
    
    .dma_icb_rsp_valid  (dma_icb_rsp_valid),
    .dma_icb_rsp_ready  (dma_icb_rsp_ready),
    .dma_icb_rsp_err    (dma_icb_rsp_err  ),
    .dma_icb_rsp_rdata  (dma_icb_rsp_rdata),
    */
    .dma_irq            (dma_irq          ),
    
    .i2c_irq            (i2c_irq          ),
    .conv_irq            (conv_irq         ),

    .uart_pins_0_io_pins_rxd_i_ival(uart_pins_0_io_pins_rxd_i_ival),
    .uart_pins_0_io_pins_rxd_o_oval(uart_pins_0_io_pins_rxd_o_oval),
    .uart_pins_0_io_pins_rxd_o_oe  (uart_pins_0_io_pins_rxd_o_oe  ),
    .uart_pins_0_io_pins_rxd_o_ie  (uart_pins_0_io_pins_rxd_o_ie  ),

    .uart_pins_1_io_pins_rxd_i_ival(uart_pins_1_io_pins_rxd_i_ival),
    .uart_pins_1_io_pins_rxd_o_oval(uart_pins_1_io_pins_rxd_o_oval),
    .uart_pins_1_io_pins_rxd_o_oe  (uart_pins_1_io_pins_rxd_o_oe  ),
    .uart_pins_1_io_pins_rxd_o_ie  (uart_pins_1_io_pins_rxd_o_ie  ),
 
    .uart_pins_0_io_pins_txd_i_ival(uart_pins_0_io_pins_txd_i_ival),
    .uart_pins_0_io_pins_txd_o_oval(uart_pins_0_io_pins_txd_o_oval),
    .uart_pins_0_io_pins_txd_o_oe  (uart_pins_0_io_pins_txd_o_oe  ),
    .uart_pins_0_io_pins_txd_o_ie  (uart_pins_0_io_pins_txd_o_ie  ),

    .uart_pins_1_io_pins_txd_i_ival(uart_pins_1_io_pins_txd_i_ival),
    .uart_pins_1_io_pins_txd_o_oval(uart_pins_1_io_pins_txd_o_oval),
    .uart_pins_1_io_pins_txd_o_oe  (uart_pins_1_io_pins_txd_o_oe  ),
    .uart_pins_1_io_pins_txd_o_ie  (uart_pins_1_io_pins_txd_o_ie  ),

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

 
    .clk(hfclk),
    .bus_rst_n(main_rst_n),
    .rst_n(main_rst_n)

);
endmodule
