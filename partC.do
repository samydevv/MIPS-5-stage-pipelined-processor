vsim -gui work.partc
add wave -position insertpoint  \
sim:/partc/S0 \
sim:/partc/S1 \
sim:/partc/A \
sim:/partc/CF \
sim:/partc/Cin \
sim:/partc/Imm \
sim:/partc/F

force -freeze sim:/partc/Cin 1 0
radix binary
#shl tests
force -freeze sim:/partc/A 32'h04 0
force -freeze sim:/partc/Imm 32'h02 0
force -freeze sim:/partc/S0 0 0
force -freeze sim:/partc/S1 0 0
run

force -freeze sim:/partc/A 32'h04 0
force -freeze sim:/partc/Imm 32'h8 0
force -freeze sim:/partc/S0 0 0
force -freeze sim:/partc/S1 0 0
run

force -freeze sim:/partc/A 32'hFF 0
force -freeze sim:/partc/Imm 32'h8 0
force -freeze sim:/partc/S0 0 0
force -freeze sim:/partc/S1 0 0
run

force -freeze sim:/partc/A 32'h0 0
force -freeze sim:/partc/Imm 32'h8 0
force -freeze sim:/partc/S0 0 0
force -freeze sim:/partc/S1 0 0
run

#shr tests
force -freeze sim:/partc/A 32'h06 0
force -freeze sim:/partc/Imm 32'h2 0
force -freeze sim:/partc/S0 1 0
force -freeze sim:/partc/S1 0 0
run

force -freeze sim:/partc/A 32'hFFFFFFFF 0
force -freeze sim:/partc/Imm 32'hFFFF 0
force -freeze sim:/partc/S0 1 0
force -freeze sim:/partc/S1 0 0
run

force -freeze sim:/partc/A 32'h04 0
force -freeze sim:/partc/S0 1 0
force -freeze sim:/partc/S1 0 0
run

force -freeze sim:/partc/A 32'h0443232 0
force -freeze sim:/partc/Imm 32'h2 0
force -freeze sim:/partc/S0 1 0
force -freeze sim:/partc/S1 0 0
run