create_die_area  \
	-poly { {0.000 0.000} {1871.800 0.000} {1871.800 435.90} {0.000 435.90} }

 #-poly { {0.000 0.000} {1871.800 0.000} {1871.800 435.90} {0.000 435.90} }

#source ../scripts/pad_new.tcl

create_floorplan -control_type aspect_ratio -start_first_row -flip_first_row -left_io2core 20 -bottom_io2core 20 -right_io2core 20 -top_io2core 20

create_fp_virtual_pad -nets VSS -point {0 600}
create_fp_virtual_pad -nets VDD -point {0 200}

save_mw_cel -as 2_floorplan

