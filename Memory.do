vsim -gui work.microprocessor
mem load -i {D:\CUFE\6th_Semester\CMPN301_Computer Architecture\New 2020\Project\-Designing-and-implementing-a-simple-5-stage-pipelined-processor\test\Memory_InstructionMemory.mem} /microprocessor/Instruction_Memory/ram
mem load -i {D:\CUFE\6th_Semester\CMPN301_Computer Architecture\New 2020\Project\-Designing-and-implementing-a-simple-5-stage-pipelined-processor\test\Memory_DataMemory.mem} /microprocessor/Data_Memory/dataMemory
add wave -position insertpoint  \
sim:/microprocessor/rst \
sim:/microprocessor/clk \
sim:/microprocessor/Interrupt \
sim:/microprocessor/INPort \
sim:/microprocessor/OUTPort \
sim:/microprocessor/PC_IN \
sim:/microprocessor/PC_OUT \
sim:/microprocessor/Instruction \
sim:/microprocessor/PC_Plus_1 \
sim:/microprocessor/PC_Plus_2 \
sim:/microprocessor/PC_Next \
sim:/microprocessor/OP_Code \
sim:/microprocessor/Function_Code \
sim:/microprocessor/Rscr1_Address \
sim:/microprocessor/Rscr2_Address \
sim:/microprocessor/Rdst_Address \
sim:/microprocessor/Imm_EA \
sim:/microprocessor/PC_Next_IFID \
sim:/microprocessor/PC_OUT_IFID \
sim:/microprocessor/IN_Port_IFID \
sim:/microprocessor/ALU_Enable \
sim:/microprocessor/CCR_Enable \
sim:/microprocessor/Output_Enable \
sim:/microprocessor/Call \
sim:/microprocessor/RET \
sim:/microprocessor/POP \
sim:/microprocessor/PUSH \
sim:/microprocessor/RTI \
sim:/microprocessor/Stack_operation \
sim:/microprocessor/JMP \
sim:/microprocessor/JMP_ZF \
sim:/microprocessor/JMP_CF \
sim:/microprocessor/JMP_NF \
sim:/microprocessor/Reg_Dst_selector \
sim:/microprocessor/WB \
sim:/microprocessor/MEM \
sim:/microprocessor/EX \
sim:/microprocessor/Selector_set_carry \
sim:/microprocessor/Write_Enable \
sim:/microprocessor/Regsrc2_Control \
sim:/microprocessor/Sign_Extend_Enable \
sim:/microprocessor/Interrupt_out \
sim:/microprocessor/Swap_Enable \
sim:/microprocessor/Input_Enable \
sim:/microprocessor/Stall \
sim:/microprocessor/ALU_Enable_Stall \
sim:/microprocessor/CCR_Enable_Stall \
sim:/microprocessor/Output_Enable_Stall \
sim:/microprocessor/Call_Stall \
sim:/microprocessor/RET_Stall \
sim:/microprocessor/POP_Stall \
sim:/microprocessor/PUSH_Stall \
sim:/microprocessor/RTI_Stall \
sim:/microprocessor/Stack_operation_Stall \
sim:/microprocessor/JMP_Stall \
sim:/microprocessor/JMP_ZF_Stall \
sim:/microprocessor/JMP_CF_Stall \
sim:/microprocessor/JMP_NF_Stall \
sim:/microprocessor/Reg_Dst_selector_Stall \
sim:/microprocessor/WB_Stall \
sim:/microprocessor/MEM_Stall \
sim:/microprocessor/EX_Stall \
sim:/microprocessor/Selector_set_carry_Stall \
sim:/microprocessor/Write_Enable_Stall \
sim:/microprocessor/Regsrc2_Control_Stall \
sim:/microprocessor/Sign_Extend_Enable_Stall \
sim:/microprocessor/Interrupt_out_Stall \
sim:/microprocessor/Swap_Enable_Stall \
sim:/microprocessor/Input_Enable_Stall \
sim:/microprocessor/Scr2_Address \
sim:/microprocessor/Write_Enable_WB \
sim:/microprocessor/Swap_Enable_WB \
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
sim:/microprocessor/IMM_EA_out \
sim:/microprocessor/ALU_Enable_IDIE \
sim:/microprocessor/CCR_Enable_IDIE \
sim:/microprocessor/Call_IDIE \
sim:/microprocessor/RET_IDIE \
sim:/microprocessor/POP_IDIE \
sim:/microprocessor/PUSH_IDIE \
sim:/microprocessor/RTI_IDIE \
sim:/microprocessor/Stack_operation_IDIE \
sim:/microprocessor/JMP_IDIE \
sim:/microprocessor/JMP_ZF_IDIE \
sim:/microprocessor/JMP_CF_IDIE \
sim:/microprocessor/JMP_NF_IDIE \
sim:/microprocessor/Reg_Dst_selector_IDIE \
sim:/microprocessor/WB_IDIE \
sim:/microprocessor/MEM_IDIE \
sim:/microprocessor/EX_IDIE \
sim:/microprocessor/Selector_set_carry_IDIE \
sim:/microprocessor/Write_Enable_IDIE \
sim:/microprocessor/Regsrc2_Control_IDIE \
sim:/microprocessor/Interrupt_out_IDIE \
sim:/microprocessor/Swap_Enable_IDIE \
sim:/microprocessor/PC_OUT_IDIE \
sim:/microprocessor/PC_Next_IDIE \
sim:/microprocessor/Rscr1_AddressIDIE \
sim:/microprocessor/Rscr2_AddressIDIE \
sim:/microprocessor/Rdst_AddressIDIE \
sim:/microprocessor/IMM_EA_IDIE \
sim:/microprocessor/Rsrc1_Data_IDIE \
sim:/microprocessor/Rsrc2_Data_IDIE \
sim:/microprocessor/IN_Port_IDIE \
sim:/microprocessor/OutputPortEnable_IDIE \
sim:/microprocessor/InputPortEnable_IDIE \
sim:/microprocessor/Src2_Data_ALU \
sim:/microprocessor/Flags_out_CCR \
sim:/microprocessor/ALU_Result \
sim:/microprocessor/CF_ALU_OUT \
sim:/microprocessor/NF_ALU_OUT \
sim:/microprocessor/ZF_ALU_OUT \
sim:/microprocessor/ALU_Result_New \
sim:/microprocessor/CF_MUX_OUT \
sim:/microprocessor/Reset_CF \
sim:/microprocessor/Reset_ZF \
sim:/microprocessor/Reset_NF \
sim:/microprocessor/Flags_Restor \
sim:/microprocessor/Register_WB_Add1 \
sim:/microprocessor/Call_IEMEM \
sim:/microprocessor/RET_IEMEM \
sim:/microprocessor/POP_IEMEM \
sim:/microprocessor/PUSH_IEMEM \
sim:/microprocessor/RTI_IEMEM \
sim:/microprocessor/Stack_operation_IEMEM \
sim:/microprocessor/WB_IEMEM \
sim:/microprocessor/MEM_IEMEM \
sim:/microprocessor/Write_Enable_IEMEM \
sim:/microprocessor/Interrupt_out_IEMEM \
sim:/microprocessor/Swap_Enable_IEMEM \
sim:/microprocessor/ALU_Result_IEMEM \
sim:/microprocessor/Rsrc1_Data_IEMEM \
sim:/microprocessor/Rsrc2_Data_IEMEM \
sim:/microprocessor/Reg_WB_Add11_IEMEM \
sim:/microprocessor/Reg_WB_Add12_IEMEM \
sim:/microprocessor/PC_OUT_IEMEM \
sim:/microprocessor/PC_Next_IEMEM \
sim:/microprocessor/BranchMUX_IEMEM \
sim:/microprocessor/Address_SCU \
sim:/microprocessor/SP \
sim:/microprocessor/DataMemory_address \
sim:/microprocessor/Jump_Selector \
sim:/microprocessor/Output_Interrupt_MUX \
sim:/microprocessor/Output_1st_Stage_MUX \
sim:/microprocessor/WriteData \
sim:/microprocessor/PUSH_OR_POP \
sim:/microprocessor/Data_Memory_Output \
sim:/microprocessor/M10 \
sim:/microprocessor/M32 \
sim:/microprocessor/Output_Stage_Jump_MUX \
sim:/microprocessor/Output_1st_Stage_Jump_MUX \
sim:/microprocessor/RET_OR_RTI \
sim:/microprocessor/Reset_and_Interrupt \
sim:/microprocessor/WB_MEMWB \
sim:/microprocessor/DataMemory_MEMWB \
sim:/microprocessor/ALU_Result_MEMWB \
sim:/microprocessor/SEL_MUX_A \
sim:/microprocessor/SEL_MUX_B \
sim:/microprocessor/Scrs_A \
sim:/microprocessor/Scrs_B
radix hex
force -freeze sim:/microprocessor/rst 1 0
force -freeze sim:/microprocessor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/microprocessor/Interrupt 0 0
force -freeze sim:/microprocessor/INPort 32'h0CDAFE19 0
run
force -freeze sim:/microprocessor/rst 0 0
run
force -freeze sim:/microprocessor/INPort 32'hFFFF 0
run
force -freeze sim:/microprocessor/INPort 32'hF320 0
run
run
run
run




