library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


Entity Microprocessor is
	port(
		   rst              : in  std_logic;
		   clk              : in  std_logic;
		   Interrupt        : in  STD_LOGIC;
		   INPort           : in  std_logic_vector(31 downto 0);
		   OUTPort          : out std_logic_vector(31 downto 0)
	    );
End Entity MicroProcessor;


Architecture arch_MicroProcessor Of MicroProcessor Is
  ----------------------------------------------------
    COMPONENT PC is 
      port (Clk          : in std_logic; 
            PC_In        : in std_logic_vector(31 downto 0);
            PC_Out       : out std_logic_vector(31 downto 0)
        );
    End COMPONENT; 
  ----------------------------------------------------
    COMPONENT InstructionMemory is
      port(
            PC_value        : in std_logic_vector(31 downto 0);
            Instruction_out : out std_logic_vector(31 downto 0)
          );
    End COMPONENT;
  ----------------------------------------------------
    COMPONENT PC_Plus1 is
      port( 
           PC: in std_logic_vector(31 downto 0);
           PcPlus1: out std_logic_vector(31 downto 0)
          );
    End COMPONENT;
  ----------------------------------------------------
    COMPONENT PC_Plus2 is
      port( 
           PC: in std_logic_vector(31 downto 0);
           PcPlus2: out std_logic_vector(31 downto 0)
          );
    End COMPONENT;
  ----------------------------------------------------
    COMPONENT IF_ID is
      port(
           rst,clk        :in std_logic;
           Instruction_in : in  std_logic_vector(31 downto 0);
           PC_in          : in  std_logic_vector(31 downto 0);
           PC_Plus_2_1_in : in  std_logic_vector(31 downto 0);
           OP_Code        : out std_logic_vector(1  downto 0);
           Function_Code  : out std_logic_vector(2  downto 0);
           Rscr1_Address  : out std_logic_vector(2  downto 0);
           Rscr2_Address  : out std_logic_vector(2  downto 0);
           Rdst_Address   : out std_logic_vector(2  downto 0);
           Imm_EA         : out std_logic_vector(19 downto 0);
           PC_out         : out std_logic_vector(31 downto 0);
           PC_Plus_2_1_out: out std_logic_vector(31 downto 0)
           );
    End COMPONENT; 
  ----------------------------------------------------  
    COMPONENT Mux2_1 is          ----32-bits 2 by 1 MUX 
      port(A,B :in std_logic_vector(31 downto 0);
           S   :in std_logic;
           Z   :out std_logic_vector(31 downto 0)
          );
    End COMPONENT;
  ----------------------------------------------------
    COMPONENT Mux2By1_3bits is    ----3-bits 2 by 1 MUX 
      port(A,B :in std_logic_vector(2 downto 0);
           S   :in std_logic;
           Z   :out std_logic_vector(2 downto 0)
          );
    End COMPONENT;
  ----------------------------------------------------
    COMPONENT Control is
      port(      ------input to control uint---------
           OP_Code              : in std_logic_vector(1  downto 0); 
           Function_Code        : in std_logic_vector(2  downto 0);
           Interrupt_in         : in std_logic;
           --Reset_in             : in std_logic;
               ------output of control uint---------
           Output_Enable        : out std_logic;                     
           Call                 : out std_logic;                     
           RET                  : out std_logic;                     
           POP                  : out std_logic;                     
           PUSH                 : out std_logic;                     
           RTI                  : out std_logic;                     
           Stack_operation      : out std_logic;                     
           JMP                  : out std_logic;                     
           JMP_ZF               : out std_logic;                     
           JMP_CF               : out std_logic;                     
           JMP_NF               : out std_logic;                     
           Reg_Dst_selector     : out std_logic;                     
           WB                   : out std_logic_vector(1  downto 0); 
           MEM                  : out std_logic_vector(1  downto 0); 
           EX                   : out std_logic_vector(3  downto 0); 
           Selector_set_carry   : out std_logic_vector(1  downto 0); 
           Write_Enable         : out std_logic;                     
           Regsrc2_Control      : out std_logic;                     
           Sign_Extend_Enable   : out std_logic_vector(1  downto 0); 
           Interrupt_out        : out std_logic;                     
           --Reset_out            : out std_logic;                     
           Swap_Enable          : out std_logic                      
          );
    End COMPONENT;
  ----------------------------------------------------    
    COMPONENT RegisterFile is
      port(rst,clk                :in std_logic;
           WriteEnable            :in std_logic;
           SwapEnable             :in std_logic;
           Rsrc1,Rsrc2            :in std_logic_vector(2 downto 0);   
           Rsrc1_Out,Rsrc2_Out    :out std_logic_vector(31 downto 0); 
           WriteData1,WriteData2  :in  std_logic_vector(31 downto 0); 
           WriteReg1,WriteReg2    :in std_logic_vector(2 downto 0)    
          );
    End COMPONENT;  
  ----------------------------------------------------    
    COMPONENT SignExtend is
      port(Enable     :in  std_logic_vector(1  downto 0); 
           IMM_EA_in  :in  std_logic_vector(19 downto 0);
           IMM_EA_out :out std_logic_vector(31 downto 0)
           );
    End COMPONENT;
  ----------------------------------------------------    
    COMPONENT Output_Register is
      port(rst,clk,en:in std_logic;
           datain    :in std_logic_vector(31 downto 0);
           dataout   :out std_logic_vector(31 downto 0)
           );
    End COMPONENT Output_Register;
  ----------------------------------------------------        
    COMPONENT ID_IE is
      port(rst,clk                :in std_logic;
                 -----in Port-----
           Call_in                : in std_logic;                    
           RET_in                 : in std_logic;                    
           POP_in                 : in std_logic;                    
           PUSH_in                : in std_logic;                    
           RTI_in                 : in std_logic;                    
           Stack_operation_in     : in std_logic;                    
           JMP_in                 : in std_logic;                    
           JMP_ZF_in              : in std_logic;                    
           JMP_CF_in              : in std_logic;                    
           JMP_NF_in              : in std_logic;                    
           Reg_Dst_selector_in    : in std_logic;                    
           WB_in                  : in std_logic_vector(1  downto 0);
           MEM_in                 : in std_logic_vector(1  downto 0);
           EX_in                  : in std_logic_vector(3  downto 0);
           Selector_set_carry_in  : in std_logic_vector(1  downto 0); 
           Write_Enable_in        : in std_logic;                     
           Regsrc2_Control_in     : in std_logic;                     
           Interrupt_in           : in std_logic;                     
           Swap_Enable_in         : in std_logic;
		       PC_in                  : in std_logic_vector(31 downto 0);
           PC_Plus_2_1_in         : in std_logic_vector(31 downto 0);
		       Rscr1_Address_in       : in std_logic_vector(2  downto 0);
           Rdst_Address_in        : in std_logic_vector(2  downto 0);
           Imm_EA_in              : in std_logic_vector(32 downto 0);
		       Rscr1_Data_in          : in std_logic_vector(31 downto 0);
		       Rscr2_Data_in          : in std_logic_vector(31 downto 0);
                      -----out Port-----
           Call_out               : out std_logic;                    
           RET_out                : out std_logic;                    
           POP_out                : out std_logic;                    
           PUSH_out               : out std_logic;                    
           RTI_out                : out std_logic;                    
           Stack_operation_out    : out std_logic;                    
           JMP_out                : out std_logic;                    
           JMP_ZF_out             : out std_logic;                    
           JMP_CF_out             : out std_logic;                    
           JMP_NF_out             : out std_logic;                    
           Reg_Dst_selector_out   : out std_logic;                    
           WB_out                 : out std_logic_vector(1  downto 0);
           MEM_out                : out std_logic_vector(1  downto 0);
           EX_out                 : out std_logic_vector(3  downto 0);
           Selector_set_carry_out : out std_logic_vector(1  downto 0); 
           Write_Enable_out       : out std_logic;                     
           Regsrc2_Control_out    : out std_logic;                     
           Interrupt_out          : out std_logic;                     
           Swap_Enable_out        : out std_logic;
		       PC_out                 : out std_logic_vector(31 downto 0);
           PC_Plus_2_1_out        : out std_logic_vector(31 downto 0);
	     	   Rscr1_Address_out      : out std_logic_vector(2  downto 0);
           Rdst_Address_out       : out std_logic_vector(2  downto 0);
           Imm_EA_out             : out std_logic_vector(32 downto 0);
	     	   Rscr1_Data_out         : out std_logic_vector(31 downto 0);
	     	   Rscr2_Data_out         : out std_logic_vector(31 downto 0)
          );
     End COMPONENT;
  ----------------------------------------------------  
     COMPONENT ALU IS
       PORT (Selectors : IN std_logic_vector(3 downto 0); 
	           Cin,Nin,Zin: IN std_logic;
             A,B: IN std_logic_vector(31 DOWNTO 0);
	           CF,NF,ZF: OUT std_logic;
             F: OUT std_logic_vector(31 DOWNTO 0));
     END COMPONENT;
  ----------------------------------------------------  
     COMPONENT Mux4By2_1bits is
       port(A,B,C :in  std_logic;
            S     :in  std_logic_vector (1 downto 0);
            Z     :out std_logic
            );
     End COMPONENT;     
  ----------------------------------------------------       
    COMPONENT CCR is
      port(rst,clk                      :in  std_logic;
           Cin,Nin,Zin                  :in  std_logic;
           Reset_CF,Reset_ZF,Reset_NF   :in  std_logic;
           RTI                          :in  std_logic;
           Flags_Restor                 :in  std_logic_vector (2 downto 0);
           Flags_out                    :out std_logic_vector (2 downto 0)
          );
    End COMPONENT;            
  ----------------------------------------------------       
    COMPONENT Preserved_CCR is
      port(rst,clk                      :in  std_logic;
           Interrupt                    :in  std_logic;
           RTI                          :in  std_logic;
           Flags_in                     :in  std_logic_vector (2 downto 0);
           Flags_Restor                 :out std_logic_vector (2 downto 0)
          );
    End COMPONENT;
 ----------------------------------------------------             
    COMPONENT IE_MEM is
      port(
           rst,clk               :in std_logic;
                 -----in Port-----
           Call_in                : in std_logic;                    
           RET_in                 : in std_logic;                    
           POP_in                 : in std_logic;                    
           PUSH_in                : in std_logic;                    
           RTI_in                 : in std_logic;                    
           Stack_operation_in     : in std_logic;                    
           JMP_in                 : in std_logic;                    
           JMP_ZF_in              : in std_logic;                    
           JMP_CF_in              : in std_logic;                    
           JMP_NF_in              : in std_logic;                                        
           WB_in                  : in std_logic_vector(1  downto 0);
           MEM_in                 : in std_logic_vector(1  downto 0);
           Write_Enable_in        : in std_logic;                                       
           Interrupt_in           : in std_logic;                                
           Swap_Enable_in         : in std_logic;
		       Flags_in	           			: in std_logic_vector(2 downto 0);
		       Result_ALU_in          : in std_logic_vector(31 downto 0);
		       Rsrc1_Value_in         : in std_logic_vector(31 downto 0);
		       Rsrc2_Value_in         : in std_logic_vector(31 downto 0);
		       Reg_WB_address_in      : in std_logic_vector(2 downto 0);
		       Rscr1_Address_in       : in std_logic_vector(2 downto 0);
		       PC_in                  : in std_logic_vector(31 downto 0);
           PC_Plus_2_1_in         : in std_logic_vector(31 downto 0);
                       -----out Port-----
           Call_out               : out std_logic;                    
           RET_out                : out std_logic;                    
           POP_out                : out std_logic;                    
           PUSH_out               : out std_logic;                    
           RTI_out                : out std_logic;                    
           Stack_operation_out    : out std_logic;                    
           JMP_out                : out std_logic;                    
           JMP_ZF_out             : out std_logic;                    
           JMP_CF_out             : out std_logic;                    
           JMP_NF_out             : out std_logic;                                      
           WB_out                 : out std_logic_vector(1  downto 0);
           MEM_out                : out std_logic_vector(1  downto 0);
           Write_Enable_out       : out std_logic;                                        
           Interrupt_out          : out std_logic;                                
           Swap_Enable_out        : out std_logic;
		       Flags_out				: out std_logic_vector(2 downto 0);
		       Result_ALU_out         : out std_logic_vector(31 downto 0);
		       Rsrc1_Value_out        : out std_logic_vector(31 downto 0);
		       Rsrc2_Value_out        : out std_logic_vector(31 downto 0);
		       Reg_WB_address_out     : out std_logic_vector(2 downto 0);
		       Rscr1_Address_out      : out std_logic_vector(2 downto 0);
		       PC_out                 : out std_logic_vector(31 downto 0);
           PC_Plus_2_1_out        : out std_logic_vector(31 downto 0)
          );
     End COMPONENT;
 ----------------------------------------------------                  
     COMPONENT Stack_CU is
       port(rst,clk                :in std_logic;
            Call_in                : in std_logic;                    
            RET_in                 : in std_logic;                    
            POP_in                 : in std_logic;                    
            PUSH_in                : in std_logic;                    
            RTI_in                 : in std_logic; 
            Interrupt_in           : in std_logic;
            SP_address             : out std_logic_vector(31 downto 0)
           );
     End COMPONENT;
 ----------------------------------------------------                  
     COMPONENT AND_2_Gate is
       Port ( INA1 : in  STD_LOGIC;    
              INA2 : in  STD_LOGIC;    
              OA   : out STD_LOGIC 
             );  
     End COMPONENT;     
 ---------------------------------------------------- 
    COMPONENT OR_5_Gate is
      Port ( INO1 : in  STD_LOGIC;  
             INO2 : in  STD_LOGIC;
             INO3 : in  STD_LOGIC;  
             INO4 : in  STD_LOGIC;  
             INO5 : in  STD_LOGIC;
             OO   : out  STD_LOGIC
            );  
    End COMPONENT;
 ---------------------------------------------------- 
    COMPONENT Mux4By2_32bits is  ---Mux 4 by 2 32bits
      port(A,B,C :in std_logic_vector(31 downto 0);
           S   :in std_logic_vector(1 downto 0);
           Z   :out std_logic_vector(31 downto 0)
          );
    End COMPONENT;
 ----------------------------------------------------     
    COMPONENT DataMemory is
      port(clk,ReadEnable,WriteEnable  : in std_logic;
           address                     : in std_logic_vector(31 downto 0);
           datain                      : in std_logic_vector(31 downto 0);
           dataout,M10,M32             : out std_logic_vector(31 downto 0)
          );
    End COMPONENT;
 ----------------------------------------------------     
    COMPONENT MEM_WB is
      port(rst,clk                :in std_logic;
                 -----in Port-----                             
           WB_in                  : in std_logic_vector(1  downto 0);
           Write_Enable_in        : in std_logic;                                                     
           Swap_Enable_in         : in std_logic;
        		 Data_MEM_in            : in std_logic_vector(31 downto 0);
        		 Reg_WB_address1_in     : in std_logic_vector(2 downto 0);
		       Result_ALU_in          : in std_logic_vector(31 downto 0);
		       Rscr1_Address_in       : in std_logic_vector(2 downto 0);
	       	 Rsrc2_Value_in         : in std_logic_vector(31 downto 0);
                      -----out Port-----                
           WB_out                 : out std_logic_vector(1  downto 0);
           Write_Enable_out       : out std_logic;                                                        
           Swap_Enable_out        : out std_logic;
	       	 Data_MEM_out           : out std_logic_vector(31 downto 0);
        		 Reg_WB_address1_out    : out std_logic_vector(2 downto 0);
        		 Result_ALU_out         : out std_logic_vector(31 downto 0);
	       	 Reg_WB_address2_out    : out std_logic_vector(2 downto 0);
	       	 Reg_WB_Value_2         : out std_logic_vector(31 downto 0)
          );
     End COMPONENT;
 ----------------------------------------------------     
 -----------------------SIGNALS----------------------
 
 ----***Program Counter***----
 SIGNAL PC_IN    :std_logic_vector(31 downto 0);  
 SIGNAL PC_OUT   :std_logic_vector(31 downto 0);
 Program_Counter : PC port map (clk,PC_IN,PC_OUT);   

 ----***Instruction Memory***----
 SIGNAL Instruction     :std_logic_vector(31 downto 0);
 Instruction_Memory     :InstructionMemory port map(PC_OUT,Instruction);  
 
 ----***2 Adders for PC***----
 SIGNAL PC_Plus1 :std_logic_vector(31 downto 0);
 SIGNAL PC_Plus2 :std_logic_vector(31 downto 0);
 Add_1_to_PC     : PC_Plus1 port map (PC_OUT,PC_Plus1);
 Add_2_to_PC     : PC_Plus2 port map (PC_OUT,PC_Plus2);

 ----***MUX for adders***---- 
 SIGNAL PC_Next :std_logic_vector(31 downto 0);
 Next_PC        : Mux2_1 port map (PC_Plus1,PC_Plus2,Instruction_out(0),PC_Next);
 
 ----***IF_ID***----
 SIGNAL OP_Code        : std_logic_vector(1  downto 0);
 SIGNAL Function_Code  : std_logic_vector(2  downto 0);
 SIGNAL Rscr1_Address  : std_logic_vector(2  downto 0);
 SIGNAL Rscr2_Address  : std_logic_vector(2  downto 0);
 SIGNAL Rdst_Address   : std_logic_vector(2  downto 0);
 SIGNAL Imm_EA         : std_logic_vector(19 downto 0);
 SIGNAL PC_Next_IFID   : std_logic_vector(31 downto 0);
 SIGNAL PC_OUT_IFID    : std_logic_vector(31 downto 0);
 IFID                  : IF_ID port map (rst,clk,Instruction,PC_OUT,PC_Next,OP_Code,Function_Code,Rscr1_Address,Rscr2_Address,Rdst_Address,Imm_EA,PC_OUT_IFID,PC_Next_IFID);
 
  ----***Control unit***----
  SIGNAL   Output_Enable        :  std_logic;                     
  SIGNAL   Call                 :  std_logic;                     
  SIGNAL   RET                  :  std_logic;                     
  SIGNAL   POP                  :  std_logic;                     
  SIGNAL   PUSH                 :  std_logic;                     
  SIGNAL   RTI                  :  std_logic;                     
  SIGNAL   Stack_operation      :  std_logic;                     
  SIGNAL   JMP                  :  std_logic;                     
  SIGNAL   JMP_ZF               :  std_logic;                     
  SIGNAL   JMP_CF               :  std_logic;                     
  SIGNAL   JMP_NF               :  std_logic;                     
  SIGNAL   Reg_Dst_selector     :  std_logic;                     
  SIGNAL   WB                   :  std_logic_vector(1  downto 0); 
  SIGNAL   MEM                  :  std_logic_vector(1  downto 0); 
  SIGNAL   EX                   :  std_logic_vector(3  downto 0); 
  SIGNAL   Selector_set_carry   :  std_logic_vector(1  downto 0); 
  SIGNAL   Write_Enable         :  std_logic;                     
  SIGNAL   Regsrc2_Control      :  std_logic;                     
  SIGNAL   Sign_Extend_Enable   :  std_logic_vector(1  downto 0); 
  SIGNAL   Interrupt_out        :  std_logic;                                        
  SIGNAL   Swap_Enable          :  std_logic;                      

  Control_unit : Control port map (OP_Code,Function_Code,Interrupt,rst,Output_Enable,Call,RET,POP,PUSH,RTI,Stack_operation,JMP,JMP_ZF,JMP_CF,JMP_NF,Reg_Dst_selector,WB,MEM,EX,Selector_set_carry,Write_Enable,Regsrc2_Control,Sign_Extend_Enable,Interrupt_out,Swap_Enable);
  ----***Mux 2 by 1 3bits***----
  SIGNAL Scr2_Address  : std_logic_vector(2  downto 0);
  MUX_Scrs2 : Mux2By1_3bits port map (Rscr2_Address,Rdst_Address,Swap_Enable,Scr2_Address);

  ----***Register File***----
  SIGNAL Write_Enable_WB           : std_logic;
  SIGNAL Swap_Enable_WB            : std_logic;
  SIGNAL Rsrc1_Data,Rsrc2_Data     : std_logic_vector(31 downto 0); 
  SIGNAL Reg_WB_Data1,Reg_WB_Data2 : std_logic_vector(31 downto 0); 
  SIGNAL Reg_WB_Addr1,Reg_WB_Addr2 : std_logic_vector(2 downto 0); 
  Register_File : RegisterFile port map (rst,clk,Write_Enable_WB,Swap_Enable_WB,Rscr1_Address,Scr2_Address,Rsrc1_Data,Rsrc2_Data,Reg_WB_Data1,Reg_WB_Data2,Reg_WB_Addr1,Reg_WB_Addr2);
  
  ----***Sign Extend***----
  SIGNAL IMM_EA_out : std_logic_vector(31 downto 0); 
  Sign_Extend : SignExtend port map (Sign_Extend_Enable,Imm_EA,IMM_EA_out);    
  
  ----***Output Register***----
  OutputRegister : Output_Register port map (rst,clk,Output_Enable,Rsrc1_Data,OUTPort);
  
  ----***ID_IE***----
  SIGNAL   Call_IDIE                 :  std_logic;                     
  SIGNAL   RET_IDIE                  :  std_logic;                     
  SIGNAL   POP_IDIE                  :  std_logic;                     
  SIGNAL   PUSH_IDIE                 :  std_logic;                     
  SIGNAL   RTI_IDIE                  :  std_logic;                     
  SIGNAL   Stack_operation_IDIE      :  std_logic;                     
  SIGNAL   JMP_IDIE                  :  std_logic;                     
  SIGNAL   JMP_ZF_IDIE               :  std_logic;                     
  SIGNAL   JMP_CF_IDIE               :  std_logic;                     
  SIGNAL   JMP_NF_IDIE               :  std_logic;                     
  SIGNAL   Reg_Dst_selector_IDIE     :  std_logic;                     
  SIGNAL   WB_IDIE                   :  std_logic_vector(1  downto 0); 
  SIGNAL   MEM_IDIE                  :  std_logic_vector(1  downto 0); 
  SIGNAL   EX_IDIE                   :  std_logic_vector(3  downto 0); 
  SIGNAL   Selector_set_carry_IDIE   :  std_logic_vector(1  downto 0); 
  SIGNAL   Write_Enable_IDIE         :  std_logic;                     
  SIGNAL   Regsrc2_Control_IDIE      :  std_logic;                     
  SIGNAL   Interrupt_out_IDIE        :  std_logic;                                        
  SIGNAL   Swap_Enable_IDIE          :  std_logic;                      
  SIGNAL   PC_OUT_IDIE,PC_Next_IDIE  :  std_logic_vector(31  downto 0); 
  SIGNAL   Rscr1_AddressIDIE         :  std_logic_vector(31  downto 0); 
  SIGNAL   Rdst_AddressIDIE          :  std_logic_vector(31  downto 0); 
  SIGNAL   IMM_EA_IDIE               :  std_logic_vector(31  downto 0); 
  SIGNAL   Rsrc1_Data_IDIE           : std_logic_vector(31 downto 0); 
  SIGNAL   Rsrc2_Data_IDIE           : std_logic_vector(31 downto 0); 
  IDIE : ID_IE port map (rst,clk,Call,RET,POP,PUSH,RTI,Stack_operation,JMP,JMP_ZF,JMP_CF,JMP_NF,Reg_Dst_selector,WB,MEM,EX,Selector_set_carry,Write_Enable,Regsrc2_Control,Interrupt_out,Swap_Enable,
                         PC_OUT_IFID,PC_Next_IFID,Rscr1_Address,Rdst_Address,IMM_EA_out,Rsrc1_Data,Rsrc2_Data,Call_IDIE,RET_IDIE,POP_IDIE,PUSH_IDIE,RTI_IDIE,Stack_operation_IDIE,JMP_IDIE,
                         JMP_ZF_IDIE,JMP_CF_IDIE,JMP_NF_IDIE,Reg_Dst_selector_IDIE,WB_IDIE,MEM_IDIE,EX_IDIE,Selector_set_carry_IDIE,Write_Enable_IDIE,Regsrc2_Control_IDIE,Interrupt_out_IDIE,
                         Swap_Enable_IDIE,PC_OUT_IDIE,PC_Next_IDIE,Rscr1_AddressIDIE,Rdst_AddressIDIE,IMM_EA_IDIE,Rsrc1_Data_IDIE,Rsrc2_Data_IDIE);
  

    
  
  
  
  
  
  
    
  BEGIN
 -----------------------Instantiation----------------------  
 ----***Program Counter***---- 
       
End arch_MicroProcessor;     

