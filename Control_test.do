vsim -gui work.control
# vsim -gui work.control 
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.control(arch_control)
# vsim -gui work.control 
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.control(arch_control)
add wave -position insertpoint  \
sim:/control/OP_Code \
sim:/control/Function_Code \
sim:/control/Interrupt_in \
sim:/control/Reset_in \
sim:/control/Output_Enable \
sim:/control/Call \
sim:/control/RET \
sim:/control/POP \
sim:/control/PUSH \
sim:/control/RTI \
sim:/control/Stack_operation \
sim:/control/JMP \
sim:/control/JMP_ZF \
sim:/control/JMP_CF \
sim:/control/JMP_NF \
sim:/control/Reg_Dst_selector \
sim:/control/WB \
sim:/control/MEM \
sim:/control/EX \
sim:/control/Selector_set_carry \
sim:/control/Write_Enable \
sim:/control/Regsrc2_Control \
sim:/control/Sign_Extend_Enable \
sim:/control/Interrupt_out \
sim:/control/Reset_out \
sim:/control/Swap_Enable \
sim:/control/temp
force -freeze sim:/control/OP_Code 11 0
force -freeze sim:/control/Function_Code 000 0
force -freeze sim:/control/Interrupt_in 0 0
force -freeze sim:/control/Reset_in 0 0
run
force -freeze sim:/control/Function_Code 001 0
run
force -freeze sim:/control/Function_Code 010 0
run
force -freeze sim:/control/Function_Code 011 0
run
force -freeze sim:/control/Function_Code 100 0
run
force -freeze sim:/control/Function_Code 101 0
run
force -freeze sim:/control/Function_Code 110 0
run
force -freeze sim:/control/OP_Code 10 0
force -freeze sim:/control/Function_Code 000 0
run
force -freeze sim:/control/Function_Code 001 0
run
force -freeze sim:/control/Function_Code 010 0
run
force -freeze sim:/control/Function_Code 011 0
run
force -freeze sim:/control/Function_Code 100 0
run
force -freeze sim:/control/Function_Code 101 0
run
force -freeze sim:/control/Function_Code 110 0
run
force -freeze sim:/control/Function_Code 111 0
run
force -freeze sim:/control/OP_Code 01 0
force -freeze sim:/control/Function_Code 000 0
run
force -freeze sim:/control/Function_Code 001 0
run
force -freeze sim:/control/Function_Code 010 0
run
force -freeze sim:/control/Function_Code 011 0
run
force -freeze sim:/control/Function_Code 100 0
run
force -freeze sim:/control/Function_Code 101 0
run
force -freeze sim:/control/Function_Code 110 0
run
force -freeze sim:/control/OP_Code 00 0
force -freeze sim:/control/Function_Code 000 0
run
force -freeze sim:/control/Function_Code 001 0
run
force -freeze sim:/control/Function_Code 010 0
run
force -freeze sim:/control/Function_Code 011 0
run
force -freeze sim:/control/Function_Code 100 0
run
force -freeze sim:/control/Function_Code 101 0
run