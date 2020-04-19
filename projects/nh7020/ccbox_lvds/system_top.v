// ***************************************************************************
// ***************************************************************************
// Copyright 2014 - 2017 (c) Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/master/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module system_top (

  inout   [14:0]  ddr_addr,
  inout   [ 2:0]  ddr_ba,
  inout           ddr_cas_n,
  inout           ddr_ck_n,
  inout           ddr_ck_p,
  inout           ddr_cke,
  inout           ddr_cs_n,
  inout   [ 3:0]  ddr_dm,
  inout   [31:0]  ddr_dq,
  inout   [ 3:0]  ddr_dqs_n,
  inout   [ 3:0]  ddr_dqs_p,
  inout           ddr_odt,
  inout           ddr_ras_n,
  inout           ddr_reset_n,
  inout           ddr_we_n,

  inout           fixed_io_ddr_vrn,
  inout           fixed_io_ddr_vrp,
  inout   [53:0]  fixed_io_mio,
  inout           fixed_io_ps_clk,
  inout           fixed_io_ps_porb,
  inout           fixed_io_ps_srstb,

  inout           iic_scl,
  inout           iic_sda,
  inout   [2:0]  gpio_bd,

  output          i2s_mclk,
  output          i2s_bclk,
  output          i2s_lrclk,
  output          i2s_sdata_out,
  input           i2s_sdata_in,
  output          audio_pdn,

  output          oled_csn,
  output          oled_clk,
  output          oled_mosi,
  output          oled_rst,
  output          oled_dc,
  
  input           gps_pps,
  output  [5:0]   gpio_led,

  inout           tsw_s1,
  inout           tsw_s2,
  inout           tsw_s3,
  inout           tsw_s4,
  inout           tsw_s5,
  inout           tsw_a,
  inout           tsw_b,

  input           rx_clk_in_p,
  input           rx_clk_in_n,
  input           rx_frame_in_p,
  input           rx_frame_in_n,
  input   [ 5:0]  rx_data_in_p,
  input   [ 5:0]  rx_data_in_n,
  output          tx_clk_out_p,
  output          tx_clk_out_n,
  output          tx_frame_out_p,
  output          tx_frame_out_n,
  output  [ 5:0]  tx_data_out_p,
  output  [ 5:0]  tx_data_out_n,

  output          enable,
  output          txnrx,
  input           clkout_in,
  inout           gpio_clksel,
  inout           gpio_resetb,
  inout           gpio_sync,
  inout           gpio_en_agc,
  inout   [ 3:0]  gpio_ctl,
  inout   [ 7:0]  gpio_status,

  output          spi_csn,
  output          spi_clk,
  output          spi_mosi,
  input           spi_miso,

  output          dac_spi_sdi,
  output          dac_spi_sclk,
  output          dac_spi_sync_n,
  
  input 	  clk_40mhz
);
  // internal signals

  wire    [63:0]  gpio_i;
  wire    [63:0]  gpio_o;
  wire    [63:0]  gpio_t;

  wire  dac_locked;

  assign gpio_led[5:3] = {~gps_pps, ~dac_locked, 1'b1};
/*
  wire  clk_200mhz_o;
  wire  dac_pll_locked;
  wire  dac_rest_n = ~(dac_pll_locked && gpio_o[9]);

  nh7020_ref_pll nh7020_ref_pll_inst(
    .reset(dac_rest_n),
    .clk(clk_100mhz_o),      // 200 MHz sample clock
    .refclk(clk_40mhz),   // 40 MHz reference clock
    .ref(gps_pps),      // PPS or 10 MHz external reference
    .locked(dac_locked),

    // SPI lines to AD5683
    .sclk(dac_spi_sclk),
    .mosi(dac_spi_sdi),
    .sync_n(dac_spi_sync_n)
    );
  
  clk_wiz_dac clk_wiz_dac_inst(  
    .clk_out_200mhz(clk_200mhz_o),    
    .clk_in_40mhz(clk_40mhz),
    .resetn(1'b1),
    .locked(dac_pll_locked)
  );

  //dac test only
   //CLK_40
  IBUFG clk_40_buf(
	.I(clk_40mhz),
	.O(clk_40mhz_o)
  );

  reg[15:0] clk_dac_val = 16'd32767;

  ad5683_spi ad5683_inst(
	.clk(clk_40mhz_o),
        .dat(clk_dac_val),
	.sclk(dac_spi_sclk),
	.mosi(dac_spi_sdi),
	.sync_n(dac_spi_sync_n)
  );
*/
  // assignments
  assign audio_pdn = gpio_o[8];
  assign oled_clk = spi_clk;
  assign oled_mosi = spi_mosi;

  // gpio[31:20] controls misc stuff (keep as io)

  assign gpio_i[31:12] = gpio_o[31:12];
  assign gpio_i[7:4] = {gps_pps, gpio_o[6:4]};
  
  // gpio[3:0] controls the power switch led colors
  assign gpio_led[2:0] = gpio_o[2:0];
  assign gpio_i[3:0] = gpio_o[3:0];


  // gpio[11:8] controls the imu/oled reset & such.

  assign oled_dc = gpio_o[11];
  assign oled_rst = gpio_o[10];
  assign gpio_i[11:8] = gpio_o[11:8];
  // unused gpio - 63:30
  assign gpio_i[63:60] = gpio_o[63:60];
  assign gpio_i[56:52] = gpio_o[56:52];
  
  // tsw-part-2 gpio - 59:57

  ad_iobuf #(.DATA_WIDTH(3)) i_iobuf_tsw_2 (
    .dio_t (gpio_t[59:57]),
    .dio_i (gpio_o[59:57]),
    .dio_o (gpio_i[59:57]),
    .dio_p ({ tsw_a,              // 59
              tsw_b,              // 58
              tsw_s1}));          // 57
  // tact-scroll-wheel gpio - 50:47

  ad_iobuf #(.DATA_WIDTH(4)) i_iobuf_tsw_1 (
    .dio_t (gpio_t[50:47]),
    .dio_i (gpio_o[50:47]),
    .dio_o (gpio_i[50:47]),
    .dio_p ({ tsw_s2,             // 50
              tsw_s3,             // 49
              tsw_s4,             // 48
              tsw_s5}));          // 47

  ad_iobuf #(.DATA_WIDTH(16)) i_iobuf (
    .dio_t ({gpio_t[51], gpio_t[46:32]}),
    .dio_i ({gpio_o[51], gpio_o[46:32]}),
    .dio_o ({gpio_i[51], gpio_i[46:32]}),
    .dio_p ({ gpio_clksel,        // 51:51
    	      gpio_resetb,        // 46:46
              gpio_sync,          // 45:45
              gpio_en_agc,        // 44:44
              gpio_ctl,           // 43:40
              gpio_status}));     // 39:32


  // instantiations

  system_wrapper i_system_wrapper (
    .ddr_addr (ddr_addr),
    .ddr_ba (ddr_ba),
    .ddr_cas_n (ddr_cas_n),
    .ddr_ck_n (ddr_ck_n),
    .ddr_ck_p (ddr_ck_p),
    .ddr_cke (ddr_cke),
    .ddr_cs_n (ddr_cs_n),
    .ddr_dm (ddr_dm),
    .ddr_dq (ddr_dq),
    .ddr_dqs_n (ddr_dqs_n),
    .ddr_dqs_p (ddr_dqs_p),
    .ddr_odt (ddr_odt),
    .ddr_ras_n (ddr_ras_n),
    .ddr_reset_n (ddr_reset_n),
    .ddr_we_n (ddr_we_n),
    .enable (enable),
    .fixed_io_ddr_vrn (fixed_io_ddr_vrn),
    .fixed_io_ddr_vrp (fixed_io_ddr_vrp),
    .fixed_io_mio (fixed_io_mio),
    .fixed_io_ps_clk (fixed_io_ps_clk),
    .fixed_io_ps_porb (fixed_io_ps_porb),
    .fixed_io_ps_srstb (fixed_io_ps_srstb),
    .gpio_i (gpio_i),
    .gpio_o (gpio_o),
    .gpio_t (gpio_t),
    .i2s_bclk (i2s_bclk),
    .i2s_lrclk (i2s_lrclk),
    .i2s_mclk (i2s_mclk),
    .i2s_sdata_in (i2s_sdata_in),
    .i2s_sdata_out (i2s_sdata_out),
    .iic_main_scl_io (iic_scl),
    .iic_main_sda_io (iic_sda),
    .otg_vbusoc (1'b0),
    .rx_clk_in_n (rx_clk_in_n),
    .rx_clk_in_p (rx_clk_in_p),
    .rx_data_in_n (rx_data_in_n),
    .rx_data_in_p (rx_data_in_p),
    .rx_frame_in_n (rx_frame_in_n),
    .rx_frame_in_p (rx_frame_in_p),
    .spi0_clk_i (1'b0),
    .spi0_clk_o (spi_clk),
    .spi0_csn_0_o (spi_csn),
    .spi0_csn_1_o (oled_csn),
    .spi0_csn_2_o (),
    .spi0_csn_i (1'b1),
    .spi0_sdi_i (spi_miso),
    .spi0_sdo_i (1'b0),
    .spi0_sdo_o (spi_mosi),
    .spi1_clk_i (1'b0),
    .spi1_clk_o (),
    .spi1_csn_0_o (),
    .spi1_csn_1_o (),
    .spi1_csn_2_o (),
    .spi1_csn_i (1'b1),
    .spi1_sdi_i (1'b0),
    .spi1_sdo_i (1'b0),
    .spi1_sdo_o (),
    .tdd_sync_i (1'b0),
    .tdd_sync_o (),
    .tdd_sync_t (),
    .gps_pps (gps_pps),
    .gpsdo_ref_clk(clk_40mhz),
    .gpsdo_locked(dac_locked),
    .gpsdo_dac_sclk(dac_spi_sclk),
    .gpsdo_dac_mosi(dac_spi_sdi),
    .gpsdo_dac_sync_n(dac_spi_sync_n),
    .sys_cpu_clk_out (sys_cpu_clk),
    .tx_clk_out_n (tx_clk_out_n),
    .tx_clk_out_p (tx_clk_out_p),
    .tx_data_out_n (tx_data_out_n),
    .tx_data_out_p (tx_data_out_p),
    .tx_frame_out_n (tx_frame_out_n),
    .tx_frame_out_p (tx_frame_out_p),
    .txnrx (txnrx),
    .up_enable (gpio_o[47]),
    .up_txnrx (gpio_o[48])
    );

endmodule

// ***************************************************************************
// ***************************************************************************
