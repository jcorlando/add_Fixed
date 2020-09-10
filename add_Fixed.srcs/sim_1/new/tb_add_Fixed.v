`timescale 1ns / 1ps

module tb_add_Fixed;
// parameters
parameter WI1 = 4, WF1 = 4,                     // input 1 integer and fraction bits
          WI2 = 3, WF2 = 2,                     // input 2 integer and fraction bits
          WIO = WI1 > WI2 ? WI1 + 1 : WI2 + 1,  // output integer bits; WI1 > WI2 ? WI1 + 1 : WI2 + 1
          WFO = WF1 > WF2 ? WF1 : WF2;          // output fraction bits; WF1 > WF2 ? WF1 : WF2
// Local Parameters                            
localparam WIP = WI1 > WI2 ? WI1 + 1 : WI2 + 1;
localparam WFP = WF1 > WF2 ? WF1 : WF2;
//Inputs
reg RESET;
reg signed [WI1 + WF1 - 1 : 0] in1;
reg signed [WI2 + WF2 - 1 : 0] in2;
//Outputs
wire signed [WIO + WFO - 1 : 0] out;
//Instantiate DUT
add_Fixed #( .WI1(WI1), .WF1(WF1), .WI2(WI2), .WF2(WF2), .WIO(WIO), .WFO(WFO) )
        DUT( .RESET(RESET), .in1(in1), .in2(in2), .out(out) );
        
        wire [WI1 - 1 : 0] In1_int_bits = DUT.In1_int_bits;
        wire [WF1 - 1 : 0] In1_frac_bits = DUT.In1_frac_bits;
        wire [WI2 - 1 : 0] In2_int_bits = DUT.In2_int_bits;
        wire [WF2 - 1 : 0] In2_frac_bits = DUT.In2_frac_bits;
        
        wire [WIP + WFP - 2 : 0] in1_Temp = DUT.in1_Temp;
        wire [WIP + WFP - 2 : 0] in2_Temp = DUT.in2_Temp;
        
        wire [WIP + WFP - 1 : 0] in1_Temp2 = DUT.in1_Temp2;    
        wire [WIP + WFP - 1 : 0] in2_Temp2 = DUT.in2_Temp2;    

initial
begin
    RESET <= 0;
    in1 <= 8'b01001010;
    in2 <= 7'b0011010;
//    # 150;
//    # 150;
//    in1 <= 8'b0_1011_111;
//    in2 <= 9'b1_11_100110;
//    # 150;
//    in1 <= 8'b0_0101_100;
//    in2 <= 9'b0_10_100111;
//    # 150;
//    RESET <= 1;
//    # 150;
//    RESET <= 0;
//    in1 <= 8'b1_1111_001;
//    in2 <= 9'b1_01_000011;
//    # 150;
//    in1 <= 8'b0_0101_100;
//    in2 <= 9'b0_01_100111;
end

endmodule


