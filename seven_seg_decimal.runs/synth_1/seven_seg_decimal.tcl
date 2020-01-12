# 
# Synthesis run script generated by Vivado
# 

set_param gui.test TreeTableDev
debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

create_project -in_memory -part xc7a35tcpg236-1
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir D:/fpga/xilinix/projects/seven_seg_decimal/seven_seg_decimal.cache/wt [current_project]
set_property parent.project_path D:/fpga/xilinix/projects/seven_seg_decimal/seven_seg_decimal.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_verilog -library xil_defaultlib D:/fpga/xilinix/projects/seven_seg_decimal/seven_seg_decimal.srcs/sources_1/imports/Desktop/seven_seg_decimal.v
read_xdc D:/fpga/xilinix/projects/seven_seg_decimal/seven_seg_decimal.srcs/constrs_1/imports/Desktop/constr.xdc
set_property used_in_implementation false [get_files D:/fpga/xilinix/projects/seven_seg_decimal/seven_seg_decimal.srcs/constrs_1/imports/Desktop/constr.xdc]

catch { write_hwdef -file seven_seg_decimal.hwdef }
synth_design -top seven_seg_decimal -part xc7a35tcpg236-1
write_checkpoint -noxdef seven_seg_decimal.dcp
catch { report_utilization -file seven_seg_decimal_utilization_synth.rpt -pb seven_seg_decimal_utilization_synth.pb }