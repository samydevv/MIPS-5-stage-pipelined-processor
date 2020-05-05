vsim -gui work.partd
add wave -position insertpoint  \
sim:/partd/S0 \
sim:/partd/S1 \
sim:/partd/A \
sim:/partd/B \
sim:/partd/F

radix hex
#pass A tests
force -freeze sim:/partd/A 32'h0427C 0
force -freeze sim:/partd/B 32'h05 0
force -freeze sim:/partd/S0 0 0
force -freeze sim:/partd/S1 0 0
run

force -freeze sim:/partd/A 32'h002134 0
force -freeze sim:/partd/B 32'h05 0
force -freeze sim:/partd/S0 0 0
force -freeze sim:/partd/S1 0 0
run

force -freeze sim:/partd/A 32'hFFFFFFFF 0
force -freeze sim:/partd/B 32'h05 0
force -freeze sim:/partd/S0 0 0
force -freeze sim:/partd/S1 0 0
run

#pass B tests
force -freeze sim:/partd/A 32'h042 0
force -freeze sim:/partd/B 32'h04 0
force -freeze sim:/partd/S0 1 0
force -freeze sim:/partd/S1 0 0
run

force -freeze sim:/partd/A 32'h00 0
force -freeze sim:/partd/B 32'h05 0
force -freeze sim:/partd/S0 1 0
force -freeze sim:/partd/S1 0 0
run

force -freeze sim:/partd/A 32'h543 0
force -freeze sim:/partd/B 32'hFFFFFFFF 0
force -freeze sim:/partd/S0 1 0
force -freeze sim:/partd/S1 0 0
run
