vsim -gui work.signextend
# vsim -gui work.signextend 
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.signextend(arch_signextend)
add wave -position insertpoint  \
sim:/signextend/Enable \
sim:/signextend/IMM_EA_in \
sim:/signextend/IMM_EA_out \
sim:/signextend/EA
force -freeze sim:/signextend/Enable 1 0
force -freeze sim:/signextend/IMM_EA_in 11111111111111110000 0
run
force -freeze sim:/signextend/Enable 0 0
run
        