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
            StallEn      :in std_logic;
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
           FlushEn        :in std_logic;
           StallEn        :in std_logic;
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
           PC_Plus_2_1_out: out std_logic_vector(31 downto 0);
           IN_Port_IN     : in std_logic_vector(31 downto 0);
     	     IN_Port_out    : out std_logic_vector(31 downto 0)
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
           ALU_Enable           : out std_logic; 
           CCR_Enable           : out std_logic;
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
           Input_Enable         : out std_logic;                     
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
           WriteReg1,WriteReg2    :in std_logic_vector(2 downto 0);
           R0,R1,R2,R3,R4,R5,R6,R7:out std_logic_vector(31 downto 0)    
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
           FlushEn                :in std_logic;
                 -----in Port-----
           ALU_Enable_in          : in std_logic;
           CCR_Enable_in          : in std_logic;
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
		       Scr2_Address_in        : in std_logic_vector(2  downto 0);
           Rdst_Address_in        : in std_logic_vector(2  downto 0);
           Imm_EA_in              : in std_logic_vector(31 downto 0);
		       Rscr1_Data_in          : in std_logic_vector(31 downto 0);
		       Rscr2_Data_in          : in std_logic_vector(31 downto 0);
                      -----out Port-----
           ALU_Enable_out         : out std_logic;
           CCR_Enable_out         : out std_logic; 
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
	     	   Rscr2_Address_out      : out std_logic_vector(2  downto 0);
           Rdst_Address_out       : out std_logic_vector(2  downto 0);
           Imm_EA_out             : out std_logic_vector(31 downto 0);
	     	   Rscr1_Data_out         : out std_logic_vector(31 downto 0);
	     	   Rscr2_Data_out         : out std_logic_vector(31 downto 0);
	     	   IN_Port_IN             : in std_logic_vector(31 downto 0);
	         IN_Port_out            : out std_logic_vector(31 downto 0);
	         OutputPortEnable_IN    : in std_logic;
	         OutputPortEnable_out   : out std_logic;
	         InputPortEnable_IN     : in std_logic;
   	       InputPortEnable_out    : out std_logic
          );
     End COMPONENT;
  ----------------------------------------------------  
     COMPONENT ALU IS
       PORT (Selectors : IN std_logic_vector(3 downto 0); 
	           Cin,Nin,Zin: IN std_logic;
             A,B: IN std_logic_vector(31 DOWNTO 0);
	           CF,NF,ZF: OUT std_logic;
             F: OUT std_logic_vector(31 DOWNTO 0);
             Enable:IN std_logic);
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
           Flags_out                    :out std_logic_vector (2 downto 0);
           Enable                       :IN std_logic
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
  --       JMP_in                 : in std_logic;                    
  --       JMP_ZF_in              : in std_logic;                    
  --       JMP_CF_in              : in std_logic;                    
  --       JMP_NF_in              : in std_logic;                                        
           WB_in                  : in std_logic_vector(1  downto 0);
           MEM_in                 : in std_logic_vector(1  downto 0);
           Write_Enable_in        : in std_logic;                                       
           Interrupt_in           : in std_logic;                                
           Swap_Enable_in         : in std_logic;
	--       Flags_in	           			: in std_logic_vector(2 downto 0);
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
  --       JMP_out                : out std_logic;                    
  --       JMP_ZF_out             : out std_logic;                    
  --       JMP_CF_out             : out std_logic;                    
  --       JMP_NF_out             : out std_logic;                                      
           WB_out                 : out std_logic_vector(1  downto 0);
           MEM_out                : out std_logic_vector(1  downto 0);
           Write_Enable_out       : out std_logic;                                        
           Interrupt_out          : out std_logic;                                
           Swap_Enable_out        : out std_logic;
	--       Flags_out		          		: out std_logic_vector(2 downto 0);
		       Result_ALU_out         : out std_logic_vector(31 downto 0);
		       Rsrc1_Value_out        : out std_logic_vector(31 downto 0);
		       Rsrc2_Value_out        : out std_logic_vector(31 downto 0);
		       Reg_WB_address1_out    : out std_logic_vector(2 downto 0);
		       Reg_WB_address2_out    : out std_logic_vector(2 downto 0);
		       PC_out                 : out std_logic_vector(31 downto 0);
           PC_Plus_2_1_out        : out std_logic_vector(31 downto 0);
          -- IN_Port_IN             : in std_logic_vector(31 downto 0);
     	   --  IN_Port_out            : out std_logic_vector(31 downto 0);
     	     BranchMUX_IN           : in std_logic_vector(31 downto 0);
	         BranchMUX_out          : out std_logic_vector(31 downto 0)
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
      port(--clk,
           ReadEnable,WriteEnable      : in std_logic;
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
	       	 --IN_Port_IN             : in std_logic_vector(31 downto 0);
     	     --IN_Port_out            : out std_logic_vector(31 downto 0)
          );
     End COMPONENT;
 ----------------------------------------------------     
    COMPONENT FU IS
	     PORT (Rsrc1, Rsrc2: IN std_logic_vector(2 DOWNTO 0);
		         ExMemRdst1,ExMemRdst2: IN std_logic_vector(2 DOWNTO 0);
		         MemWbRdst1,MemWbRdst2: IN std_logic_vector(2 DOWNTO 0);
		         SELA: OUT std_logic_vector(2 DOWNTO 0);
       		    SELB: OUT std_logic_vector(2 DOWNTO 0);
		         ExMemSwapEn: IN std_logic;
       		    ExMemWbEn, MemWbWbEn: IN std_logic;
	           MemWbSwapEn: IN std_logic);
        END COMPONENT;
 ----------------------------------------------------         
    COMPONENT Mux5By3_32bits is
      port(A,B,C,D,E :in std_logic_vector(31 downto 0);
           S   :in std_logic_vector(2 downto 0);
           Z   :out std_logic_vector(31 downto 0)
          );
      End COMPONENT;
 ----------------------------------------------------         
    COMPONENT HDU IS
	     PORT (	IdExMemRead: IN std_logic;
		          IdExRdst1,IfIdRsrc1,IfIdRsrc2: IN std_logic_vector(2 DOWNTO 0);
			        Stall: OUT std_logic
			      );
       END COMPONENT;
 ----------------------------------------------------  
   COMPONENT MuxStall is
    port(ALU_Enable_in           : in std_logic;                       
         CCR_Enable_in           : in std_logic;                     
         Output_Enable_in        : in std_logic;                     
         Call_in                 : in std_logic;                     
         RET_in                  : in std_logic;                     
         POP_in                  : in std_logic;                     
         PUSH_in                 : in std_logic;                     
         RTI_in                  : in std_logic;                     
         Stack_operation_in      : in std_logic;                     
         JMP_in                  : in std_logic;                     
         JMP_ZF_in               : in std_logic;                     
         JMP_CF_in               : in std_logic;                     
         JMP_NF_in               : in std_logic;                     
         Reg_Dst_selector_in     : in std_logic;                     
         WB_in                   : in std_logic_vector(1  downto 0); 
         MEM_in                  : in std_logic_vector(1  downto 0); 
         EX_in                   : in std_logic_vector(3  downto 0); 
         Selector_set_carry_in   : in std_logic_vector(1  downto 0); 
         Write_Enable_in         : in std_logic;                     
         Regsrc2_Control_in      : in std_logic;                     
         Sign_Extend_Enable_in   : in std_logic_vector(1  downto 0); 
         Interrupt_out_in        : in std_logic;                     
         Input_Enable_in         : in std_logic;                     
         Swap_Enable_in          : in std_logic;                     
         
         -----outputs---------------------------------------------------------
         ALU_Enable_out           : out std_logic;                     
         CCR_Enable_out           : out std_logic;                     
         Output_Enable_out        : out std_logic;                     
         Call_out                 : out std_logic;                     
         RET_out                  : out std_logic;                     
         POP_out                  : out std_logic;                     
         PUSH_out                 : out std_logic;                     
         RTI_out                  : out std_logic;                     
         Stack_operation_out      : out std_logic;                     
         JMP_out                  : out std_logic;                     
         JMP_ZF_out               : out std_logic;                     
         JMP_CF_out               : out std_logic;                     
         JMP_NF_out               : out std_logic;                     
         Reg_Dst_selector_out     : out std_logic;                     
         WB_out                   : out std_logic_vector(1  downto 0); 
         MEM_out                  : out std_logic_vector(1  downto 0); 
         EX_out                   : out std_logic_vector(3  downto 0); 
         Selector_set_carry_out   : out std_logic_vector(1  downto 0); 
         Write_Enable_out         : out std_logic;                     
         Regsrc2_Control_out      : out std_logic;                     
         Sign_Extend_Enable_out   : out std_logic_vector(1  downto 0); 
         Interrupt_out_out        : out std_logic;                     
         Input_Enable_out         : out std_logic;                     
         Swap_Enable_out          : out std_logic;                      
         Selector                 :in  std_logic
         );
  End COMPONENT;
 --**********************************************************************************************************************  
                              -----------------------SIGNALS----------------------
 --**********************************************************************************************************************
 
 ----***Program Counter***----
 SIGNAL PC_IN    :std_logic_vector(31 downto 0);  
 SIGNAL PC_OUT   :std_logic_vector(31 downto 0);
 

 ----***Instruction Memory***----
 SIGNAL Instruction     :std_logic_vector(31 downto 0);
 
 
 ----***2 Adders for PC***----
 SIGNAL PC_Plus_1 :std_logic_vector(31 downto 0);
 SIGNAL PC_Plus_2 :std_logic_vector(31 downto 0);
 
 ----***MUX for adders***---- 
 SIGNAL PC_Next :std_logic_vector(31 downto 0);
 
 
 ----***IF_ID***----
 SIGNAL OP_Code        : std_logic_vector(1  downto 0);
 SIGNAL Function_Code  : std_logic_vector(2  downto 0);
 SIGNAL Rscr1_Address  : std_logic_vector(2  downto 0);
 SIGNAL Rscr2_Address  : std_logic_vector(2  downto 0);
 SIGNAL Rdst_Address   : std_logic_vector(2  downto 0);
 SIGNAL Imm_EA         : std_logic_vector(19 downto 0);
 SIGNAL PC_Next_IFID   : std_logic_vector(31 downto 0);
 SIGNAL PC_OUT_IFID    : std_logic_vector(31 downto 0);
 SIGNAL IN_Port_IFID   : std_logic_vector(31 downto 0);
 
  ----***Control unit***----
  SIGNAL   ALU_Enable           :  std_logic;  
  SIGNAL   CCR_Enable           :  std_logic;       
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
  SIGNAL   Input_Enable         :  std_logic;                       
  
  ----***Hazard Uint***----
  SIGNAL Stall :std_logic;
 
 ----***MUX Stall***----
  SIGNAL   ALU_Enable_Stall           :  std_logic;  
  SIGNAL   CCR_Enable_Stall           :  std_logic;       
  SIGNAL   Output_Enable_Stall        :  std_logic;                     
  SIGNAL   Call_Stall                 :  std_logic;                     
  SIGNAL   RET_Stall                  :  std_logic;                     
  SIGNAL   POP_Stall                  :  std_logic;                     
  SIGNAL   PUSH_Stall                 :  std_logic;                     
  SIGNAL   RTI_Stall                  :  std_logic;                     
  SIGNAL   Stack_operation_Stall      :  std_logic;                     
  SIGNAL   JMP_Stall                  :  std_logic;                     
  SIGNAL   JMP_ZF_Stall               :  std_logic;                     
  SIGNAL   JMP_CF_Stall               :  std_logic;                     
  SIGNAL   JMP_NF_Stall               :  std_logic;                     
  SIGNAL   Reg_Dst_selector_Stall     :  std_logic;                     
  SIGNAL   WB_Stall                   :  std_logic_vector(1  downto 0); 
  SIGNAL   MEM_Stall                  :  std_logic_vector(1  downto 0); 
  SIGNAL   EX_Stall                   :  std_logic_vector(3  downto 0); 
  SIGNAL   Selector_set_carry_Stall   :  std_logic_vector(1  downto 0); 
  SIGNAL   Write_Enable_Stall         :  std_logic;                     
  SIGNAL   Regsrc2_Control_Stall      :  std_logic;                     
  SIGNAL   Sign_Extend_Enable_Stall   :  std_logic_vector(1  downto 0); 
  SIGNAL   Interrupt_out_Stall        :  std_logic;                                        
  SIGNAL   Swap_Enable_Stall          :  std_logic;  
  SIGNAL   Input_Enable_Stall         :  std_logic; 
 
  ----***Mux 2 by 1 3bits***----
  SIGNAL Scr2_Address  : std_logic_vector(2  downto 0);


  ----***Register File***----
  SIGNAL Write_Enable_WB           : std_logic;
  SIGNAL Swap_Enable_WB            : std_logic;
  SIGNAL Rsrc1_Data,Rsrc2_Data     : std_logic_vector(31 downto 0); 
  SIGNAL Reg_WB_Data1,Reg_WB_Data2 : std_logic_vector(31 downto 0); 
  SIGNAL Reg_WB_Addr1,Reg_WB_Addr2 : std_logic_vector(2 downto 0); 
  SIGNAL R0,R1,R2,R3,R4,R5,R6,R7   : std_logic_vector(31 downto 0);
  
  ----***Sign Extend***----
  SIGNAL IMM_EA_out : std_logic_vector(31 downto 0); 

  
  
  ----***ID_IE***----
  SIGNAL   ALU_Enable_IDIE           :  std_logic;  
  SIGNAL   CCR_Enable_IDIE           :  std_logic;
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
  SIGNAL   Rscr1_AddressIDIE         :  std_logic_vector(2  downto 0); 
  SIGNAL   Rscr2_AddressIDIE         :  std_logic_vector(2  downto 0); 
  SIGNAL   Rdst_AddressIDIE          :  std_logic_vector(2  downto 0); 
  SIGNAL   IMM_EA_IDIE               :  std_logic_vector(31  downto 0); 
  SIGNAL   Rsrc1_Data_IDIE           : std_logic_vector(31 downto 0); 
  SIGNAL   Rsrc2_Data_IDIE           : std_logic_vector(31 downto 0); 
  SIGNAL   IN_Port_IDIE              : std_logic_vector(31 downto 0);
  SIGNAL   OutputPortEnable_IDIE     : std_logic;
  SIGNAL   InputPortEnable_IDIE      : std_logic;
  
  ----***MUX 2 by 1 32bit Srcs 2 destination of ALU***----  
  SIGNAL  Src2_Data_ALU  : std_logic_vector(31 downto 0); 

  
  ----***ALU unit***----
  SIGNAL  Flags_out_CCR                      : std_logic_vector(2 downto 0);
  SIGNAL  ALU_Result                         : std_logic_vector(31 downto 0);  
  SIGNAL  CF_ALU_OUT,NF_ALU_OUT,ZF_ALU_OUT   : std_logic;

  ----***MUX 2 by 1 32bit value of ALU result***---- 
  SIGNAL ALU_Result_New : std_logic_vector(31 downto 0);  
  ----***Carry MUX***----
  SIGNAL  CF_MUX_OUT   : std_logic;      

  
  ----***Condition Code Register***----
  SIGNAL Reset_CF,Reset_ZF,Reset_NF   :  std_logic;
  SIGNAL Flags_Restor                 : std_logic_vector(2 downto 0);

  
  
  ----*** MUX Register Writeback Address 1***---- 
  SIGNAL Register_WB_Add1 : std_logic_vector(2 downto 0);

  
  ----***IE_MEM***----
  SIGNAL   Call_IEMEM                 :  std_logic;                     
  SIGNAL   RET_IEMEM                  :  std_logic;                     
  SIGNAL   POP_IEMEM                  :  std_logic;                     
  SIGNAL   PUSH_IEMEM                 :  std_logic;                     
  SIGNAL   RTI_IEMEM                  :  std_logic;                     
  SIGNAL   Stack_operation_IEMEM      :  std_logic;                     
