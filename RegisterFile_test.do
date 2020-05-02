vsim -gui work.registerfile
# vsim -gui work.registerfile 
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.registerfile(arch_registerfile)
# Loading work.decoder(arch_decoder)
# Loading work.mux2_1(arch_mux2_1)
# Loading work.or_2(arch_or_2)
# Loading work.registerr(arch_registerr)
# Loading work.mux8_1(arch_mux8_1)
add wave -position insertpoint  \
sim:/registerfile/rst \
sim:/registerfile/clk \
sim:/registerfile/WriteEnable \
sim:/registerfile/SwapEnable \
sim:/registerfile/Rsrc1 \
sim:/registerfile/Rsrc2 \
sim:/registerfile/Rsrc1_Out \
sim:/registerfile/Rsrc2_Out \
sim:/registerfile/WriteData1 \
sim:/registerfile/WriteData2 \
sim:/registerfile/WriteReg1 \
sim:/registerfile/WriteReg2 \
sim:/registerfile/WriteReg1_decoder_Output \
sim:/registerfile/WriteReg2_decoder_Output \
sim:/registerfile/Enables_of_Registers \
sim:/registerfile/Temp1 \
sim:/registerfile/MuxR1_out \
sim:/registerfile/MuxR2_out \
sim:/registerfile/MuxR3_out \
sim:/registerfile/MuxR4_out \
sim:/registerfile/MuxR5_out \
sim:/registerfile/MuxR6_out \
sim:/registerfile/MuxR7_out \
sim:/registerfile/MuxR8_out \
sim:/registerfile/Selector_Mux2_1 \
sim:/registerfile/R0_out \
sim:/registerfile/R1_out \
sim:/registerfile/R2_out \
sim:/registerfile/R3_out \
sim:/registerfile/R4_out \
sim:/registerfile/R5_out \
sim:/registerfile/R6_out \
sim:/registerfile/R7_out
force -freeze sim:/registerfile/rst 1 0
force -freeze sim:/registerfile/clk 1 0, 0 {50 ps} -r 100
run
force -freeze sim:/registerfile/rst 0 0
force -freeze sim:/registerfile/Rsrc1 000 0
force -freeze sim:/registerfile/Rsrc2 001 0
force -freeze sim:/registerfile/WriteEnable 1 0
force -freeze sim:/registerfile/SwapEnable 0 0
force -freeze sim:/registerfile/WriteData1 00000000000000000000000000000001 0
force -freeze sim:/registerfile/WriteData2 00000000000000000000000000000010 0
force -freeze sim:/registerfile/WriteReg1 010 0
force -freeze sim:/registerfile/WriteReg2 011 0
run
force -freeze sim:/registerfile/Rsrc1 010 0
force -freeze sim:/registerfile/Rsrc2 011 0
force -freeze sim:/registerfile/WriteEnable 1 0
force -freeze sim:/registerfile/SwapEnable 0 0
force -freeze sim:/registerfile/WriteData1 00000000000000000000000000000011 0
force -freeze sim:/registerfile/WriteData2 00000000000000000000000000000111 0
force -freeze sim:/registerfile/WriteReg1 000 0
force -freeze sim:/registerfile/WriteReg2 001 0
run
force -freeze sim:/registerfile/Rsrc1 100 0
force -freeze sim:/registerfile/Rsrc2 101 0
force -freeze sim:/registerfile/WriteEnable 1 0
force -freeze sim:/registerfile/SwapEnable 1 0
force -freeze sim:/registerfile/WriteData1 00000000000000000000000000000011 0
force -freeze sim:/registerfile/WriteData2 00000000000000000000000000000001 0
force -freeze sim:/registerfile/WriteReg1 010 0
force -freeze sim:/registerfile/WriteReg2 000 0
run
force -freeze sim:/registerfile/Rsrc1 010 0
force -freeze sim:/registerfile/Rsrc2 000 0
force -freeze sim:/registerfile/WriteEnable 1 0
force -freeze sim:/registerfile/SwapEnable 0 0
force -freeze sim:/registerfile/WriteData1 00000000000000000000000000000101 0
force -freeze sim:/registerfile/WriteData2 00000000000000000000000000000001 0
force -freeze sim:/registerfile/WriteReg1 100 0
force -freeze sim:/registerfile/WriteReg2 000 0
run