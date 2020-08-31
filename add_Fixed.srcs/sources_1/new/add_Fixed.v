`timescale 1ns / 1ps

module add_Fixed # (parameter WI1 = 16, WF1 = 16, // input 1 integer and fraction bits
                              WI2 = 16, WF2 = 16, // input 2 integer and fraction bits
                              WIO = 16, WFO = 16) // output integer and fraction bits
(
    input RESET,
    input [WI1 + WF1 - 1 : 0] in1,
    input [WI2 + WF2 - 1 : 0] in2,
    output [WIO + WFO - 1 : 0] out
);





endmodule

