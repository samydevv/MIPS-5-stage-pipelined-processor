library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


Entity Stack_CU is
    port(
         Call_in                : in std_logic;                    
         RET_in                 : in std_logic;                    
         POP_in                 : in std_logic;                    
         PUSH_in                : in std_logic;                    
         RTI_in                 : in std_logic; 
         Interrupt_in           : in std_logic;
         SP                     : out std_logic_vector(31 downto 0)
        );
End Entity Stack_CU;


Architecture arch_Stack_CU Of Stack_CU Is
  
  BEGIN
    


End arch_Stack_CU;
