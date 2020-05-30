vsim -gui work.stack_cu
add wave -position insertpoint  \
sim:/stack_cu/rst
add wave -position insertpoint  \
sim:/stack_cu/clk
add wave -position insertpoint  \
sim:/stack_cu/Call_in \
sim:/stack_cu/Interrupt_in \
sim:/stack_cu/POP_in \
sim:/stack_cu/PUSH_in \
sim:/stack_cu/RET_in \
sim:/stack_cu/RTI_in
add wave -position insertpoint  \
sim:/stack_cu/SP \
sim:/stack_cu/SP_address \
sim:/stack_cu/SP_input \
sim:/stack_cu/SP_output
radix hex
force -freeze sim:/stack_cu/Call_in 0 0
force -freeze sim:/stack_cu/Interrupt_in 0 0
force -freeze sim:/stack_cu/POP_in 0 0
force -freeze sim:/stack_cu/PUSH_in 0 0
force -freeze sim:/stack_cu/RET_in 0 0
force -freeze sim:/stack_cu/RTI_in 0 0
force -freeze sim:/stack_cu/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/stack_cu/rst 1 0
run
force -freeze sim:/stack_cu/rst 0 0
run
run
force -freeze sim:/stack_cu/PUSH_in 1 0
run
run
run
force -freeze sim:/stack_cu/PUSH_in 0 0
force -freeze sim:/stack_cu/POP_in 1 0
run
run
run
