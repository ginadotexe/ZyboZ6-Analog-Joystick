set_property PACKAGE_PIN K17 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
set_property PACKAGE_PIN K18 [get_ports {resetn}]
set_property IOSTANDARD LVCMOS33 [get_ports {resetn}]
set_property PACKAGE_PIN D18 [get_ports {leds[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[3]}]
set_property PACKAGE_PIN G14 [get_ports {leds[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[2]}]
set_property PACKAGE_PIN M15 [get_ports {leds[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[1]}]
set_property PACKAGE_PIN M14 [get_ports {leds[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[0]}]

set_property -dict { PACKAGE_PIN K14   IOSTANDARD LVCMOS33 } [get_ports { vp_x }]; #IO_L21P_T3_DQS_AD14P_35 Sch=JA4_R_p		
set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { vn_x }]; #IO_L21N_T3_DQS_AD6N_35 Sch=JA4_R_N        
   
set_property -dict { PACKAGE_PIN L14   IOSTANDARD LVCMOS33 } [get_ports { vp_y }]; #IO_L22P_T3_AD7P_35 Sch=JA2_R_P                         
set_property -dict { PACKAGE_PIN L15   IOSTANDARD LVCMOS33 } [get_ports { vn_y }]; #IO_L22N_T3_AD7N_35 Sch=JA2_R_N               