--SIGNAL   JMP_IEMEM                  :  std_logic;                     
--SIGNAL   JMP_ZF_IEMEM               :  std_logic;                     
--SIGNAL   JMP_CF_IEMEM               :  std_logic;                     
--SIGNAL   JMP_NF_IEMEM               :  std_logic; 
  SIGNAL   WB_IEMEM                   :  std_logic_vector(1  downto 0); 
  SIGNAL   MEM_IEMEM                  :  std_logic_vector(1  downto 0); ---MEM(1)=> ReadEnable ,MEM(0)=> WriteEnable
  SIGNAL   Write_Enable_IEMEM         :  std_logic;  
  SIGNAL   Interrupt_out_IEMEM        :  std_logic;                                        
  SIGNAL   Swap_Enable_IEMEM          :  std_logic;
--SIGNAL   Flags_out_IEMEM            : std_logic_vector(2 downto 0);   ---flag(2) = CF , flag(1) = ZF ,flag(0) = NF 
  SIGNAL   ALU_Result_IEMEM           : std_logic_vector(31 downto 0);  
  SIGNAL   Rsrc1_Data_IEMEM           : std_logic_vector(31 downto 0); 
  SIGNAL   Rsrc2_Data_IEMEM           : std_logic_vector(31 downto 0);
  SIGNAL   Reg_WB_Add11_IEMEM         : std_logic_vector(2  downto 0);
  SIGNAL   Reg_WB_Add12_IEMEM         :  std_logic_vector(2  downto 0);
  SIGNAL   PC_OUT_IEMEM,PC_Next_IEMEM :  std_logic_vector(31  downto 0);                                                  
