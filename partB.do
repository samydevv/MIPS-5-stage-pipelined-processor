vsim -gui work.partb
add wave -position insertpoint  \
sim:/partb/S0 \
sim:/partb/S1 \
sim:/partb/A \
sim:/partb/B \
sim:/partb/NF \
sim:/partb/ZF \
sim:/partb/RESULT \
sim:/partb/F

#and tests
force -freeze sim:/partb/A 32'h04 0
force -freeze sim:/partb/B 32'h05 0
force -freeze sim:/partb/S0 0 0
force -freeze sim:/partb/S1 0 0
run

force -freeze sim:/partb/A 32'h04 0
force -freeze sim:/partb/B 32'hFF 0
force -freeze sim:/partb/S0 0 0
force -freeze sim:/partb/S1 0 0
run

force -freeze sim:/partb/A 32'h01 0
force -freeze sim:/partb/B 32'hFFFFFFFF 0
force -freeze sim:/partb/S0 0 0
force -freeze sim:/partb/S1 0 0
run

force -freeze sim:/partb/A 32'h0 0
force -freeze sim:/partb/B 32'h0 0
force -freeze sim:/partb/S0 0 0
force -freeze sim:/partb/S1 0 0
run

#or tests
force -freeze sim:/partb/A 32'h06 0
force -freeze sim:/partb/B 32'h05 0
force -freeze sim:/partb/S0 1 0
force -freeze sim:/partb/S1 0 0
run

force -freeze sim:/partb/A 32'hFF 0
force -freeze sim:/partb/B 32'hFF 0
force -freeze sim:/partb/S0 1 0
force -freeze sim:/partb/S1 0 0
run

force -freeze sim:/partb/A 32'h04 0
force -freeze sim:/partb/B 32'hFFFFFFFF 0
force -freeze sim:/partb/S0 1 0
force -freeze sim:/partb/S1 0 0
run

force -freeze sim:/partb/A 32'h0443232 0
force -freeze sim:/partb/B 32'h0322 0
force -freeze sim:/partb/S0 1 0
force -freeze sim:/partb/S1 0 0
run

#not tests
force -freeze sim:/partb/A 32'h06 0
force -freeze sim:/partb/B 32'h05 0
force -freeze sim:/partb/S0 0 0
force -freeze sim:/partb/S1 1 0
run

force -freeze sim:/partb/A 32'hFF 0
force -freeze sim:/partb/B 32'hFF 0
force -freeze sim:/partb/S0 0 0
force -freeze sim:/partb/S1 1 0
run

force -freeze sim:/partb/A 32'hFFFFFFFF 0
force -freeze sim:/partb/B 32'hFFFFFFFF 0
force -freeze sim:/partb/S0 0 0
force -freeze sim:/partb/S1 1 0
run

force -freeze sim:/partb/A 32'h00 0
force -freeze sim:/partb/B 32'h0322 0
force -freeze sim:/partb/S0 0 0
force -freeze sim:/partb/S1 1 0
run
