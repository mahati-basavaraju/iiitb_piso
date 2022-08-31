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

### Installation of OpenLane

OpenLane is an automated RTL to GDSII flow based on several components including OpenROAD, Yosys, Magic, Netgen, CVC, SPEF-Extractor, CU-GR, Klayout and a number of custom scripts for design exploration and optimization. The flow performs full ASIC implementation steps from RTL all the way down to GDSII.


Follow the steps from the below git repository to install OpenLane on Ubuntu.

<a href="https://github.com/The-OpenROAD-Project/OpenLane>https://github.com/The-OpenROAD-Project/OpenLane</a>


### Installation of magic and its prerequisites

Enter below commands

```
$ sudo apt-get update 
$ sudo apt-get install csh
$ sudo apt-get install x11
$ sudo apt-get install xorg
$ sudo apt-get install xorg openbox
$ sudo apt-get install freeglut3-dev
$ sudo apt-get install tcl-dev tk-dev
```
```
$ git clone https://github.com/RTimothyEdwards/magic
$ cd magic
$ ./configure
$ make
$ sudo make install
```


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

## Layout

Once we complete above steps, we can proceed with the physical design steps.

For this, we use OpenLane flow.

Create a new directory with the project names in OpenLane/designs. This contain a config.json file, a folder names runs and a folder named src.
Add the verilog top module file in src folder and edit the config file as below.

<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187761449-91dc74f1-6f95-4cdf-a866-9601f2a20bf6.png'>
</p>

The config file should include paths of sky130 .lib files and the vsd_inv .lef file.


Follow below commands to move to OpenLane working directory and move to OpenLane base.

```
$   cd OpenLane

$   make mount

```

To start the OpenLane flow in an interactive mode and to prepare the design, enter below commands.


```
% ./flow.tcl -interactive

```
<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187757791-de1a5ab3-9fb9-42f6-af16-6a56220fc7f6.png'>
</p>


```
% package require openlane

```
<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187758028-2b76fb71-edc5-4fc8-8a01-c71fd70b8723.png'>
</p>


```
% prep -design iiitb_piso
```
<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187758330-d2740959-8817-4d4f-be28-9789ae51f526.png'>
</p>

To merge the vsd_inv lef file into our design, use below commands.

```
% set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
% add_lefs -src $lefs

```
<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187759529-b1291b7f-3c46-47ad-a17d-9e82a78bfc48.png'>
</p>

Next step is to synthesise. Run below command.
```
% run_synthesis
```

<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187759864-faf9ed87-6e05-4e02-97d5-1a7c48ce29d9.png'>
</p>

The statistics after synthesis can be found in the <current_run_directory>/reports/synthesis/1-synthesis.AREA_0.stat.rpt
<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187760969-69dca37e-1157-41af-b606-6e556491ce1a.png'>
</p>

Run floorplan
```
% run_floorplan
```
<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187760217-a911008b-ba6f-45f7-8117-d9f0673b6c3d.png'>
</p>

View the floorplan, using the below magic command in the terminal opened in the directory: <current_run_directory>/results/floorplan

```
$ magic -T /home/mahati/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.min.lef def read iiitb_piso.def &
```

<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187763347-c0399aaa-071d-4d82-b74c-6f9bb26369fe.png'>
</p>


Refer below image for full view of floorplan

<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187762221-efc81d57-9eab-45e7-a78f-ad0b4bb9f8cc.png'>
</p>

Refer below image for zoomed view of floorplan

<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187762720-53a41d05-8a13-44f6-bdb9-039a23acf963.png'>
</p>

Refer below image for the cells on floorplan (one can find them by zooming into the left bottom corner)

<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187762862-0ea00650-b6fb-4c93-a18c-9a19c38c762f.png'>
</p>

Run placement
```
% run_placement
```
<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187760307-a4807b0b-8e9d-4904-aa18-09802dfbf4da.png'>
</p>

View the placement in the layout, using the below magic command in the terminal opened in the directory: <current_run_directory>/results/placement

```
$ magic -T /home/mahati/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.min.lef def read iiitb_piso.def &
```
<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187763502-4b3d4615-da83-4477-9a45-9ea135329227.png'>
</p>

Also we can spot the required cell using getcell command in tcl console. Here, we try to find the sky130_vsdinv cell.

```
getcell sky130_vsdinv
```

<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187763951-b9cf4bf1-3e21-4a64-b643-215c462b74ad.png'>
</p>


The required cell then gets selected and highlighted in white. You can spot it in the following images.

Refer below image for full view of layout after placement

<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187764105-74d62462-6f27-4202-84c9-fa6996e4c6df.png'>
</p>

Refer below image for zoomed view of layout after placement

<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187764267-698bcd30-5b9a-4e11-b5cb-36586ab7778f.png'>
</p>


<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187764366-92c22628-23f8-4b71-b026-d88e3fda7834.png'>
</p>

The zoomed in view of sky130_inv cell is as below.

<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187764820-599c1823-955c-4ade-87cf-c2d8a33e78a0.png'>
</p>


Run cts
```
% run_cts
```
<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187760401-e6a7c271-e6cb-410d-bd43-e899dfbfcbc2.png'>
</p>


Run routing
```
% run_routing
```
<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187760542-0f452384-4691-4f32-80f1-d5e8e124ac0b.png'>
</p>


View the layout after routing, using the below magic command in the terminal opened in the directory: <current_run_directory>/results/routing

```
$ magic -T /home/mahati/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.min.lef def read iiitb_piso.def &
```
<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187765247-70c0c557-c09f-4e27-bdfd-7394bdcbdcd2.png'>
</p>

Also we can spot the required cell using getcell command in tcl console. Here, we try to find the sky130_vsdinv cell.

```
getcell sky130_vsdinv
```

<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187765420-26400d3b-83b3-445d-a70e-f2177b7f825d.png'>
</p>


The required cell then gets selected and highlighted in white. You can spot it in the following images.

Refer below image for full view of layout after routing

<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187765546-fd202cec-3910-455f-94bb-eadd958e380d.png'>
</p>

Refer below image for zoomed view of after routing

<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187764267-698bcd30-5b9a-4e11-b5cb-36586ab7778f.png'>
</p>


<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187765711-7c911be9-877e-458c-ae83-a800e85171e6.png'>
</p>

The sky130_vsdinv instance can be spotted here

<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187765853-1d384832-a052-4058-b81f-af1bbd9299ff.png'>
</p>

The zoomed in view of sky130_inv cell is as below.

<p align='center'>
  <img src='https://user-images.githubusercontent.com/110677094/187765961-4c475884-757e-4aac-980f-f533e54d8363.png'>
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
- https://github.com/The-OpenROAD-Project/OpenLane
- https://github.com/Devipriya1921/Physical_Design_Using_OpenLANE_Sky130
- https://github.com/DantuNandiniDevi/iiitb_freqdiv
- https://github.com/Bandaanusha/iiitb_rtc
