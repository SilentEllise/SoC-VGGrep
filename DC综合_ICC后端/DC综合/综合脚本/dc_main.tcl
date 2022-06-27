set_host_options -max_cores 4

source ../dc_script/1_setup.tcl

source ../dc_script/2_read_file.tcl 

current_design $top

#link
check_design 

source ../dc_script/3_set_main_clk.tcl

source ../dc_script/4_set_mode_inout_drc_load.tcl

#compile > ../log/compile.log 
compile -map_effort high -area_effort high -boundary_optimization

source ../dc_script/5_write_file.tcl

