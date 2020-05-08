vsim -gui work.stack_cu
# vsim -gui work.stack_cu 
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.stack_cu(arch_stack_cu)
# Loading work.sp_register(arch_sp_register)
# vsim -gui work.stack_cu 
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.stack_cu(arch_stack_cu)
# Loading work.sp_register(arch_sp_register)
add wave -position insertpoint  \
sim:/stack_cu/rst \
sim:/stack_cu/clk \
sim:/stack_cu/Call_in \
sim:/stack_cu/RET_in \
sim:/stack_cu/POP_in \
sim:/stack_cu/PUSH_in \
sim:/stack_cu/RTI_in \
sim:/stack_cu/Interrupt_in \
sim:/stack_cu/SP_address \
sim:/stack_cu/SP_output \
sim:/stack_cu/SP_input \
sim:/stack_cu/temp_address \
sim:/stack_cu/temp_zeros
force -freeze sim:/stack_cu/rst 1 0
force -freeze sim:/stack_cu/clk 1 0, 0 {50 ps} -r 100
run
force -freeze sim:/stack_cu/rst 0 0
force -freeze sim:/stack_cu/PUSH_in 1 0
run
force -freeze sim:/stack_cu/PUSH_in 0 0
force -freeze sim:/stack_cu/POP_in 1 0
run
force -freeze sim:/stack_cu/POP_in 0 0
force -freeze sim:/stack_cu/Call_in 1 0
run
force -freeze sim:/stack_cu/Call_in 0 0
force -freeze sim:/stack_cu/RET_in 1 0
run
force -freeze sim:/stack_cu/RET_in 0 0
force -freeze sim:/stack_cu/Interrupt_in 1 0
run
force -freeze sim:/stack_cu/Interrupt_in 0 0
force -freeze sim:/stack_cu/RTI_in 1 0
run
force -freeze sim:/stack_cu/RTI_in 0 0
run