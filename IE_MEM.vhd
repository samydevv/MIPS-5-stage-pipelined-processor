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
--       JMP_in                 : in std_logic;                    
--       JMP_ZF_in              : in std_logic;                    
--       JMP_CF_in              : in std_logic;                    
--       JMP_NF_in              : in std_logic;                                        
         WB_in                  : in std_logic_vector(1  downto 0);
         MEM_in                 : in std_logic_vector(1  downto 0);
         Write_Enable_in        : in std_logic;                                       
         Interrupt_in           : in std_logic;                     
         Swap_Enable_in         : in std_logic;
--		     Flags_in	           			: in std_logic_vector(2 downto 0);
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
--		     Flags_out		          		: out std_logic_vector(2 downto 0);
		     Result_ALU_out         : out std_logic_vector(31 downto 0);
		     Rsrc1_Value_out        : out std_logic_vector(31 downto 0);
		     Rsrc2_Value_out        : out std_logic_vector(31 downto 0);
		     Reg_WB_address1_out    : out std_logic_vector(2 downto 0);
		     Reg_WB_address2_out    : out std_logic_vector(2 downto 0);
		     PC_out                 : out std_logic_vector(31 downto 0);
         PC_Plus_2_1_out        : out std_logic_vector(31 downto 0);
		 --  IN_Port_IN             : in std_logic_vector(31 downto 0);
	   --  IN_Port_out            : out std_logic_vector(31 downto 0);
	       BranchMUX_IN           : in std_logic_vector(31 downto 0);
	       BranchMUX_out          : out std_logic_vector(31 downto 0)
	       
        );
End Entity IE_MEM;


Architecture arch_IE_MEM Of IE_MEM Is
  SIGNAL tempDatain ,tempDataout   : std_logic_vector(210 downto 0);
  --------------------------------------------------------------------
   COMPONENT IE_MEM_Registerr is
        port(rst,clk,en:in std_logic;
       datain    :in std_logic_vector(210 downto 0);
       dataout   :out std_logic_vector(210 downto 0)
       );
      End COMPONENT;
    -------------------------------------------------------------------
  BEGIN
		           tempDatain   <= Call_in & RET_in & POP_in  & PUSH_in  & RTI_in  & Stack_operation_in  & WB_in &                
                               MEM_in  & Write_Enable_in & Interrupt_in & Swap_Enable_in & Result_ALU_in &     
		                           Rsrc1_Value_in & Rsrc2_Value_in & Reg_WB_address_in & Rscr1_Address_in & 
		                           PC_in & PC_Plus_2_1_in & BranchMUX_IN	;
		           
             IEMEM_Reg: IE_MEM_Registerr port map (rst,clk,'1',tempDatain,tempDataout);  
              Call_out              <= tempDataout(210);           
		          RET_out               <= tempDataout(209);         
		          POP_out               <= tempDataout(208);
		          PUSH_out              <= tempDataout(207);           
		          RTI_out               <= tempDataout(206);           
		          Stack_operation_out   <= tempDataout(205);
		          WB_out                <= tempDataout(204 downto 203); 
		          MEM_out               <= tempDataout(202 downto 201);
		          Write_Enable_out      <= tempDataout(200);        
		          Interrupt_out         <= tempDataout(199);
		          Swap_Enable_out       <= tempDataout(198);
				      Result_ALU_out        <= tempDataout(197 downto 166);
				      Rsrc1_Value_out       <= tempDataout(165 downto 134);
				      Rsrc2_Value_out       <= tempDataout(133 downto 102);
				      Reg_WB_address1_out   <= tempDataout(101 downto 99);
				      Reg_WB_address2_out   <= tempDataout(98 downto 96);
				      PC_out                <= tempDataout(95 downto 64);
				      PC_Plus_2_1_out       <= tempDataout(63 downto 32);   
					    BranchMUX_out         <= tempDataout(31 downto 0);
					    
End arch_IE_MEM; 
