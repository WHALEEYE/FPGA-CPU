# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a100tfgg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir D:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.cache/wt [current_project]
set_property parent.project_path D:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo d:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files D:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/Resources/coe_files/Testcase_1_and_2.coe
add_files d:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/Resources/coe_files/Testcase_1.1_and_2.coe
read_verilog -library xil_defaultlib {
  D:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/sources_1/new/CPU.v
  D:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/sources_1/new/Clock.v
  D:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/sources_1/new/Executs32.v
  D:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/sources_1/new/Frequency_Divider.v
  D:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/sources_1/new/Idecode32.v
  D:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/sources_1/new/Ifetc32.v
  D:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/sources_1/new/Tube_Show.v
  D:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/sources_1/new/control32.v
  D:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/sources_1/new/dmemory32.v
  D:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/sources_1/new/uart_read.v
  D:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/sources_1/new/uart_wrap.v
  D:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/sources_1/new/cpu_wrap.v
}
read_ip -quiet D:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/sources_1/ip/RAM/RAM.xci
set_property used_in_implementation false [get_files -all d:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/sources_1/ip/RAM/RAM_ooc.xdc]

read_ip -quiet D:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/sources_1/ip/cpuclk/cpuclk.xci
set_property used_in_implementation false [get_files -all d:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/sources_1/ip/cpuclk/cpuclk_board.xdc]
set_property used_in_implementation false [get_files -all d:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/sources_1/ip/cpuclk/cpuclk.xdc]
set_property used_in_implementation false [get_files -all d:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/sources_1/ip/cpuclk/cpuclk_ooc.xdc]

read_ip -quiet D:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/sources_1/ip/IRAM/IRAM.xci
set_property used_in_implementation false [get_files -all d:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/sources_1/ip/IRAM/IRAM_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/constrs_1/new/CPU_cons.xdc
set_property used_in_implementation false [get_files D:/Documents/SUSTech/Grade2/Computer_Organization/FPGA_CPU/CPU_project/CPU_project.srcs/constrs_1/new/CPU_cons.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top cpu_wrap -part xc7a100tfgg484-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef cpu_wrap.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file cpu_wrap_utilization_synth.rpt -pb cpu_wrap_utilization_synth.pb"
