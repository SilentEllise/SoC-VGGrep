#source ../scripts/test_pin.tcl

set_fp_pin_constraints -block_level -use_physical_constraints on -hard_constraints {layer location}
set_ignored_layers -max_routing_layer M6
create_fp_placement -timing -no_hier -optimize_pins

derive_pg_connection -power_net VDD -power_pin VDD -ground_net VSS -ground_pin VSS
#SRAM VDDPE VDDCE VSSE
derive_pg_connection -power_net VDD -power_pin VDDPE -ground_net VSS -ground_pin VSSE
derive_pg_connection -power_net VDD -power_pin VDDCE -ground_net VSS -ground_pin VSSE

derive_pg_connection -power_net VDD -ground_net VSS -tie

check_mv_design -power_nets
# FIX PLACEMENT OF SRAM
set_object_fixed_edit [all_macro_cells] 1
set_app_var physopt_hard_keepout_distance 10

route_global -congestion_map_only
check_timing
save_mw_cel -as 3_pre_pns

