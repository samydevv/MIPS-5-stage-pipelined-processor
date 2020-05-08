LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

Entity IE_MEM is
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
		 Flags_in				: in std_logic_vector(2 downto 0);
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
End Entity IE_MEM;


Architecture arch_IE_MEM Of IE_MEM Is
  BEGIN
       process(clk,rst)
       begin
            if rst='1' then
				  Call_out              <=   '0';
		          RET_out               <=   '0';
		          POP_out               <=   '0';
		          PUSH_out              <=   '0';         
		          RTI_out               <=   '0';         
		          Stack_operation_out   <=   '0';     
		          JMP_out               <=   '0';         
		          JMP_ZF_out            <=   '0';         
		          JMP_CF_out            <=   '0';        
		          JMP_NF_out            <=   '0';         
		          WB_out                <=   (others =>'0');         
		          MEM_out               <=   (others =>'0');         
		          Write_Enable_out      <=   '0';        
		          Interrupt_out         <=   '0';         
		          Reset_out             <=   '0';         
		          Swap_Enable_out       <=   '0';
				  Flags_out				<=   (others =>'0');
				  Result_ALU_out        <=   (others =>'0');
				  Rsrc1_Value_out       <=   (others =>'0');
				  Rsrc2_Value_out       <=   (others =>'0');
				  Reg_WB_address_out    <=   (others =>'0');
				  Rscr1_Address_out     <=   (others =>'0');
				  PC_out                <=   (others =>'0');
				  PC_Plus_2_1_out       <=   (others =>'0');
				  
		          
            elsif rising_edge (clk) then    
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
				  Flags_out				<=   Flags_in;			
				  Result_ALU_out        <=   Result_ALU_in;
				  Rsrc1_Value_out       <=   Rsrc1_Value_in;   
				  Rsrc2_Value_out       <=   Rsrc2_Value_in;   
				  Reg_WB_address_out    <=   Reg_WB_address_in;
				  Rscr1_Address_out     <=   Rscr1_Address_in; 
				  PC_out                <=   PC_in;            
				  PC_Plus_2_1_out       <=   PC_Plus_2_1_in;   
				  
            end if;
          end process;

End arch_IE_MEM; 
