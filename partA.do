vsim -gui work.parta
add wave -position insertpoint  \
sim:/parta/S0 \
sim:/parta/S1 \
sim:/parta/Cin \
sim:/parta/A \
sim:/parta/B \
sim:/parta/CF \
sim:/parta/NF \
sim:/parta/ZF \
sim:/parta/RESULT \
sim:/parta/F

radix hex
#add tests
force -freeze sim:/parta/A 32'h04 0
force -freeze sim:/parta/B 32'h05 0
force -freeze sim:/parta/S0 0 0
force -freeze sim:/parta/S1 0 0
run

force -freeze sim:/parta/A 32'h04 0
force -freeze sim:/parta/B 32'hFF 0
force -freeze sim:/parta/S0 0 0
force -freeze sim:/parta/S1 0 0
run

force -freeze sim:/parta/A 32'h01 0
force -freeze sim:/parta/B 32'hFFFFFFFF 0
force -freeze sim:/parta/S0 0 0
force -freeze sim:/parta/S1 0 0
run

force -freeze sim:/parta/A 32'h0 0
force -freeze sim:/parta/B 32'h0 0
force -freeze sim:/parta/S0 0 0
force -freeze sim:/parta/S1 0 0
run

#sub tests
force -freeze sim:/parta/A 32'h06 0
force -freeze sim:/parta/B 32'h05 0
force -freeze sim:/parta/S0 1 0
force -freeze sim:/parta/S1 0 0
run

force -freeze sim:/parta/A 32'hFF 0
force -freeze sim:/parta/B 32'hFF 0
force -freeze sim:/parta/S0 1 0
force -freeze sim:/parta/S1 0 0
run

force -freeze sim:/parta/A 32'h04 0
force -freeze sim:/parta/B 32'hFFFFFFFF 0
force -freeze sim:/parta/S0 1 0
force -freeze sim:/parta/S1 0 0
run

force -freeze sim:/parta/A 32'h0443232 0
force -freeze sim:/parta/B 32'h0322 0
force -freeze sim:/parta/S0 1 0
force -freeze sim:/parta/S1 0 0
run

#inc tests
force -freeze sim:/parta/A 32'h06 0
force -freeze sim:/parta/B 32'h05 0
force -freeze sim:/parta/S0 0 0
force -freeze sim:/parta/S1 1 0
run

force -freeze sim:/parta/A 32'hFF 0
force -freeze sim:/parta/B 32'hFF 0
force -freeze sim:/parta/S0 0 0
force -freeze sim:/parta/S1 1 0
run

force -freeze sim:/parta/A 32'hFFFFFFFF 0
force -freeze sim:/parta/B 32'hFFFFFFFF 0
force -freeze sim:/parta/S0 0 0
force -freeze sim:/parta/S1 1 0
run

force -freeze sim:/parta/A 32'h00 0
force -freeze sim:/parta/B 32'h0322 0
force -freeze sim:/parta/S0 0 0
force -freeze sim:/parta/S1 1 0
run

#dec tests
force -freeze sim:/parta/A 32'h06 0
force -freeze sim:/parta/B 32'h05 0
force -freeze sim:/parta/S0 1 0
force -freeze sim:/parta/S1 1 0
run

force -freeze sim:/parta/A 32'h1 0
force -freeze sim:/parta/B 32'hFF 0
force -freeze sim:/parta/S0 1 0
force -freeze sim:/parta/S1 1 0
run

force -freeze sim:/parta/A 32'hFFFFFFFF 0
force -freeze sim:/parta/B 32'hFFFFFFFF 0
force -freeze sim:/parta/S0 1 0
force -freeze sim:/parta/S1 1 0
run

force -freeze sim:/parta/A 32'h00 0
force -freeze sim:/parta/B 32'h0322 0
force -freeze sim:/parta/S0 1 0
force -freeze sim:/parta/S1 1 0
run