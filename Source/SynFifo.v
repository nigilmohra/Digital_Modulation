// Synchronous FIFO
// Nigil

// Timescale
`timescale 1ns / 1ps

// Code
module SynFifo (
    input CLK, 
    input RESET,
    input wEN,      
    input rEN,  
    input dIn, 	 
           
    output bFull,   		      
    output bEmpty,  		
    
    output send_in,
    output reg [15:0] data_out      
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

reg [3:0] wPtr;
reg [2:0] rPtr;

// Wire
wire [15:0] data_pt;
wire done;

// Register
reg dOut;

assign send_in = done;

// Write
always @(posedge CLK) begin
    if (!RESET) begin
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
        if(wPtr == 8)
            wPtr <= 0;
    end
end

// Read
always @(posedge CLK) begin
    if (!RESET) begin
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
        if(done)
            rPtr <= rPtr + 1;  
        else
            rPtr <= rPtr;
    end        
end

// Output
always @(posedge CLK)
begin
    data_out <= data_pt;
end    
    
// Full and Empty
assign bEmpty   = (rPtr == wPtr);
assign bFull    = ({~wPtr[3], wPtr[2:0]} == {1'b0, rPtr});

// Instantiate
SineWave SineWave_1 (CLK, RESET, rEN, dOut, done, data_pt); 

endmodule