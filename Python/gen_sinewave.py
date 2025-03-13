# Sine Wave Look-Up Table Generator
# Nigil

# Import Libraries
import numpy as np
import matplotlib.pyplot as plt

# Parameters
frequency  = 1
sampleRate = 1000
numPoints  = 256  # You can change this to any number
timePeriod = 16   # Seconds

# Generate Values for Single Period
time = np.linspace(0, timePeriod, numPoints, endpoint=False)

# Generate the Sine Wave Signal Values
sineWave = np.sin(2 * np.pi * frequency * time)

# Normalize the Look-Up Table (Range 0 to 1)
normalizedSW = (sineWave + 1) / 2

# Scale to 16-bit
scaledSW = (normalizedSW * 255).astype(int)

# Convert to Hexadecimal
decTohex = [hex(value)[2:].zfill(4).upper() for value in scaledSW]

# Padding
num_digits = len(str(numPoints - 1))

# Print Data Points
print("Sine Wave Look-Up Table")
for i, hexValue in enumerate(decTohex):
    formatted_num = str(i).zfill(num_digits)
    # Verilog Code Generation
    print(f"reg [15:00] reg_datpt_{formatted_num} = 16'h{hexValue};")

# Plot
plt.figure(figsize=(10, 6))
plt.plot(time, normalizedSW, label="Sine Wave", linestyle="--")
plt.title("Sine Wave Look-Up Table")
plt.xlabel("Time(s)")
plt.ylabel("Amplitude")
plt.legend()
plt.grid(True)
plt.show()
