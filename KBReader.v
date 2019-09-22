`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//KBReader.v
//This is the top level module of a hierarchy design
//This is Key board reader that receives the input from the key board, and output 
//the corresponding break code. This reader is aiming for the keyup code,F0, and
// it will output the break code sent after on the 7seg display
//Shao-Peng Yang
//2/14/19: Initial Release
//////////////////////////////////////////////////////////////////////////////////


module KBReader(CLK, ARST_L, SCLK, SDATA, SEGS_L, SEGEN_L, DP_L);
input CLK, ARST_L, SCLK, SDATA;
output [6:0] SEGS_L;
output [7:0] SEGEN_L; 
output DP_L;
wire Clk_Fast, sync_i, sync2_i, Keyup_i, Clk_Slow, Dstrb_i; // internal wires to connect submodules
wire [3:0] hex0_i, hex1_i; // internal buses to connect KBDecoder and SevenSeg

ClkDiv100 U1(.CLKIN(CLK), .ACLR_L(ARST_L), .CLKOUT(Clk_Fast));
ClkDiv100 U2(.CLKIN(Clk_Fast), .ACLR_L(ARST_L), .CLKOUT(Clk_Slow));
Sync2 U3(.CLK(Clk_Fast), .ASYNC(SCLK), .ACLR_L(ARST_L), .SYNC(sync_i));
Sync2 U4(.CLK(Clk_Fast), .ASYNC(SDATA), .ACLR_L(ARST_L), .SYNC(sync2_i));
KBDecoder U5(.CLK(sync_i), .SDATA(sync2_i), .ARST_L(ARST_L), .HEX0(hex0_i), .HEX1(hex1_i), .KEYUP(Keyup_i));
SwitchDB U6(.SW(Keyup_i),.CLK(Clk_Slow),.ACLR_L(ARST_L),.SWDB(Dstrb_i));
SevenSeg U7(.CLK(Clk_Slow), .ARST_L(ARST_L), .HEXIN0(hex0_i), .HEXIN1(hex1_i), .HEXIN2(0), .HEXIN3(0), .HEXIN4(0), .HEXIN5(0),
	            .HEXIN6(0), .HEXIN7(0), .DSTRB(Dstrb_i), .SEGEN_L(SEGEN_L), .SEGS_L(SEGS_L), .DP_L(DP_L));

endmodule
