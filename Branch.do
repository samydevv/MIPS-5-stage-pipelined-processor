vsim -gui work.microprocessor
mem load -i {D:\CUFE\6th_Semester\CMPN301_Computer Architecture\New 2020\Project\-Designing-and-implementing-a-simple-5-stage-pipelined-processor\test\Branch_InstructionMemory.mem} /microprocessor/Instruction_Memory/ram
mem load -i {D:\CUFE\6th_Semester\CMPN301_Computer Architecture\New 2020\Project\-Designing-and-implementing-a-simple-5-stage-pipelined-processor\test\Branch_DataMemory.mem} /microprocessor/Data_Memory/dataMemory
add wave -position insertpoint  \
sim:/microprocessor/rst \
sim:/microprocessor/clk \
sim:/microprocessor/Interrupt \
sim:/microprocessor/INPort \
sim:/microprocessor/OUTPort \
sim:/microprocessor/PC_IN \
sim:/microprocessor/PC_OUT \
sim:/microprocessor/R0 \
sim:/microprocessor/R1 \
sim:/microprocessor/R2 \
sim:/microprocessor/R3 \
sim:/microprocessor/R4 \
sim:/microprocessor/R5 \
sim:/microprocessor/R6 \
sim:/microprocessor/R7 \
sim:/microprocessor/ALU_Result \
sim:/microprocessor/Flags_out_CCR \
sim:/microprocessor/Jump_Selector 
force -freeze sim:/microprocessor/rst 1 0
force -freeze sim:/microprocessor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/microprocessor/Interrupt 0 0
force -freeze sim:/microprocessor/INPort 32'h30 0
run
force -freeze sim:/microprocessor/rst 0 0
run
force -freeze sim:/microprocessor/INPort 32'h50 0
run
force -freeze sim:/microprocessor/INPort 32'h100 0
run
force -freeze sim:/microprocessor/INPort 32'h300 0
run
force -freeze sim:/microprocessor/INPort 32'hFFFFFFFF 0
run
run
run
run
run
run
force -freeze sim:/microprocessor/Interrupt 1 0
run
force -freeze sim:/microprocessor/Interrupt 0 0
run
run
run
run
run
run
run
run
run
run
run
force -freeze sim:/microprocessor/INPort 32'h200 0
run
run
run
run
run
run
run
run
run
run
force -freeze sim:/microprocessor/R6 32'h300 0
force -freeze sim:/microprocessor/R7 32'hFFFFFFFF 0
run
run
run
run
run
run
run
run
run
run
run
run
run


