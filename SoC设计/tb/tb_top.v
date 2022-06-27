
`include "e203_defines.v"
`timescale 1ns/10ps
module tb_top();

  reg  clk;
  reg  rst_n;

  wire hfclk = clk;

  `define CPU_TOP u_e203_soc_top.u_e203_subsys_top.u_e203_cpu_top
  `define ITCM `CPU_TOP.u_e200_srams.u_e200_itcm_ram.u_e200_itcm_gnrl_ram.u_sirv_sim_ram
  `define EXU `CPU_TOP.u_e200_cpu.u_e200_core.u_e200_exu
  //`define SRAM1 u_e203_soc_top.u_e203_subsys_top.u_e203_subsys_mems.u_sirv_sim_ram1
  wire conv_irq1 =  u_e203_soc_top.u_e203_subsys_top.i_perips.icb0.icb_ctrl_mas_0.conv_irq;
  //wire [`E200_XLEN-1:0] x3 = `EXU.u_e200_exu_regfile.rf_r[3];
  //wire [`E200_PC_SIZE-1:0] pc = `EXU.u_e200_exu_commit.alu_cmt_i_pc;
  //wire [`E200_PC_SIZE-1:0] pc_vld = `EXU.u_e200_exu_commit.alu_cmt_i_valid;


  reg[8*300:1] testcase;
  
  integer dumpwave;

  initial begin
    $display("***********************************");  
    if($value$plusargs("TESTCASE=%s",testcase))begin
      $display("TESTCASE=%s",testcase);
    end

    clk   <=0;
    rst_n <=0;
    #10 rst_n <=1;

  end

  initial begin
    #3400000
        $display("Time Out !!!");
     $finish;
  end

  always
  begin 
     #2 clk <= ~clk;
  end
  
//generate verdi 
  initial begin
    $value$plusargs("DUMPWAVE=%d",dumpwave);
    if(dumpwave != 0)begin
         // To add your waveform generation function
         $fsdbDumpfile("tb_top.fsdb");
	 $fsdbDumpvars(0, tb_top, "+all");  //-------------------------->This is to support generate FSDB waveform
    end
  end
//itcmsram
integer i;

     reg [7:0] itcm_mem [0:(`E200_ITCM_RAM_DP*8)-1];
     initial begin
       
       $readmemh({testcase, ".verilog"}, itcm_mem);
 
       for (i=0;i<(`E200_ITCM_RAM_DP);i=i+1) begin
           `ITCM.mem_r[i][00+7:00] = itcm_mem[i*8+0];
           `ITCM.mem_r[i][08+7:08] = itcm_mem[i*8+1];
           `ITCM.mem_r[i][16+7:16] = itcm_mem[i*8+2];
           `ITCM.mem_r[i][24+7:24] = itcm_mem[i*8+3];
           `ITCM.mem_r[i][32+7:32] = itcm_mem[i*8+4];
           `ITCM.mem_r[i][40+7:40] = itcm_mem[i*8+5];
           `ITCM.mem_r[i][48+7:48] = itcm_mem[i*8+6];
           `ITCM.mem_r[i][56+7:56] = itcm_mem[i*8+7];
       end
 
         $display("ITCM 0x00: %h", `ITCM.mem_r[8'h00]);
         $display("ITCM 0x01: %h", `ITCM.mem_r[8'h01]);
         $display("ITCM 0x02: %h", `ITCM.mem_r[8'h02]);
         $display("ITCM 0x03: %h", `ITCM.mem_r[8'h03]);
         $display("ITCM 0x04: %h", `ITCM.mem_r[8'h04]);
         $display("ITCM 0x05: %h", `ITCM.mem_r[8'h05]);
         $display("ITCM 0x06: %h", `ITCM.mem_r[8'h06]);
         $display("ITCM 0x07: %h", `ITCM.mem_r[8'h07]);
         $display("ITCM 0x16: %h", `ITCM.mem_r[8'h16]);
         $display("ITCM 0x20: %h", `ITCM.mem_r[8'h20]);
       
	forever begin
	  @(posedge clk)
	  //if(pc==`E200_PC_SIZE'h8000001c)
          if(conv_irq1==1'b1)
          begin
             $display("~~~~~~~~~~~~~~~~ TEST_PASS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
             $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
             $display("~~~~~~~~~ #####     ##     ####    #### ~~~~~~~~~~~~~~~~");
             $display("~~~~~~~~~ #    #   #  #   #       #     ~~~~~~~~~~~~~~~~");
             $display("~~~~~~~~~ #    #  #    #   ####    #### ~~~~~~~~~~~~~~~~");
             $display("~~~~~~~~~ #####   ######       #       #~~~~~~~~~~~~~~~~");
             $display("~~~~~~~~~ #       #    #  #    #  #    #~~~~~~~~~~~~~~~~");
             $display("~~~~~~~~~ #       #    #   ####    #### ~~~~~~~~~~~~~~~~");
             $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
             break;
           end
           /*
           else begin
             $display("~~~~~~~~~~~~~~~~ TEST_FAIL ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
             $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
             $display("~~~~~~~~~~######    ##       #    #     ~~~~~~~~~~~~~~~~");
             $display("~~~~~~~~~~#        #  #      #    #     ~~~~~~~~~~~~~~~~");
             $display("~~~~~~~~~~#####   #    #     #    #     ~~~~~~~~~~~~~~~~");
             $display("~~~~~~~~~~#       ######     #    #     ~~~~~~~~~~~~~~~~");
             $display("~~~~~~~~~~#       #    #     #    #     ~~~~~~~~~~~~~~~~");
             $display("~~~~~~~~~~#       #    #     #    ######~~~~~~~~~~~~~~~~");
             $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
           end*/
	   //break;
	  //end
	end
       #20;
       $finish;

 
     end

e203_soc_top u_e203_soc_top(
	.hfclk(hfclk),
	.corerst(~rst_n)   
);
 

endmodule
