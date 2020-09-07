`timescale 1ns / 1ps

module add_Fixed # ( parameter  WI1 = 4, WF1 = 4,    // input 1 integer and fraction bits
                                WI2 = 4, WF2 = 4,    // input 2 integer and fraction bits
             WIO = WI1 > WI2 ? WI1 + 1 : WI2 + 1,    // output integer bits
             WFO = WF1 > WF2 ? WF1 : WF2 )           // output fraction bits
(
    input RESET,
    input signed [WI1 + WF1 - 1 : 0] in1,       // Add # 1
    input signed [WI2 + WF2 - 1 : 0] in2,       // Add # 2
    output reg signed [WIO + WFO - 1 : 0] out   // Output
);
    wire smallest_WI = WI1 < WI2 ? 1 : 0;    // 1 means WI1 is smaller; 0 means WI2 is smaller
    wire smallest_WF = WF1 < WF2 ? 1 : 0;    // 1 means WF1 is smaller; 0 means WF2 is smaller
    
    wire [WI1 - 1 : 0] In1_int_bits  = in1[WI1 + WF1 - 1 : WF1];  // Just the integer  bits of in1
    wire [WF1 - 1 : 0] In1_frac_bits = in1[WF1 - 1 : 0];          // Just the fraction bits of in1
    wire [WI2 - 1 : 0] In2_int_bits  = in2[WI2 + WF2 - 1 : WF2];  // Just the integer  bits of in2
    wire [WF2 - 1 : 0] In2_frac_bits = in2[WF2 - 1 : 0];          // Just the fraction bits of in2
    
    wire [WIO + WFO - 1 : 0] in1_Temp = { in1 , {((WIO + WFO)-(WI1 + WF1)){1'b0}} };
    wire [WIO + WFO - 1 : 0] in2_Temp = { {((WIO + WFO)-(WI2 + WF2)){in2[WI2 + WF2 - 1]}} , in2 };
    
    
    always @ (*)
    begin
        if(smallest_WI)
        begin
            //
        end
        else
        begin
            //
        end
        if(smallest_WF)
        begin
            //
        end
        else
        begin
            //
        end
        if(RESET) out <= 0;
        else out <= in1 + in2;
    end
    
endmodule

