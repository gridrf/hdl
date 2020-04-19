source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip_xilinx.tcl

adi_ip_create util_gpsdo
 
set clk_wiz_gps_ref [ create_ip -name clk_wiz -vendor xilinx.com -library ip -version 6.0 -module_name clk_wiz_gps_ref]
set_property -dict [list \
CONFIG.PRIM_IN_FREQ {40.000} \
CONFIG.CLKOUT2_USED {true} \
CONFIG.PRIMARY_PORT {clk_in_40} \
CONFIG.CLK_OUT1_PORT {clk_out_40} \
CONFIG.CLK_OUT2_PORT {clk_out_200} \
CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {40.000} \
CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {200.000} \
CONFIG.CLKIN1_JITTER_PS {250.0} \
CONFIG.MMCM_DIVCLK_DIVIDE {1} \
CONFIG.MMCM_CLKFBOUT_MULT_F {25.000} \
CONFIG.MMCM_CLKIN1_PERIOD {25.000} \
CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F {25.000} \
CONFIG.MMCM_CLKOUT1_DIVIDE {5} \
CONFIG.NUM_OUT_CLKS {2} \
CONFIG.CLKOUT1_JITTER {232.099} \
CONFIG.CLKOUT1_PHASE_ERROR {191.950} \
CONFIG.CLKOUT2_JITTER {158.299} \
CONFIG.CLKOUT2_PHASE_ERROR {191.950} \
CONFIG.RESET_TYPE {ACTIVE_LOW} \
CONFIG.RESET_PORT {resetn} \
] [get_ips clk_wiz_gps_ref]


generate_target {all} [get_files util_gpsdo.srcs/sources_1/ip/clk_wiz_gps_ref/clk_wiz_gps_ref.xci]


adi_ip_files util_gpsdo [list \
"util_gpsdo_constr.xdc"\
"ad5683_spi.v"\
"nh7020_ref_pll.v"\
"util_gpsdo.v" ]

adi_ip_properties_lite util_gpsdo

ipx::infer_bus_interface refclk xilinx.com:signal:clock_rtl:1.0 [ipx::current_core]
ipx::infer_bus_interface resetn xilinx.com:signal:reset_rtl:1.0 [ipx::current_core]

ipx::save_core [ipx::current_core]
