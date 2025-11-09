// Digital Modulation Schemes - TestBench
// Nigil

// Timescale
`timescale 1ns / 1ps

// Code
module DigitalMod_tb();

reg CLK = 1'b0;
reg RESET;
reg wEN;
reg rEN;
reg dIn;
reg [1:0] SELMod;

wire bEmpty;
wire bFull;

wire send_in;
wire [15:0] data_pt;

// Instantiate 
SynFifo DUT (CLK, RESET, SELMod, wEN, rEN, dIn, bFull, bEmpty, send_in, data_pt);

// Clock
always begin #5 CLK = ~CLK; end

always @(posedge CLK)
        SELMod = 2'h1;

// Write
task writeData(input test_dIn);
begin
    @(posedge CLK);
        wEN = 1'b1;
        dIn = test_dIn;
    @(posedge CLK);
        $display("Writing Data, Data In : %0d", dIn);
        wEN = 1'b0;
end
endtask

// Read
task readData();
begin
    @(posedge CLK);
        rEN = 1'b1;
    @(posedge CLK); 
        wait(send_in)   
            rEN = 1'b0;
end
endtask

// Stimulus
initial begin
    #100 RESET = 1'b0;
       rEN = 1'b0;
       wEN = 1'b0;
    // Write
    #10  RESET = 1'b1;
    @(posedge CLK);  
    $display("Test 1");
    // Write
    writeData(0);
    writeData(1);
    writeData(0);
    writeData(1);
    writeData(0);
    writeData(1);
    writeData(0);
    writeData(1);
    // Read
    readData();       
    readData();
    readData();         
    readData();      
    readData();     
    readData();   
    readData();    
    readData(); 
    $stop;
end                              
endmodule