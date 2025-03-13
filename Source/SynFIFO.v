// Synchronous FIFO
// Nigil

// Timescale

`timescale 1ns / 1ps

module SynFIFO #(parameter DEPTH = 8, WIDTH = 16)
(
    input CLK, RST,
    input wEN, rEN,
    input [WIDTH-1:0] dIn,
    output empty, full,
    output reg [WIDTH-1:0] dOut
);

reg [$clog2(DEPTH)-1:0] wPtr;
reg [$clog2(DEPTH)-1:0] rPtr;

reg [WIDTH-1:0] reg_f_00;
reg [WIDTH-1:0] reg_f_01;
reg [WIDTH-1:0] reg_f_02;
reg [WIDTH-1:0] reg_f_03;
reg [WIDTH-1:0] reg_f_04;
reg [WIDTH-1:0] reg_f_05;
reg [WIDTH-1:0] reg_f_06;
reg [WIDTH-1:0] reg_f_07;

// Write to FIFO

always @(posedge CLK) 
begin
    if(!RST)
    begin
	wPtr <= 0;
    end
    else
    begin
        // Enable is Active and FIFO is not Full
        if(wEN & !full)
        begin
            case(wPtr)
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
end

// Read from FIFO

always @(posedge CLK)
begin
    if(!RST)
    begin
	rPtr <= 0;
    end
    else
    begin
        // Read Enable is Active and FIFO is not Empty
        if(rEN & !empty)
        begin
            case(wPtr)
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
end

// Assign Empty and Full Flags

// FIFO is full when, the write pointer is one ahead of read pointer
assign full  = (wPtr + 1) == rPtr;

// FIFO is empty when the write pointer and read pointer are equal
assign empty = wPtr == rPtr;

endmodule
