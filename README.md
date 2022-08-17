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

Icarus Verilog (iverilog) is a Verilog simulation and synthesis tool. It operates as a compiler, compiling source code written in Verilog (IEEE-1364) into some target format. For batch simulation, the compiler can generate an intermediate form called vvp assembly. This intermediate form is executed by the "vvp" command. For synthesis, the compiler generates netlists in the desired format.

### GTKWave

GTKWave is a fully featured GTK+ based wave viewer for Unix, Win32, and Mac OSX which reads LXT, LXT2, VZT, FST, and GHW files as well as standard Verilog VCD/EVCD files and allows their viewing.

### yosys

Yosys is a framework for Verilog RTL synthesis. It currently has extensive Verilog-2005 support and provides a basic set of synthesis algorithms for various application domains. 

### Installation of iverilog and GTKwave

<ul>
  <li>
    <b> For Ubuntu </b> 
    <br>
    <br>
    Open the terminal and enter the following commands
    
    
    $   sudo apt-get update
    $   sudo apt-get install iverilog 
    $   sudo apt-get install gtkwave
    
   </li>
</ul>

### Installation of yosys

Follow the steps from the below git repository to install yosys on Ubuntu.

<a href="https://github.com/YosysHQ/yosys/blob/master/README.md#installation">https://github.com/YosysHQ/yosys/blob/master/README.md#installation</a>

## Simulation and Synthesis

### Functional Simulation

To install git, clone this repository and download the required files for simulation, enter the below commands in the terminal.

```
$   sudo apt install -y git
$   git clone https://github.com/mahati-basavaraju/iiitb_piso

$   cd iiitb_piso

$   iverilog -o iiitb_piso iiitb_piso_tb.v  iiitb_piso.v 
$   vvp iiitb_piso

$   gtkwave iiitb_piso.vcd
```
### Synthesis 

Synthesis transforms the simple RTL design into a gate-level netlist with all the constraints as specified by the designer. In simple language, Synthesis is a process that converts the abstract form of design to a properly implemented chip in terms of logic gates.

Synthesis takes place in multiple steps:

  -  Converting RTL into simple logic gates.
  -  Mapping those gates to actual technology-dependent logic gates available in the technology libraries.
  -  Optimizing the mapped netlist keeping the constraints set by the designer intact
  
Invoke ''yosys' and execute the below commands to perform the synthesis of the above circuit.

```
$   read_liberty -lib ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib

$   read_verilog iiitb_piso.v 

$   synth -top iiitb_piso

$   dfflibmap -liberty ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib

$   abc -liberty -lib ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib

$   show

$   stat
```

### Gate Level Simulation (GLS)

GLS implies running the testbench with netlist as the design under test. It is used to verify the logical correctness of the design after synthesis. It also ensures that the timing constraints are met.

Execute below commands in the project directory to perform GLS.

```
$   iverilog -DFUNCTIONAL -DUNIT_DELAY=#0 ./verilog_model/primitives.v ./verilog_model/sky130_fd_sc_hd.v
$   ./a.out
$   gtkwave iiitb_piso.vcd
```

## Functional Characteristics

Find below simulation results when a 4-bit input '1011' is provided. Note that data_in is the input data, data_out is the output register, q is a temporary register to indicate shifting and, clk and load are clock and shift/load signals respectively.

### Pre Synthesis Simulation Result

<p align="center">
  <img src="https://user-images.githubusercontent.com/110677094/185170472-90a9e945-6555-41ac-95fc-1cf4813d2eae.png">
</p>

### Netlist representation 


<p align="center">
  <img src="https://user-images.githubusercontent.com/110677094/185150025-adeb6400-094f-4e44-8aae-315795f380c4.png">
</p>

### Statistics after synthesis
<p align="center">
  <img src="https://user-images.githubusercontent.com/110677094/185150265-9a7db214-3782-452e-88c6-4edfde6844d3.png">
</p>

### Post Synthesis Simulation Result

<p align="center">
  <img src="https://user-images.githubusercontent.com/110677094/185164154-bc472355-f5c2-41ad-8243-1fd1c2cea64c.png">
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
- http://www.vlsifacts.com/synthesis-in-vlsi/
