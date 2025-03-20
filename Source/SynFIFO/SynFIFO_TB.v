// Synchronous FIFO - Test Bench
// Nigil

// Timescale
`timescale 1ns / 1ps

module SynFIFO_TB();

reg CLK = 1'b0;
reg RST;
reg wEN;
reg rEN;
reg dIn;

wire dOut;
wire bEmpty;
wire bFull;
    
integer count_i;

// Instantiate 

synFIFO Dut (CLK, RST, wEN, rEN, dIn, bFull, bEmpty, dOut);

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
    
    @(posedge CLK)
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
    
    readData();
    readData();
    readData();
    readData();
    readData();
    readData();
    readData();
    readData();
    
    // Test 2 - PASS
    
    $display("Test 2");
    for(count_i = 0; count_i < 8; count_i = count_i + 1) begin
        writeData($random);  
        readData();           
    end
    
    // Test 3 - PASS
    
    $display("Test 3");
    for(count_i = 0; count_i < 8; count_i = count_i + 1) begin
        writeData($random); 
    end    
    for(count_i = 0; count_i < 8; count_i = count_i + 1) begin
        readData();  
    end 

    #50 $finish; 
end                                   
endmodule
