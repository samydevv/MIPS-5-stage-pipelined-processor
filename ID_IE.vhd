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
  BEGIN
       process(clk,rst,FlushEn)
       begin
            if (rst='1') or (FlushEn='1') then 
               ALU_Enable_out          <= '0';            
               CCR_Enable_out          <= '0';            
               Call_out                <= '0';            
               RET_out                 <= '0';
               POP_out                 <= '0';
               PUSH_out                <= '0';
               RTI_out                 <= '0';
               Stack_operation_out     <= '0';
               JMP_out                 <= '0';
               JMP_ZF_out              <= '0';
               JMP_CF_out              <= '0';
               JMP_NF_out              <= '0';
               Reg_Dst_selector_out    <= '0';
               WB_out                  <= (others =>'0');
               MEM_out                 <= (others =>'0');
               EX_out                  <= (others =>'0');
               Selector_set_carry_out  <= (others =>'0');
               Write_Enable_out        <= '0';
               Regsrc2_Control_out     <= '0';
               Interrupt_out           <= '0';
               Swap_Enable_out         <= '0';
			         PC_out                  <= (others =>'0');
			         PC_Plus_2_1_out         <= (others =>'0');
			         Rscr1_Address_out       <= (others =>'0');
			         Rscr2_Address_out       <= (others =>'0');
         			   Rdst_Address_out        <= (others =>'0');
               Imm_EA_out              <= (others =>'0');
               Rscr1_Data_out          <= (others =>'0');
               Rscr2_Data_out          <= (others =>'0');
			         IN_Port_out             <= (others =>'0');
			         OutputPortEnable_out    <= '0';
			         InputPortEnable_out     <= '0';
			         LDD_Enable_out          <= '0';
			         
            elsif falling_edge (clk) then   
               ALU_Enable_out          <= ALU_Enable_in;            
               CCR_Enable_out          <= CCR_Enable_in;            
               Call_out                <= Call_in;            
               RET_out                 <= RET_in;            
               POP_out                 <= POP_in;            
               PUSH_out                <= PUSH_in;            
               RTI_out                 <= RTI_in;            
               Stack_operation_out     <= Stack_operation_in;            
               JMP_out                 <= JMP_in;            
               JMP_ZF_out              <= JMP_ZF_in;            
               JMP_CF_out              <= JMP_CF_in;
               JMP_NF_out              <= JMP_NF_in;
               Reg_Dst_selector_out    <= Reg_Dst_selector_in;
               WB_out                  <= WB_in;
               MEM_out                 <= MEM_in;
               EX_out                  <= EX_in;
               Selector_set_carry_out  <= Selector_set_carry_in;
               Write_Enable_out        <= Write_Enable_in;
               Regsrc2_Control_out     <= Regsrc2_Control_in;
               Interrupt_out           <= Interrupt_in;              
               Swap_Enable_out         <= Swap_Enable_in;
			         PC_out                  <= PC_in;                 
         			   PC_Plus_2_1_out         <= PC_Plus_2_1_in;         
         			   Rscr1_Address_out       <= Rscr1_Address_in;       
         			   Rscr2_Address_out       <= Scr2_Address_in;       
         			   Rdst_Address_out        <= Rdst_Address_in;        
         			   Imm_EA_out              <= Imm_EA_in;       
         			   Rscr1_Data_out          <= Rscr1_Data_in;          
         			   Rscr2_Data_out          <= Rscr2_Data_in; 
			         IN_Port_out             <= IN_Port_IN;
			         OutputPortEnable_out    <= OutputPortEnable_IN;
			         InputPortEnable_out    <= InputPortEnable_IN;
			         LDD_Enable_out          <= LDD_Enable_in;            
			         
            end if;
          end process;
														   
End arch_ID_IE;      