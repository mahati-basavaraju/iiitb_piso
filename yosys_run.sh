# read design

read_verilog iiitb_piso.v

# generic synthesis
synth -top iiitb_piso

# mapping to mycells.lib
dfflibmap -liberty /home/lahari/Documents/Mahati/IIITB/Courses/Sem1/ASIC/Assignment_1_piso/iiitb_piso/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/lahari/Documents/Mahati/IIITB/Courses/Sem1/ASIC/Assignment_1_piso/lib/sky130_fd_sc_hd__tt_025C_1v80.lib -script +strash;scorr;ifraig;retime,{D};strash;dch,-f;map,-M,1,{D}
clean
flatten
# write synthesized design
write_verilog -noattr iiitb_piso_synth.v
stat
