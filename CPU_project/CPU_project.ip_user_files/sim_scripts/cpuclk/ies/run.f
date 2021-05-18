-makelib ies_lib/xil_defaultlib -sv \
  "D:/Software/Vivado2017/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/Software/Vivado2017/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Software/Vivado2017/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../CPU_project.srcs/sources_1/ip/cpuclk/cpuclk_clk_wiz.v" \
  "../../../../CPU_project.srcs/sources_1/ip/cpuclk/cpuclk.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

