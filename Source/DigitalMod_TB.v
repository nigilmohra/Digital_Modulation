// Synchronous FIFO - TestBench
// Nigil

// Timescale

`timescale 1ns / 1ps

module DigitalMod_TB
(
    
);

reg CLK = 1'b0;
reg RST;
reg wEN;
reg rEN;
reg dIn;

wire dFLAG;
wire dOut;
wire bEmpty;
wire bFull;
wire [15:0] data_pt;

    
integer count_i;

// Instantiate 

synFIFO Dut (CLK, RST, wEN, rEN, dIn, bFull, bEmpty, dOut, dFLAG, data_pt);

// Clock

always begin #5 CLK = ~CLK; end

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
        $display("Reading Data, Data Out: %0d", dOut);
        rEN = 1'b0;
end
endtask

// Stimulus

initial begin
    #1 RST = 1'b0;
       rEN = 1'b0;
       wEN = 1'b0;
        
    // Test 1 - PASS
    // Write
    
    @(posedge CLK);
       RST = 1'b1;  
       
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
    wait(dFLAG)
        readData();  
    wait(dFLAG)        
        readData(); 
    wait(dFLAG)          
        readData(); 
    wait(dFLAG)     
        readData(); 
    wait(dFLAG)    
        readData(); 
    wait(dFLAG)     
        readData(); 
    wait(dFLAG)  
        readData(); 
    wait(dFLAG) 
        readData(); 
    wait(dFLAG)   
    $stop;
end                                   
endmodule
