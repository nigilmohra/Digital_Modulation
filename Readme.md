# Digital Modulation on Field Programmable Gate Array

This repository contains documents, code, and other materials related to the hardware implementation of digital modulation schemes on an FPGA. The project was completed as part of the ECE383: FPGA-based Systems Design course.

# 1. Hardware Architecture

Please note that detailed documentation is not included; only high-level architectural information is provided. 

## 1.1. SineWave Generator

There are multiple methods to generate a sine wave in Verilog, such as mathematical calculations, CORDIC algorithms, and lookup tables (LUTs). For this project, a LUT-based method is used due to its efficiency and simplicity.

The LUT values for different modulation schemes are generated using a Python script, which can be found in the PyCode folder. Each value in the LUT is a 16-bit representation of a sine wave sample.
1. For Amplitude Shift Keying (ASK), the amplitude of the sine wave is scaled to represent different binary values. This scaling adjusts the amplitude for the two possible states.
2. In Phase Shift Keying (PSK), the sine wave undergoes a phase shift of 180 degrees to distinguish between the binary states. This is achieved by reversing the sine wave samples, effectively inverting the phase of the signal.
3. For Frequency Shift Keying (FSK), the frequency of the sine wave is altered to represent the binary states. 

The frequency of the sinewave used is given by the following formula:
$$F_{SINEWAVE} = \frac{F_{CLK}}{DATAPOINTS}$$

## 1.2. Digital Modulation Module (Modified Synchronous FIFO)

A modified synchronous FIFO is used to store and buffer the incoming data bits. Each bit requires 256 clock cycles to complete its modulation process. The read and write operations of the FIFO are controlled by the "done" signal from the SineWave generator sub-module, which indicates when modulation is complete for a given bit. The buffer itself has a depth of 8 entries and a width of 1 bit per entry, allowing it to efficiently handle the incoming data stream while ensuring proper synchronization during modulation.

|  ![DigitalMod](https://github.com/user-attachments/assets/e44a043f-bc23-45c7-92f2-fbdcb733a74b) |
|:----:|
| _Figure 1. Architecture of Digital Modulation Module_|

| <img width="497" height="201" alt="image" src="https://github.com/user-attachments/assets/326d134b-210b-4800-8ecd-47d925569eaa" /> |
|:----:|
| _Figure 2. Post-Implementation Utilization Report_|

# Notes

The clock and reset signals are not explicitly shown in the design diagrams, and the output waveforms are not included. However, the design has been thoroughly verified, and you are welcome to use the provided code as needed. For more details refer [Digital Modulation Schemes - Geeks for Geeks](https://www.geeksforgeeks.org/digital-modulation-techniques/) and [Chip Verify](https://www.chipverify.com/).
