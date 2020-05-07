LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

Entity IE_MEM is
    port(             -----in Port-----
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
         Swap_Enable_out        : out std_logic             
        );
End Entity IE_MEM;


Architecture arch_IE_MEM Of IE_MEM Is
  BEGIN
		Call_out              <=   Call_in;                
		RET_out               <=   RET_in;               
		POP_out               <=   POP_in;                 
		PUSH_out              <=   PUSH_in;                
		RTI_out               <=   RTI_in;                 
		Stack_operation_out   <=   Stack_operation_in;     
		JMP_out               <=   JMP_in;                 
		JMP_ZF_out            <=   JMP_ZF_in;              
		JMP_CF_out            <=   JMP_CF_in;             
		JMP_NF_out            <=   JMP_NF_in;              
		WB_out                <=   WB_in;                  
		MEM_out               <=   MEM_in;                 
		Write_Enable_out      <=   Write_Enable_in;        
		Interrupt_out         <=   Interrupt_in;           
		Reset_out             <=   Reset_in;               
		Swap_Enable_out       <=   Swap_Enable_in;         
		
End arch_IE_MEM; 
