# Digital Modulation on Field Programmable Gate Array

This repository contains documents, code, and other materials related to the hardware implementation of digital modulation schemes on an FPGA. The project was completed as part of the ECE383: FPGA-based Systems Design course.

Please note that detailed documentation is not included; only high-level architectural information is provided. You are welcome to use the code as needed.

# Architecture

|  ![SineWave](https://github.com/user-attachments/assets/b3003268-4630-42b6-a39b-a11163bc6d6d) |
|:----:|
| _Figure 1. Architecture of SineWave Generator (SLMod1)_|

There are multiple methods to generate a sine wave in Verilog, such as mathematical calculations, CORDIC algorithms, and lookup tables (LUTs). For this project, a LUT-based method is used due to its efficiency and simplicity, especially when implementing hardware systems like FPGA.

The LUT values for different modulation schemes are generated using a Python script, which can be found in the PyCode folder. Each value in the LUT is a 16-bit representation of a sine wave sample, with the amplitude normalized to a maximum value of one.

For Amplitude Shift Keying (ASK), the amplitude of the sine wave is scaled to represent different binary values. This scaling adjusts the amplitude for the two possible states (e.g., high and low) corresponding to the binary symbols 1 and 0.

In Phase Shift Keying (PSK), the sine wave undergoes a phase shift of 180 degrees to distinguish between the binary states. This is achieved by reversing the sine wave samples, effectively inverting the phase of the signal.

For Frequency Shift Keying (FSK), the frequency of the sine wave is altered to represent the binary states. This change in frequency is accomplished by using different step sizes in the LUTs for each symbol, allowing the signal to shift between frequencies corresponding to the 0 and 1 states.
