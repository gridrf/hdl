//
// Copyright 2015 Ettus Research, a National Instruments Company
//
// SPDX-License-Identifier: LGPL-3.0-or-later
//

module nh7020_ref_pll(
    input reset,
    input clk,      // 200 MHz sample clock
    input refclk,   // 40 MHz reference clock
    input ref,      // PPS or 10 MHz external reference
    output reg locked,

    // SPI lines to AD5683
    output sclk,
    output mosi,
    output sync_n
    );

    
   localparam BASE_REF_C = 100;
   reg [5:0] refcounter;
   reg main_ref;
   reg dac_update;
   reg [6:0] clkcounter;
   reg [15:0] daco = 16'd32767;
	
   always@(posedge refclk)
	begin
	   if(reset)
		begin   
		   refcounter <= 0;
			main_ref <= 0;
	   end else begin
			 if(refcounter == 6'd39)
			 begin
  			    main_ref <= ~main_ref;
				 refcounter <= 0;
			 end else
			    refcounter <= refcounter+1'b1;
	    end
	end
	
	always@(posedge clk)
	begin
	   if(reset)
		begin
			clkcounter <= 0;
			dac_update <= 0;
		end else
		begin
			 if(main_ref)
			 begin
  			    clkcounter <= clkcounter+1'b1;
				 dac_update <= 0;
			 end else begin
			    if(!dac_update)
				 begin
				   dac_update <= 1'b1;
			      daco <= daco + BASE_REF_C - clkcounter;
				 end
			    clkcounter <= 0;
		    end
		end
	end

    ad5683_spi dac
    (
        .clk(refclk),
        .dat(daco),
        .sclk(sclk),
        .mosi(mosi),
        .sync_n(sync_n)
    );
endmodule
