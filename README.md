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

<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/183280035-0182a932-d45a-402e-902a-a78977d61a86.png' > 
</p> 

In the PISO shift register circuit, the input data is applied to the input pins of the shift registers from D0 to D3  at the same time. On every subsequent clock pulse, output is read from the shift register serially 1-bit at a time from input. Here, one CLK pulse is enough to load the 4-bits of data but four pulses are required to unload all the four bits serially.

In this PISO shift register circuit, logic gates are used.  One control signal (Shift/Load) is used to control the parallel input and serial output for selection of loading or shifting function. 

For loading, ‘0’ must be given as input to the select line and for shifting, ‘1’ has to given as select input. Hence, a NOT gate is used for the select lines to distinguish loading and shifting functions. 

The connections are made as follows
- The NOT gate outputs are connected to inputs of AND gates ‘A2’, ‘A4’, and ‘A6’, and the other inputs of A2, A4 & A6 are the actual data inputs Q, R & S. Here, input ‘P’ is directly connected to D0 input of the first flip flop.

- For AND gates, A1, A3 and A5, one of the inputs is the Shift/Load select line and the other input is connected to the outputs Q0, Q1 and Q2 of respective flip flops.  
- The outputs of AND gates A1 and A2 are connected to OR gate O1, the outputs of AND gates A2 and A4 are connected to OR gate O2, The outputs of AND gates A5 and A6 are connected to OR gate O3. 
-The outputs of OR gates O1, O2 and O3 are connected to inputs of Q1, Q2 and Q3 respectively. The AND gates and OR gates, together, perform the function of a multiplexer.
-All the flip flops are to be connected in a single CLK pulse and the flip flops outputs will be in the serial data output. The serial output is taken at the output Q3 of flipflop D3.

Refer to the truth table below to understand the progress after each clock pulse. In the below truth table, input is taken as '1011'. Observe 'Q3' at each clock cycle for the serial output.

<p align='center'> 
  <img src='https://user-images.githubusercontent.com/110677094/183281909-80ee7817-a4a4-4293-96cf-d459695a2f60.png'>
</p>


<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/183254665-b745fa26-501c-4d35-a787-4001b81f4df0.png'>
</p>

## Required Tools and Installation Details

### iverilog

Icarus Verilog (iverilog) is a Verilog simulation and synthesis tool. It operates as a compiler, compiling source code written in Verilog (IEEE-1364) into some target format. For batch simulation, the compiler can generate an intermediate form called vvp assembly. This intermediate form is executed by the ``vvp'' command. For synthesis, the compiler generates netlists in the desired format.

### GTKWave

GTKWave is a fully featured GTK+ based wave viewer for Unix, Win32, and Mac OSX which reads LXT, LXT2, VZT, FST, and GHW files as well as standard Verilog VCD/EVCD files and allows their viewing.

### Installation of iverilog and GTKwave

<ul>
  <li>
    <b> For Linux Mint/ Ubuntu </b> 
    <br>
    <br>
    Open the terminal and enter the following commands
    
    
    $   sudo apt-get update
    $   sudo apt-get install iverilog 
    $   sudo apt-get install gtkwave
    
   </li>
</ul>

### Functional Simulation

To clone this repository and download the Netlist files for Simulation, enter the below commands in the terminal.

```
$   sudo apt install -y git
$   git clone https://github.com/mahati-basavaraju/iiitb_piso
$   cd iiitb_piso
$   iverilog iiitb_piso.v iiitb_pwm_piso_tb.v
$   ./a.out
$   gtkwave iiitb_piso.vcd
```

## Functional Characteristics

Find below simulation results when a 4-bit input '1011' is provided. Note that data_in is the input data, data_out is the output register, q is a temporary register to indicate shifting and, clk and load are clock and shift/load signals respectively.

<p align="center">
  <img src="https://user-images.githubusercontent.com/110677094/183284643-1817f689-22ad-4cd7-be6b-963523d34a84.png">
</p>

## Contributors

- <b> Mahati Basavaraju </b>
- <b> Kunal Ghosh </b>

## Acknowledgements

- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.

## Contact Information

- Mahati Basavaraju, Master of Science by Research Student, International Institute of Information Technology, Bangalore mahati.basavaraju@iiitb.ac.in
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com

## References
- https://www.elprocus.com/piso-shift-register/
- https://www.electronics-tutorial.net/sequential-logic-circuits/parallel-in-to-serial-out-piso-shift-register/
- https://www.electronicshub.org/shift-registers/
- https://www.youtube.com/watch?v=JzXGiVig4zE

