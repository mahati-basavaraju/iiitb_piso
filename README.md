# iiitb_piso
This repository contains details of design and working of a 4-bit PISO(Parallel In Serial Out) Shift Register

# PISO Shift Register

## Introduction
The shift register which uses parallel input and generates serial output is known as the parallel input serial output shift register or PISO shift register. In this shift register, the input data enters a parallel way and comes out serially. The flip-flops are connected such that the input of the second flip flop is the output of the first flip flop. Since a 4-bit PISO shift register is being implemented , 4 flip flops are used.

## Applications
PISO Shift Registers are commonly used in
- Communication lines where a number of data lines are multiplexed into single serial data line
- Reading data into a microprocessor
- Transmitter section in Analog to Digital converters

## Block Diagram
The  4- bit PISO shift register circuit diagram is shown below. This circuit mainly includes 4, D flip flops which are connected as per the diagram shown. The CLK(clock) input signal is connected directly to all the flip flops however the input data is individually connected to every flip flop. Hence it is a synchronous sequential circuit. The previous flip flop’s output, as well as parallel input data, is simply connected to the input of the second flip flop. 

<!-- <p align='center'> <img src='https://user-images.githubusercontent.com/110677094/183253281-a217bd12-05cf-4c50-b486-e306ba8625fb.png' > </p> -->

In the PISO shift register circuit, the input data is applied to the input pins of the shift registers from D0 to D3  at the same time. On every subsequent clock pulse, output is read from the shift register serially 1-bit at a time from input. Here, one CLK pulse is enough to load the 4-bits of data but four pulses are required to unload all the four bits serially.

In this PISO shift register circuit, logic gates are used.  One control signal (Shift/Load) is used to control the parallel input and serial output for selection of loading or shifting function. 

For loading, ‘0’ must be given as input to the select line and for shifting, ‘1’ has to given as select input. Hence, a NOT gate is used for the select lines to distinguish loading and shifting functions. The NOT gate outputs are connected to inputs of AND gates ‘A2’, ‘A4’, and ‘A6’, and the other inputs of A2, A4 & A6 are the actual data inputs Q, R & S. Here, input ‘P’ is directly connected to D0 input of the first flip flop.

For AND gates, A1, A3 and A5, one of the inputs is the Shift/Load select line and the other input is connected to the outputs Q0, Q1 and Q2 of respective flip flops.  The outputs of AND gates A1 and A2 are connected to OR gate O1, the outputs of AND gates A2 and A4 are connected to OR gate O2, The outputs of AND gates A5 and A6 are connected to OR gate O3. The outputs of OR gates O1, O2 and O3 are connected to inputs of Q1, Q2 and Q3 respectively. The AND gates and OR gates, together, perform the function of a multiplexer. All the flip flops are to be connected in a single CLK pulse and the flip flops outputs will be in the serial data output.

Refer to the truth table below to understand the progress after each clock pulse.

<p align='center'> 
  <img src='https://user-images.githubusercontent.com/110677094/183254713-54e75bc6-0135-470e-98d9-0218d492a696.png'>
</p>


<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/183254665-b745fa26-501c-4d35-a787-4001b81f4df0.png'>
</p>

