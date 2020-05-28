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
sim:/microprocessor/Instruction \
sim:/microprocessor/OP_Code \
sim:/microprocessor/Function_Code \
sim:/microprocessor/Rscr1_Address \
sim:/microprocessor/Rscr2_Address \
sim:/microprocessor/Rdst_Address \
sim:/microprocessor/Rsrc1_Data \
sim:/microprocessor/Rsrc2_Data \
sim:/microprocessor/Reg_WB_Data1 \
sim:/microprocessor/Reg_WB_Data2 \
sim:/microprocessor/Reg_WB_Addr1 \
sim:/microprocessor/Reg_WB_Addr2 \
sim:/microprocessor/R0 \
sim:/microprocessor/R1 \
sim:/microprocessor/R2 \
sim:/microprocessor/R3 \
sim:/microprocessor/R4 \
sim:/microprocessor/R5 \
sim:/microprocessor/R6 \
sim:/microprocessor/R7 \
sim:/microprocessor/Sign_Extend_Enable \
sim:/microprocessor/Imm_EA \
sim:/microprocessor/IMM_EA_out \
sim:/microprocessor/Scrs_A \
sim:/microprocessor/Scrs_B \
sim:/microprocessor/ALU_Result \
sim:/microprocessor/Flags_out_CCR \
sim:/microprocessor/CF_ALU_OUT \
sim:/microprocessor/NF_ALU_OUT \
sim:/microprocessor/ZF_ALU_OUT \
sim:/microprocessor/CF_MUX_OUT 
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


