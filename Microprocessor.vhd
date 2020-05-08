library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


Entity Microprocessor is
	port(
		Reset            : in  std_logic;
		Interrupt        : in  STD_LOGIC;
		INPort           : in  std_logic_vector(31 downto 0);
		OUTPort          : out std_logic_vector(31 downto 0);
		clk              : in  std_logic
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
           Reset_in             : in std_logic;
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
           Reset_out            : out std_logic;                     
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
           Reset_in               : in std_logic;                     
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
           Reset_out              : out std_logic;                     
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
           Reset_in               : in std_logic;                     
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
           Reset_out              : out std_logic;                     
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
      

   
  
  
  
  
      
  

    
  
  
  
  
  
  
    
  BEGIN
  
  
       
End arch_MicroProcessor;     

