`timescale 1ns / 1ps

module add_Fixed # ( parameter  WI1 = 4, WF1 = 4,    // input 1 integer and fraction bits
                                WI2 = 4, WF2 = 4,    // input 2 integer and fraction bits
             WIO = WI1 > WI2 ? WI1 + 1 : WI2 + 1,    // output integer bits
             WFO = WF1 > WF2 ? WF1 : WF2 )           // output fraction bits
(
    input RESET,
    input signed [WI1 + WF1 - 1 : 0] in1,       // Add # 1
    input signed [WI2 + WF2 - 1 : 0] in2,       // Add # 2
    output reg signed [WIO + WFO - 1 : 0] out,  // Output
    output OVF                                  // Overflow flag
);
    // Local Parameters; Precise addition parameters
    localparam WIP = WI1 > WI2 ? WI1 + 1 : WI2 + 1;     // local parameters for Precise integer bits
    localparam WFP = WF1 > WF2 ? WF1 : WF2;             // local parameters for Precise fraction bits
    // Determine which inputs have the smallest WI's or WF's
    wire smallest_WI = WI1 < WI2 ? 1 : 0;    // 1 means WI1 is smaller; 0 means WI2 is smaller
    wire smallest_WF = WF1 < WF2 ? 1 : 0;    // 1 means WF1 is smaller; 0 means WF2 is smaller
    
    wire [WI1 - 1 : 0] In1_int_bits  = in1[WI1 + WF1 - 1 : WF1];  // Just the integer  bits of in1
    wire [WF1 - 1 : 0] In1_frac_bits = in1[WF1 - 1 : 0];          // Just the fraction bits of in1
    wire [WI2 - 1 : 0] In2_int_bits  = in2[WI2 + WF2 - 1 : WF2];  // Just the integer  bits of in2
    wire [WF2 - 1 : 0] In2_frac_bits = in2[WF2 - 1 : 0];          // Just the fraction bits of in2
    
    // Used to align the decimal points
    reg [WIP + WFP - 2 : 0] in1_Temp;
    reg [WIP + WFP - 2 : 0] in2_Temp;
    // Same as above but with the sign bit
    reg [WIP + WFP - 1 : 0] in1_Temp2;
    reg [WIP + WFP - 1 : 0] in2_Temp2;
    
    always @ (*)
    begin
        if(smallest_WI && smallest_WF) // WI1 is smaller; WF1 is smaller
        begin
            in1_Temp <= in1 <<< (WF2 - WF1) ;  // {(WI2 - WI1){in1[WI1 + WF1 - 1]}}
            in2_Temp <= in2;
        end
        else if(smallest_WI && !smallest_WF) // WI1 is smaller; WF2 is smaller
        begin
            in1_Temp <= { {((WIP + WFP)-(WI1 + WF1)){in1[WI1 + WF1 - 1]}} , in1 };
            in2_Temp <= { in2 , {((WIP + WFP)-(WI2 + WF2 + 1)){1'b0}} };
            
        end
        else if(!smallest_WI && smallest_WF) // WI2 is smaller; WF1 is smaller
        begin
            in2_Temp <= { {((WIP + WFP)-(WI2 + WF2)){in2[WI2 + WF2 - 1]}} , in2 };
            in1_Temp <= { in1 , {((WIP + WFP)-(WI1 + WF1 + 1)){1'b0}} };
        end
        else                                // WI2 is smaller; WF2 is smaller
        begin
            in2_Temp <= in2 <<< (WF1 - WF2);
            in1_Temp <= in1;
        end
        in1_Temp2 <= { in1_Temp[WIP + WFP - 2] , in1_Temp };
        in2_Temp2 <= { in2_Temp[WIP + WFP - 2] , in2_Temp };
        
    end
    
endmodule

