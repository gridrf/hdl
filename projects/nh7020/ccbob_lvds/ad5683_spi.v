`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:56:52 11/10/2019 
// Design Name: 
// Module Name:    ad5683_spi 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// dat -> update triger -> update dac -> software LDAC -> wait 
//
//////////////////////////////////////////////////////////////////////////////////
module ad5683_spi(
		 input clk,
		 input[15:0] dat,
		 output sclk,
		 output mosi,
		 output sync_n
    );
	 
	 reg[15:0] ldat = 16'd0;
	 wire upd = (dat!=ldat);
	 
	 reg[5:0] scnt = 6'b0;
	 reg[3:0] cclk = 4'b0;
	 wire sclk_full = cclk == 4'b1111;
	 wire sclk_half = cclk == 4'b1000;
	 
	 reg sync_n_o = 1'b1;
	 reg sclk_o = 1'b0;
	 
	 reg[23:0] shift = 24'd0;
	 wire[23:0] nxt_shift = scnt == 1'b0 ? {4'b0011,dat,4'b0} : {shift[22:0], 1'b0};
	 
	 assign sync_n = sync_n_o;
	 assign mosi = shift[23];
	 assign sclk = sclk_o;
	 
	 always@(posedge clk)
	 begin
	    if(upd) cclk <= cclk + 1'b1;
		 
		 if(sclk_half | sclk_full) sclk_o <= ~sclk_o;
	 end
	 
	 always@(posedge sclk_o)
	 begin
    	 shift <= nxt_shift;
		 scnt <= scnt + 1'b1;
		 sync_n_o <= 1'b0;
		 
		 if(scnt == 6'b011000)begin
				sync_n_o<=1'b1;
				shift <= {4'b0001,20'b0};
		 end else if(scnt == 6'b110001)begin
		      ldat <= dat;
				scnt <= 1'b0;
				sync_n_o <= 1'b1;
		 end
	 end
	 
endmodule
