# Digital Modulation on Field Programmable Gate Array

This repository contains documents, code, and other materials related to the hardware implementation of digital modulation schemes on an FPGA. The project was completed as part of the ECE383: FPGA-based Systems Design course.

Please note that detailed documentation is not included; only high-level architectural information is provided. 

# 1. Hardware Architecture

## 1.1. SineWave Generator

There are multiple methods to generate a sine wave in Verilog, such as mathematical calculations, CORDIC algorithms, and lookup tables (LUTs). For this project, a LUT-based method is used due to its efficiency and simplicity, especially when implementing hardware systems like FPGA.

|  ![SineWave](https://github.com/user-attachments/assets/b3003268-4630-42b6-a39b-a11163bc6d6d) |
|:----:|
| _Figure 1. Architecture of SineWave Generator (SLMod1)_|

The LUT values for different modulation schemes are generated using a Python script, which can be found in the PyCode folder. Each value in the LUT is a 16-bit representation of a sine wave sample, with the amplitude normalized to a maximum value of one.
1. For Amplitude Shift Keying (ASK), the amplitude of the sine wave is scaled to represent different binary values. This scaling adjusts the amplitude for the two possible states (e.g., high and low) corresponding to the binary symbols 1 and 0.
2. In Phase Shift Keying (PSK), the sine wave undergoes a phase shift of 180 degrees to distinguish between the binary states. This is achieved by reversing the sine wave samples, effectively inverting the phase of the signal.
3. For Frequency Shift Keying (FSK), the frequency of the sine wave is altered to represent the binary states. This change in frequency is accomplished by using different step sizes in the LUTs for each symbol, allowing the signal to shift between frequencies corresponding to the 0 and 1 states.

## 1.2. Digital Modulation Module (Modified Synchronous FIFO)

| ![TopModule](https://github.com/user-attachments/assets/ae126c48-f352-4826-8e09-04e0409dee8e) |
|:----:|
| _Figure 2. Architecture of Digital Modulation Module (TP)_|

A modified synchronous FIFO is used to store and buffer the incoming data bits. Each bit requires 256 clock cycles to complete its modulation process. The read and write operations of the FIFO are controlled by the "done" signal from the SineWave generator sub-module, which indicates when modulation is complete for a given bit. The buffer itself has a depth of 8 entries and a width of 1 bit per entry, allowing it to efficiently handle the incoming data stream while ensuring proper synchronization during modulation.

# Note and References

The clock and reset signals are not explicitly shown in the design diagrams, and the output waveforms are not included. However, the design has been thoroughly verified, and you are welcome to use the provided code as needed.

1. [Digital Modulation Schemes - Geeks for Geeks](https://www.geeksforgeeks.org/digital-modulation-techniques/)
2. [Chip Verify](https://www.chipverify.com/)
