LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

Entity MEM_WB is
    port(             -----in Port-----                             
         WB_in                  : in std_logic_vector(1  downto 0);
         Write_Enable_in        : in std_logic;                                                     
         Swap_Enable_in         : in std_logic;
                      -----out Port-----                
         WB_out                 : out std_logic_vector(1  downto 0);
         Write_Enable_out       : out std_logic;                                                        
         Swap_Enable_out        : out std_logic             
        );
End Entity MEM_WB;


Architecture arch_MEM_WB Of MEM_WB Is
  BEGIN
		 WB_out            <=      WB_in;                
         Write_Enable_out  <=      Write_Enable_in;
         Swap_Enable_out   <=      Swap_Enable_in;       
  
End arch_MEM_WB;
