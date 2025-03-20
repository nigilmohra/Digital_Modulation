// Synchronous FIFO
// Nigil

// Timescale

`timescale 1ns / 1ps

module synFIFO (
    input CLK, 
    input RST,
    input wEN,      
    input rEN,  
    input dIn, 	    
    output bFull,   		      // Buffer Full
    output bEmpty,  		      // Buffer Empty    
    output reg dOut 		      // Input - Bit
);

// Registers

reg reg_f_00;
reg reg_f_01;
reg reg_f_02;
reg reg_f_03;
reg reg_f_04;
reg reg_f_05;
reg reg_f_06;
reg reg_f_07;

reg [2:0] wPtr;
reg [2:0] rPtr;

// Write

always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        wPtr <= 0;
    end  
    else if (wEN && !bFull) begin
        case (wPtr)
            0 : reg_f_00 <= dIn;
            1 : reg_f_01 <= dIn;
            2 : reg_f_02 <= dIn;
            3 : reg_f_03 <= dIn;      
            4 : reg_f_04 <= dIn;
            5 : reg_f_05 <= dIn;
            6 : reg_f_06 <= dIn;
            7 : reg_f_07 <= dIn;   
        endcase
        wPtr <= wPtr + 1;
    end
end

// Read

always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        rPtr <= 0;
    end  
    else if (rEN && !bEmpty) begin
        case (rPtr)
            0 : dOut <= reg_f_00;
            1 : dOut <= reg_f_01;
            2 : dOut <= reg_f_02;
            3 : dOut <= reg_f_03;
            4 : dOut <= reg_f_04;
            5 : dOut <= reg_f_05;
            6 : dOut <= reg_f_06;
            7 : dOut <= reg_f_07;
        endcase 
        rPtr <= rPtr + 1;
    end        
end

// Full and Empty

assign bEmpty = (rPtr == wPtr);
assign bFull  = ((wPtr + 1'b1) == rPtr);

endmodule
