
#set TLU+ files
#set_tlu_plus_files   -max_tluplus   /home/library/wxsh/0d13um/013-CRD-DOC-V1.0/starrc/tluplus/thin/CSMCM1316M01_sal_cell_max.tluplus     \
 #                    -min_tluplus   /home/library/wxsh/0d13um/013-CRD-DOC-V1.0/starrc/tluplus/thin/CSMCM1316M01_sal_cell_min.tluplus     \
 #                    -tech2itf_map  /home/jiangjf/ip_test/backend/icc/tluplus_tf.map
#                     -tech2itf_map  /home/library/wxsh/0d13um/VS013/BEView_STDIO/VS-CSMC-13-Tapeout-Kit-V0.5/TECH/CSMC013E_layer_m6.map


check_tlu_plus_files
list_libs

#import designs
import_designs -format verilog /home/riscv/soclab/phy_design/mapped/top.mapped.v

derive_pg_connection -power_net VDD -power_pin VDD -ground_net VSS -ground_pin VSS
#SRAM VDDPE VDDCE VSSE
derive_pg_connection -power_net VDD -power_pin VDDPE -ground_net VSS -ground_pin VSSE
derive_pg_connection -power_net VDD -power_pin VDDCE

derive_pg_connection -power_net VDD -ground_net VSS -tie

check_mv_design -power_nets


read_sdc /home/riscv/soclab/phy_design/mapped/top.sdc
#/home/jiangjf/ip_test/backend/dc/mapped/top_digital_pad.sdc
check_timing
report_timing_requirements
report_disable_timing
report_case_analysis
report_clock -skew


set_fix_multiple_port_nets -all -buffer_constants
save_mw_cel -as 1_data_setup

#
