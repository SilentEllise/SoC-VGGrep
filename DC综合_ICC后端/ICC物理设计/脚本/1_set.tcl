#		     /home/jfjiang/lib/smic_130nm/SCC013UG_HD_RVT_V0p1/symbol"

#set_app_var target_library "scc013ug_hd_rvt_ss_v1p08_125c_basic.db"
#set_app_var io_library "pad.db"
#set_app_var link_library "* $target_library $io_library"
#set_app_var symbol_library "SCC013UG_HD_RVT_V0p1.sdb"


#create library
#this is the setting for csmc130nm technology
#change to library V1.0
#
set std_path "/home/riscv/library/icc/db/"
#set io_path "/home/library/wxsh/0d13um/013-CRD-DOC-V1.0/IO/Synopsys"
#set std_symb_path "/home/library/wxsh/0d13um/013-CRD-DOC-V1.0/STD_RVT/Symbol/synopsys"
#set io_symb_path "/home/library/wxsh/0d13um/013-CRD-DOC-V1.0/IO/Symbol/synopsys"

set tech_file_path "/home/riscv/library/icc/tf/"


set search_path "$std_path/  $tech_file_path/"

#target library-----------------------------------------------------------
set     target_library          saed32rvt_ss0p95v125c.db
set     memory_lib1             sram_4kx64_ss_0p99v_0p99v_125c.db
set     memory_lib2             sram_8kx32_ss_0p99v_0p99v_125c.db
#set     link_library            [list  "*" $target_library $memory_lib1 $memory_lib2]
set     link_library            "* $target_library $memory_lib1 $memory_lib2"


create_mw_lib  -technology /home/riscv/library/icc/tf/saed32nm_1p9m_mw.tf              \
               -mw_reference_library {/home/riscv/library/icc/mw_lib/saed32nm_rvt_1p9m \
                                      /home/riscv/library/icc/mw_lib/sram_4kx64    \
			              /home/riscv/library/icc/mw_lib/sram_8kx32    }   \
               -hier_separator {/} \
               -bus_naming_style {[%d]} \
               -open ../top.mw

#/home/jfjiang/lib/smic_130nm/SP013D3_V1p6/apollo/SP013D3_V1p6_6MT

set_check_library_options -all
#set TLU+ files
set_tlu_plus_files   -max_tluplus   /home/riscv/library/icc/tluplus/saed32nm_1p9m_Cmax.tluplus     \
                     -min_tluplus   /home/riscv/library/icc/tluplus/saed32nm_1p9m_Cmin.tluplus     \
                     -tech2itf_map  /home/riscv/library/icc/tluplus/saed32nm_tf_itf_tluplus.map


