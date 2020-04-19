
## constraints (ccbox.a)

## orphans- io- (ps7 gpio)
## oled

set_property  -dict {PACKAGE_PIN  Y12    IOSTANDARD  LVCMOS33} [get_ports  oled_csn]         ; ## U1,V5,IO_L06_13_JX2_P,JX2,18,OLED_CS#
set_property  -dict {PACKAGE_PIN  V10    IOSTANDARD  LVCMOS33} [get_ports  oled_clk]         ; ## U1,V7,IO_L11_SRCC_13_JX2_N,JX2,37,OLED_SCL
set_property  -dict {PACKAGE_PIN  V11    IOSTANDARD  LVCMOS33} [get_ports  oled_mosi]        ; ## U1,T9,IO_L12_MRCC_13_JX2_P,JX2,36,OLED_SDI
set_property  -dict {PACKAGE_PIN  W11    IOSTANDARD  LVCMOS33} [get_ports  oled_rst]         ; ## U1,U7,IO_L11_SRCC_13_JX2_P,JX2,35,OLED_/RES
set_property  -dict {PACKAGE_PIN  Y11    IOSTANDARD  LVCMOS33} [get_ports  oled_dc]          ; ## U1,U10,IO_L12_MRCC_13_JX2_N,JX2,38,OLED_D/C

## GPS (DATA-UART)
## U1,C5,PS_MIO14_500_JX4,JX4,93,GPS_TXD1_1V8
## U1,C8,PS_MIO15_500_JX4,JX4,85,GPS_RXD1_1V8

set_property  -dict {PACKAGE_PIN  Y13    IOSTANDARD  LVCMOS33} [get_ports  gps_pps]          ; ## U1,T5,IO_L19_13_JX2_P,JX2,61,GPS_PPS

## orphans- io- (ps7 gpio)

set_property  -dict {PACKAGE_PIN  V5     IOSTANDARD  LVCMOS33} [get_ports  gpio_led[0]]   ; ## LED TRX R
set_property  -dict {PACKAGE_PIN  U5     IOSTANDARD  LVCMOS33} [get_ports  gpio_led[1]]   ; ## LED TRX G    
set_property  -dict {PACKAGE_PIN  T5     IOSTANDARD  LVCMOS33} [get_ports  gpio_led[2]]   ; ## LED TRX B

set_property  -dict {PACKAGE_PIN  W9     IOSTANDARD  LVCMOS33} [get_ports  gpio_led[3]]   ; ## LED RX2 R
set_property  -dict {PACKAGE_PIN  Y7     IOSTANDARD  LVCMOS33} [get_ports  gpio_led[4]]   ; ## LED RX2 G    
set_property  -dict {PACKAGE_PIN  Y6     IOSTANDARD  LVCMOS33} [get_ports  gpio_led[5]]   ; ## LED RX2 B

## audio

set_property  -dict {PACKAGE_PIN  T9     IOSTANDARD  LVCMOS33} [get_ports  i2s_bclk]         ; ## U1,Y6,IO_L13_MRCC_13_JX2_N,JX2,43,AUD_BCLK
set_property  -dict {PACKAGE_PIN  Y9     IOSTANDARD  LVCMOS33} [get_ports  i2s_lrclk]        ; ## U1,Y9,IO_L14_SRCC_13_JX2_P,JX2,42,AUD_LRCLK
set_property  -dict {PACKAGE_PIN  U10    IOSTANDARD  LVCMOS33} [get_ports  i2s_mclk]         ; ## U1,Y7,IO_L13_MRCC_13_JX2_P,JX2,41,AUD_MCLK
set_property  -dict {PACKAGE_PIN  Y8     IOSTANDARD  LVCMOS33} [get_ports  i2s_sdata_in]     ; ## U1,Y8,IO_L14_SRCC_13_JX2_N,JX2,44,AUD_SDATA_IN
set_property  -dict {PACKAGE_PIN  W8     IOSTANDARD  LVCMOS33} [get_ports  i2s_sdata_out]    ; ## U1,W8,IO_L15_13_JX2_P,JX2,47,AUD_SDATA_OUT
set_property  -dict {PACKAGE_PIN  V8     IOSTANDARD  LVCMOS33} [get_ports  audio_pdn]        ; ## U1,V8,IO_L15_13_JX2_N
## tsw

set_property  -dict {PACKAGE_PIN  T10   IOSTANDARD  LVCMOS25 PULLTYPE PULLUP} [get_ports  tsw_s1]           ; ## IO_L01_34_P,NAV_SWITCH_S1
set_property  -dict {PACKAGE_PIN  U13   IOSTANDARD  LVCMOS25 PULLTYPE PULLUP} [get_ports  tsw_s2]           ; ## IO_L03_34_P,NAV_SWITCH_S2
set_property  -dict {PACKAGE_PIN  T11   IOSTANDARD  LVCMOS25 PULLTYPE PULLUP} [get_ports  tsw_s3]           ; ## IO_L01_34_N,NAV_SWITCH_S3
set_property  -dict {PACKAGE_PIN  V12   IOSTANDARD  LVCMOS25 PULLTYPE PULLUP} [get_ports  tsw_s4]           ; ## IO_L04_34_p,NAV_SWITCH_S4
set_property  -dict {PACKAGE_PIN  T12   IOSTANDARD  LVCMOS25 PULLTYPE PULLUP} [get_ports  tsw_s5]           ; ## IO_L02_34_P,NAV_SWITCH_S5
set_property  -dict {PACKAGE_PIN  V13   IOSTANDARD  LVCMOS25 PULLTYPE PULLUP} [get_ports  tsw_a]            ; ## IO_L03_34_N,NAV_SWITCH_A
set_property  -dict {PACKAGE_PIN  U12   IOSTANDARD  LVCMOS25 PULLTYPE PULLUP} [get_ports  tsw_b]            ; ## IO_L02_34_N,NAV_SWITCH_B