--SIGNAL   IN_Port_IEMEM              : std_logic_vector(31 downto 0);
  SIGNAL   BranchMUX_IEMEM            : std_logic_vector(31 downto 0);
  
  ----***Stack Control unit***----
  SIGNAL  SP_address :  std_logic_vector(31  downto 0);                                                  


  ----***MUX Address of Data Memory***----
  SIGNAL  DataMemory_address :  std_logic_vector(31  downto 0);                                                    

  
  ----***Jumps AND Gates + OR Gates***---- 
  SIGNAL Jump_Selector : std_logic;                                                  


  ----***MUX Interrupt***---- 
  SIGNAL  Output_Interrupt_MUX :  std_logic_vector(31  downto 0);                                                    

  
  ----***MUX 1st stage WriteData***----
  SIGNAL  Output_1st_Stage_MUX :  std_logic_vector(31  downto 0);

  
  ----***MUX 2nd stage WriteData***----
  SIGNAL  WriteData   :  std_logic_vector(31  downto 0);
  SIGNAL  PUSH_OR_POP :    std_logic; ------- PUSH or POP in IE_MEM


  ----***Data Memory***----    
  SIGNAL  Data_Memory_Output   :  std_logic_vector(31  downto 0);
  SIGNAL  M10,M32              :  std_logic_vector(31  downto 0);  

    
  ----***MUX Stage Jump***----
  SIGNAL  Output_Stage_Jump_MUX :  std_logic_vector(31  downto 0);

  
  ----***MUX 1st Stage Jump***----
  SIGNAL  Output_1st_Stage_Jump_MUX :  std_logic_vector(31  downto 0);
  SIGNAL  RET_OR_RTI                :  std_logic; ------- RET or RTI in IE_MEM

  
  ----***MUX 3rd Stage Jump***----
  SIGNAL  Reset_and_Interrupt    :  std_logic_vector (1 downto 0); ------- Reset and Interrupt_out_IEMEM i.e: (reset,Interrupt_out_IEMEM)

  
  ----***MEM_WB***----
  SIGNAL  WB_MEMWB          :  std_logic_vector(1  downto 0);
  SIGNAL  DataMemory_MEMWB  :  std_logic_vector(31  downto 0);
  SIGNAL  ALU_Result_MEMWB  : std_logic_vector(31 downto 0);   
