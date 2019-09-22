`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//KBDecoderTestBench.v
//This is a testbench for the KBDecoder
//It sends a sequence of inputs contains a key up code and a break code
//The Clock will be pulled to high after the break code is sent 
//Shao-Peng Yang
//2/7/19: Initial Release
//////////////////////////////////////////////////////////////////////////////////


module KBDecoderTestBench;
reg CLK, ARST_L;
reg [21:0]testvector_i;  // signal to hold the test vector
wire [3:0] HEX0, HEX1;
wire KEYUP, SDATA;

KBDecoder DUT(.CLK(CLK), .SDATA(SDATA), .ARST_L(ARST_L), .HEX0(HEX0), .HEX1(HEX1), .KEYUP(KEYUP));

// creating a clock that would pulled high after all the test sequences are sent
// it has 64 edges, which is a whole 32 periods
initial 
begin
    CLK <= 1'b0;
end
integer i = 0;
initial 
begin
    for(i=0; i < 63 ; i= i+1 )
    begin
    #5 CLK <= ~CLK;
    end
end

// reset the decoder and deactivate the reset
initial
begin
    ARST_L <= 1'b0;
    #30 ARST_L <= 1'b1;
end

initial 
begin 
    testvector_i <= 22'b0000011110100011100011; // test vector
end        

// a left-shifting shift register
// shifts MSB to the DUT
assign SDATA = testvector_i[21];
initial 
begin 
    repeat(10) @ (negedge CLK);
    repeat(22) @ (negedge CLK) testvector_i <= {testvector_i[20:0], 1'b0};
end


endmodule
