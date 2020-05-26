vsim -gui work.microprocessor
mem load -i {D:\CUFE\6th_Semester\CMPN301_Computer Architecture\New 2020\Project\-Designing-and-implementing-a-simple-5-stage-pipelined-processor\test\test3_InstructionMemory.mem} /microprocessor/Instruction_Memory/ram
mem load -i {D:\CUFE\6th_Semester\CMPN301_Computer Architecture\New 2020\Project\-Designing-and-implementing-a-simple-5-stage-pipelined-processor\test\test3_DataMemory.mem} /microprocessor/Data_Memory/dataMemory
add wave -position insertpoint  \
sim:/microprocessor/rst \
sim:/microprocessor/clk \
sim:/microprocessor/Interrupt \
sim:/microprocessor/INPort \
sim:/microprocessor/OUTPort \
sim:/microprocessor/PC_IN \
sim:/microprocessor/PC_OUT \
sim:/microprocessor/Instruction \
sim:/microprocessor/OP_Code \
sim:/microprocessor/Function_Code \
sim:/microprocessor/Rscr1_Address \
sim:/microprocessor/Rscr2_Address \
sim:/microprocessor/Rdst_Address \
sim:/microprocessor/Imm_EA \
sim:/microprocessor/WB \
sim:/microprocessor/MEM \
sim:/microprocessor/EX \
sim:/microprocessor/Selector_set_carry \
sim:/microprocessor/Write_Enable \
sim:/microprocessor/Swap_Enable \
sim:/microprocessor/R0 \
sim:/microprocessor/R1 \
sim:/microprocessor/R2 \
sim:/microprocessor/R3 \
sim:/microprocessor/R4 \
sim:/microprocessor/R5 \
sim:/microprocessor/R6 \
sim:/microprocessor/R7 \
sim:/microprocessor/Flags_out_CCR \
sim:/microprocessor/ALU_Result \
sim:/microprocessor/CF_ALU_OUT \
sim:/microprocessor/NF_ALU_OUT \
sim:/microprocessor/ZF_ALU_OUT \
sim:/microprocessor/CF_MUX_OUT \
sim:/microprocessor/Data_Memory_Output \
sim:/microprocessor/M10 \
sim:/microprocessor/M32 \
sim:/microprocessor/Write_Enable_IEMEM \
sim:/microprocessor/Write_Enable_WB
force -freeze sim:/microprocessor/rst 1 0
force -freeze sim:/microprocessor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/microprocessor/Interrupt 0 0
force -freeze sim:/microprocessor/INPort 32'h5a 0
run
#force -freeze sim:/microprocessor/rst 0 0
#force -freeze sim:/microprocessor/INPort 32'h0a 0
#run
#force -freeze sim:/microprocessor/INPort 32'h1A 0
#run
#force -freeze sim:/microprocessor/INPort 32'h2A 0
#run
#force -freeze sim:/microprocessor/INPort 32'h3A 0
#run
#force -freeze sim:/microprocessor/INPort 32'h4a 0
#run
#force -freeze sim:/microprocessor/INPort 32'h5a 0
#run
#force -freeze sim:/microprocessor/INPort 32'h6a 0
#run
#force -freeze sim:/microprocessor/INPort 32'h7a 0
#run
#run
#run
#run
