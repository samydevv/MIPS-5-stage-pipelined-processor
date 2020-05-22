vsim -gui work.hdu

add wave -position insertpoint  \
sim:/hdu/IdExMemRead \
sim:/hdu/IdExRdst1 \
sim:/hdu/IfIdRsrc1 \
sim:/hdu/IfIdRsrc2 \
sim:/hdu/Stall

force -freeze sim:/hdu/IdExRdst1 111 0
force -freeze sim:/hdu/IfIdRsrc1 111 0
force -freeze sim:/hdu/IfIdRsrc2 110 0
force -freeze sim:/hdu/IdExMemRead 1 0
run

force -freeze sim:/hdu/IdExRdst1 111 0
force -freeze sim:/hdu/IfIdRsrc1 111 0
force -freeze sim:/hdu/IdExMemRead 0 0
run

force -freeze sim:/hdu/IdExRdst1 111 0
force -freeze sim:/hdu/IfIdRsrc1 110 0
force -freeze sim:/hdu/IfIdRsrc2 111 0
force -freeze sim:/hdu/IdExMemRead 1 0
run

force -freeze sim:/hdu/IdExRdst1 101 0
force -freeze sim:/hdu/IfIdRsrc1 111 0
force -freeze sim:/hdu/IfIdRsrc2 111 0
force -freeze sim:/hdu/IdExMemRead 1 0
run