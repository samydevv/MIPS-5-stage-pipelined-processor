LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

Entity ID_IE is
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
		     Scr2_Address_in       : in std_logic_vector(2  downto 0);
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
	       InputPortEnable_out    : out std_logic;
         LDD_Enable_in          : in std_logic;
         LDD_Enable_out         : out std_logic
		 
        );
End Entity ID_IE;


Architecture arch_ID_IE Of ID_IE Is
  SIGNAL tempDatain ,tempDataout   : std_logic_vector(230 downto 0);
  SIGNAL erst : std_logic;
  --------------------------------------------------------------------
   COMPONENT ID_IE_Registerr is
        port(rst,clk,en:in std_logic;
       datain    :in std_logic_vector(230 downto 0);
       dataout   :out std_logic_vector(230 downto 0)
       );
      End COMPONENT;
    -------------------------------------------------------------------
  BEGIN
             tempDatain   <= ALU_Enable_in  & CCR_Enable_in  & Call_in & RET_in & POP_in & PUSH_in  & RTI_in  & Stack_operation_in 
		                        & JMP_in & JMP_ZF_in  & JMP_CF_in  & JMP_NF_in & Reg_Dst_selector_in &  WB_in & MEM_in & EX_in  &              
                             Selector_set_carry_in & Write_Enable_in & Regsrc2_Control_in & Interrupt_in & Swap_Enable_in & PC_in  & PC_Plus_2_1_in 
		                        & Rscr1_Address_in & Scr2_Address_in  & Rdst_Address_in & Imm_EA_in  & Rscr1_Data_in  & Rscr2_Data_in  & IN_Port_IN &
		                        OutputPortEnable_IN & InputPortEnable_IN  &  LDD_Enable_in ;
		                        
             erst         <= '1' when (FlushEn = '1' or rst ='1') else
                             '0';                     
       IDIE_Reg: ID_IE_Registerr port map (erst,clk,'1',tempDatain,tempDataout); 
               ALU_Enable_out          <= tempDataout(230);           
               CCR_Enable_out          <= tempDataout(229);            
               Call_out                <= tempDataout(228);            
               RET_out                 <= tempDataout(227);           
               POP_out                 <= tempDataout(226);            
               PUSH_out                <= tempDataout(225);           
               RTI_out                 <= tempDataout(224);           
               Stack_operation_out     <= tempDataout(223);           
               JMP_out                 <= tempDataout(222);          
               JMP_ZF_out              <= tempDataout(221);            
               JMP_CF_out              <= tempDataout(220);
               JMP_NF_out              <= tempDataout(219);
               Reg_Dst_selector_out    <= tempDataout(218);
               WB_out                  <= tempDataout(217 downto 216);
               MEM_out                 <= tempDataout(215 downto 214);
               EX_out                  <= tempDataout(213 downto 210);
               Selector_set_carry_out  <= tempDataout(209 downto 208);
               Write_Enable_out        <= tempDataout(207);
               Regsrc2_Control_out     <= tempDataout(206);
               Interrupt_out           <= tempDataout(205);              
               Swap_Enable_out         <= tempDataout(204);
			         PC_out                  <= tempDataout(203 downto 172);         
         			   PC_Plus_2_1_out         <= tempDataout(171 downto 140);         
         			   Rscr1_Address_out       <= tempDataout(139 downto 137);      
         			   Rscr2_Address_out       <= tempDataout(136 downto 134);       
         			   Rdst_Address_out        <= tempDataout(133 downto 131);        
         			   Imm_EA_out              <= tempDataout(130 downto 99);       
         			   Rscr1_Data_out          <= tempDataout(98 downto 67);   
         			   Rscr2_Data_out          <= tempDataout(66 downto 35); 
			         IN_Port_out             <= tempDataout(34 downto 3); 
			         OutputPortEnable_out    <= tempDataout(2);
			         InputPortEnable_out    <=  tempDataout(1);
			         LDD_Enable_out          <= tempDataout(0);            
			         
														   
End arch_ID_IE;      