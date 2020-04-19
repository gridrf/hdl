`timescale 1ns/100ps

module util_gpsdo (
    input refclk,
    input resetn,
    input ref,    
    output locked,
    // SPI lines to AD5683
    output sclk,
    output mosi,
    output sync_n
);
    wire clk_ref_40;
    wire clk_ref_200;
    wire pll_locked;
    wire rst_pll = ~pll_locked;
    
    clk_wiz_gps_ref clk_wiz_gps_ref_inst(    
        // Clock out ports
        .clk_out_40(clk_ref_40),
        .clk_out_200(clk_ref_200),
  // Status and control signals
        .resetn(resetn),
        .locked(pll_locked),
 // Clock in ports
        .clk_in_40(refclk)
    );

    nh7020_ref_pll nh7020_ref_pll_inst(
        .reset(rst_pll),
        .clk(clk_ref_200),
        .refclk(clk_ref_40),
        .ref(ref),
        .locked(locked),
        .sclk(sclk),
        .mosi(mosi),
        .sync_n(sync_n)
    );

endmodule  // util_gpsdo

