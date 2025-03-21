// Digital Modulation Schemes - TestBench
// Nigil

// Timescale

`timescale 1ns / 1ps

module DigitalMod_TB();

reg CLK = 1'b0;
reg RESET;
reg wEN;
reg rEN;
reg dIn;

wire bEmpty;
wire bFull;

wire send_in;
wire [15:0] data_pt;

// integer count_i;

// Instantiate 
    
synFIFO DUT (CLK, RESET, wEN, rEN, dIn, bFull, bEmpty, send_in, data_pt);

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
        wait(send_in)   
            rEN = 1'b0;
end
endtask

// Stimulus
initial begin
    #100 RESET = 1'b0;
       rEN = 1'b0;
       wEN = 1'b0;
        
    // Test 1 - PASS
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
