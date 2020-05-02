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