--SIGNAL  IN_Port_MEMWB     : std_logic_vector(31 downto 0);
  

 ----***Forward Uint***----
 SIGNAL SEL_MUX_A    :std_logic_vector(2 downto 0);  
 SIGNAL SEL_MUX_B    :std_logic_vector(2 downto 0); 

 ----***MUX-A***----
 SIGNAL Scrs_A    :std_logic_vector(31 downto 0);  
 
  ----***MUX-B***----
 SIGNAL Scrs_B    :std_logic_vector(31 downto 0);    

  
  
  BEGIN
        PUSH_OR_POP           <= PUSH_IEMEM or POP_IEMEM;           -- selector of the MUX 2nd stage WriteData
        RET_OR_RTI            <= RET_IEMEM  or RTI_IEMEM;           -- selector of the MUX 2nd Stage Jump
        Reset_and_Interrupt   <= rst        &  Interrupt_out_IEMEM; -- selector of the MUX 2nd Stage Jump
  
  --**********************************************************************************************************************  
                              -----------------------Instantiation----------------------
  --**********************************************************************************************************************
  
   ----***Program Counter***----
 Program_Counter : PC port map (clk,Stall,PC_IN,PC_OUT);   

 ----***Instruction Memory***----
 Instruction_Memory     :InstructionMemory port map(PC_OUT,Instruction);  
 
 ----***2 Adders for PC***----
 Add_1_to_PC     : PC_Plus1 port map (PC_OUT,PC_Plus_1);
 Add_2_to_PC     : PC_Plus2 port map (PC_OUT,PC_Plus_2);

 ----***MUX for adders***---- 
 Next_PC        : Mux2_1 port map (PC_Plus_1,PC_Plus_2,Instruction(0),PC_Next);
 
 ----***IF_ID***----
 IFID                  : IF_ID port map (rst,clk,Jump_Selector,Stall,Instruction,PC_OUT,PC_Next,OP_Code,Function_Code,Rscr1_Address,Rscr2_Address,Rdst_Address,Imm_EA,PC_OUT_IFID,PC_Next_IFID,INPort,IN_Port_IFID);
 
  ----***Control unit***----
  Control_unit : Control port map (OP_Code,Function_Code,Interrupt,ALU_Enable,CCR_Enable,Output_Enable,Call,RET,POP,PUSH,RTI,Stack_operation,JMP,JMP_ZF,JMP_CF,JMP_NF,Reg_Dst_selector,WB,MEM,EX,Selector_set_carry,Write_Enable,Regsrc2_Control,Sign_Extend_Enable,Interrupt_out,Input_Enable,Swap_Enable);
  
  ----***Hazard Uint***----
  Hazard_Uint : HDU port map (MEM_IDIE(1),Rscr1_AddressIDIE,Rscr1_Address,Scr2_Address,Stall);
  
  ----***MUX Stall***----
  MUX_Stall: MuxStall port map (ALU_Enable,CCR_Enable,Output_Enable,Call,RET,POP,PUSH,RTI,Stack_operation,JMP,JMP_ZF,JMP_CF,JMP_NF,Reg_Dst_selector,WB,MEM,EX,Selector_set_carry,Write_Enable,Regsrc2_Control,Sign_Extend_Enable,Interrupt_out,Input_Enable,Swap_Enable,
                                ALU_Enable_Stall,CCR_Enable_Stall,Output_Enable_Stall,Call_Stall,RET_Stall,POP_Stall,PUSH_Stall,RTI_Stall,Stack_operation_Stall,JMP_Stall,JMP_ZF_Stall,JMP_CF_Stall,JMP_NF_Stall,Reg_Dst_selector_Stall,WB_Stall,MEM_Stall,
                              EX_Stall,Selector_set_carry_Stall,Write_Enable_Stall,Regsrc2_Control_Stall,Sign_Extend_Enable_Stall,Interrupt_out_Stall,Input_Enable_Stall,Swap_Enable_Stall,Stall);
  
  ----***Mux 2 by 1 3bits***----
  MUX_Scrs2 : Mux2By1_3bits port map (Rscr2_Address,Rdst_Address,Swap_Enable,Scr2_Address);

  ----***Register File***----
  Register_File : RegisterFile port map (rst,clk,Write_Enable_WB,Swap_Enable_WB,Rscr1_Address,Scr2_Address,Rsrc1_Data,Rsrc2_Data,Reg_WB_Data1,Reg_WB_Data2,Reg_WB_Addr1,Reg_WB_Addr2,R0,R1,R2,R3,R4,R5,R6,R7);
  
  ----***Sign Extend***----
  Sign_Extend : SignExtend port map (Sign_Extend_Enable,Imm_EA,IMM_EA_out);    
  
  ----***Output Register***----
  OutputRegister : Output_Register port map (rst,clk,OutputPortEnable_IDIE,Scrs_A,OUTPort);
  
  ----***ID_IE***----
  IDIE : ID_IE port map (rst,clk,Jump_Selector,ALU_Enable_Stall,CCR_Enable_Stall,Call_Stall,RET_Stall,POP_Stall,PUSH_Stall,RTI_Stall,Stack_operation_Stall,JMP_Stall,JMP_ZF_Stall,JMP_CF_Stall,JMP_NF_Stall,Reg_Dst_selector_Stall,WB_Stall,MEM_Stall,EX_Stall,Selector_set_carry_Stall,Write_Enable_Stall,Regsrc2_Control_Stall,Interrupt_out_Stall,Swap_Enable_Stall,
                         PC_OUT_IFID,PC_Next_IFID,Rscr1_Address,Scr2_Address,Rdst_Address,IMM_EA_out,Rsrc1_Data,Rsrc2_Data,ALU_Enable_IDIE,CCR_Enable_IDIE,Call_IDIE,RET_IDIE,POP_IDIE,PUSH_IDIE,RTI_IDIE,Stack_operation_IDIE,JMP_IDIE,
                         JMP_ZF_IDIE,JMP_CF_IDIE,JMP_NF_IDIE,Reg_Dst_selector_IDIE,WB_IDIE,MEM_IDIE,EX_IDIE,Selector_set_carry_IDIE,Write_Enable_IDIE,Regsrc2_Control_IDIE,Interrupt_out_IDIE,
                         Swap_Enable_IDIE,PC_OUT_IDIE,PC_Next_IDIE,Rscr1_AddressIDIE,Rscr2_AddressIDIE,Rdst_AddressIDIE,IMM_EA_IDIE,Rsrc1_Data_IDIE,Rsrc2_Data_IDIE,IN_Port_IFID,IN_Port_IDIE,Output_Enable_Stall,OutputPortEnable_IDIE,Input_Enable_Stall,InputPortEnable_IDIE);

  ----***Forward Uint***----
  Forward_Uint :  FU port map (Rscr1_AddressIDIE,Rscr2_AddressIDIE,Reg_WB_Add11_IEMEM,Reg_WB_Add12_IEMEM,Reg_WB_Addr1,Reg_WB_Addr2,SEL_MUX_A,SEL_MUX_B,Swap_Enable_IEMEM,Write_Enable_IEMEM,Write_Enable_WB,Swap_Enable_WB);
  
  ----***MUX-A***----
  MUX_A :  Mux5By3_32bits port map(Rsrc1_Data_IDIE,Reg_WB_Data1,ALU_Result_IEMEM,Reg_WB_Data2,Rsrc2_Data_IEMEM,SEL_MUX_A,Scrs_A);-- changed this (ALU_Result_IEMEM) with Rsrc2_Data_IEMEM
  
  ----***MUX-B***----
  MUX_B :  Mux5By3_32bits port map(Src2_Data_ALU,Reg_WB_Data1,ALU_Result_IEMEM,Reg_WB_Data2,Rsrc2_Data_IEMEM,SEL_MUX_B,Scrs_B);
  
  ----***MUX 2 by 1 32bit Srcs 2 destination of ALU***----  
  Srcs2_Dest : Mux2_1 port map (Rsrc2_Data_IDIE,IMM_EA_IDIE,Regsrc2_Control_IDIE,Src2_Data_ALU);
  
  ----***ALU unit***----
  ALU_uint : ALU port map (EX_IDIE,Flags_out_CCR(2),Flags_out_CCR(0),Flags_out_CCR(1),Scrs_A,Scrs_B,CF_ALU_OUT,NF_ALU_OUT,ZF_ALU_OUT,ALU_Result,ALU_Enable_IDIE);    
  
  ----***MUX 2 by 1 32bit value of ALU result***----  
  ALU_value_result : Mux2_1 port map (ALU_Result,IN_Port_IDIE,InputPortEnable_IDIE,ALU_Result_New);

  ----***Carry MUX***----
  Carry_MUX : Mux4By2_1bits port map (CF_ALU_OUT,'1','0',Selector_set_carry_IDIE,CF_MUX_OUT);
  
  ----***Condition Code Register***----
  Condition_Code_Register : CCR port map (rst,clk,CF_MUX_OUT,NF_ALU_OUT,ZF_ALU_OUT,Reset_CF,Reset_ZF,Reset_NF,RTI_IDIE,Flags_Restor,Flags_out_CCR,CCR_Enable_IDIE);
  
  ----***Preserved Condition Code Register***----    
  Preserved_Condition_Code_Register :  Preserved_CCR port map (rst,clk,Interrupt_out_IDIE,RTI_IDIE,Flags_out_CCR,Flags_Restor);
  
  ----*** MUX Register Writeback Address 1***---- 
  Register_WB_Address1 : Mux2By1_3bits port map (Rdst_AddressIDIE,Rscr1_AddressIDIE,Reg_Dst_selector_IDIE,Register_WB_Add1);
  
  ----***Jumps AND Gates + OR Gates***---- 
  CF_AND  : AND_2_Gate port map (Flags_out_CCR(2),JMP_CF_IDIE,Reset_CF); 
  ZF_AND  : AND_2_Gate port map (Flags_out_CCR(1),JMP_ZF_IDIE,Reset_ZF);
  NF_AND  : AND_2_Gate port map (Flags_out_CCR(0),JMP_ZF_IDIE,Reset_NF);
  OR_Gate : OR_5_Gate  port map (Reset_CF,Reset_ZF,Reset_NF,JMP_IDIE,Call_IDIE,Jump_Selector);
  
  ----***MUX Stage Jump***----
  MUX_Jump_Stage : Mux2_1 port map (PC_Next,Rsrc1_Data_IDIE,Jump_Selector,Output_Stage_Jump_MUX);
  
  ----***IE_MEM***----
  IEMEM : IE_MEM port map (rst,clk,Call_IDIE,RET_IDIE,POP_IDIE,PUSH_IDIE,RTI_IDIE,Stack_operation_IDIE,WB_IDIE,MEM_IDIE,
                           Write_Enable_IDIE,Interrupt_out_IDIE,
                           Swap_Enable_IDIE,ALU_Result_New,Rsrc1_Data_IDIE,Rsrc2_Data_IDIE,Register_WB_Add1,
                           Rscr1_AddressIDIE,PC_OUT_IDIE,PC_Next_IDIE,Call_IEMEM,RET_IEMEM,POP_IEMEM,PUSH_IEMEM,
                           RTI_IEMEM,Stack_operation_IEMEM,WB_IEMEM,
                           MEM_IEMEM,Write_Enable_IEMEM,Interrupt_out_IEMEM,Swap_Enable_IEMEM,            
                           ALU_Result_IEMEM,Rsrc1_Data_IEMEM,Rsrc2_Data_IEMEM,Reg_WB_Add11_IEMEM,Reg_WB_Add12_IEMEM,
                           PC_OUT_IEMEM,PC_Next_IEMEM,Output_Stage_Jump_MUX,BranchMUX_IEMEM);

  ----***Stack Control unit***----
  Stack_Control_unit : Stack_CU port map (rst,clk,Call_IEMEM,RET_IEMEM,POP_IEMEM,PUSH_IEMEM,RTI_IEMEM,Interrupt_out_IEMEM,SP_address);                                                  

  ----***MUX Address of Data Memory***----
  DataAdress_MUX : Mux2_1 port map (ALU_Result_IEMEM,SP_address,Stack_operation_IEMEM,DataMemory_address);

  ----***MUX Interrupt***---- 
  Interrupt_MUX : Mux2_1 port map (PC_Next,PC_OUT_IEMEM,Interrupt_out_IEMEM,Output_Interrupt_MUX); 
  
  ----***MUX 1st stage WriteData***----
  MUX_1st_Stage_WD : Mux2_1 port map (Rsrc1_Data_IEMEM,Output_Interrupt_MUX,Stack_operation_IEMEM,Output_1st_Stage_MUX); 
  
  ----***MUX 2nd stage WriteData***----
  MUX_2nd_Stage_WD : Mux2_1 port map (Output_1st_Stage_MUX,Rsrc1_Data_IEMEM,PUSH_OR_POP,WriteData);

  ----***Data Memory***----    
  Data_Memory : DataMemory port map (MEM_IEMEM(1),MEM_IEMEM(0),DataMemory_address,WriteData,Data_Memory_Output,M10,M32);
    
  ----***MUX 1st Stage Jump***----
  MUX_Jump_1st_Stage : Mux2_1 port map (BranchMUX_IEMEM,Data_Memory_Output,RET_OR_RTI,Output_1st_Stage_Jump_MUX);
  
  ----***MUX 2nd Stage Jump***----
  MUX_Jump_2nd_Stage : Mux4By2_32bits port map (Output_1st_Stage_Jump_MUX,M32,M10,Reset_and_Interrupt,PC_IN);
  
  ----***MEM_WB***----
  MEMWB : MEM_WB port map (rst,clk,WB_IEMEM,Write_Enable_IEMEM,Swap_Enable_IEMEM,Data_Memory_Output,Reg_WB_Add11_IEMEM,
                           ALU_Result_IEMEM,Reg_WB_Add12_IEMEM,Rsrc2_Data_IEMEM,WB_MEMWB,Write_Enable_WB,Swap_Enable_WB,
                           DataMemory_MEMWB,Reg_WB_Addr1,ALU_Result_MEMWB,Reg_WB_Addr2,Reg_WB_Data2);
  
  ----***MUX WriteBack Stage***----
  MUX_WriteBack_Stage : Mux2_1 port map (ALU_Result_MEMWB,DataMemory_MEMWB,WB_MEMWB(0),Reg_WB_Data1);

  
      
End arch_MicroProcessor;     


