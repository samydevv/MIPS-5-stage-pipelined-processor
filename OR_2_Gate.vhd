
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OR_2_Gate is
    Port ( clk  : in  STD_LOGIC;  
           INO1 : in  STD_LOGIC;  
           INO2 : in  STD_LOGIC;
           OO : out  STD_LOGIC
          );  
end entity OR_2_Gate;

architecture arch_OR_2_Gate of OR_2_Gate is
begin
 process(clk)
 begin
 if rising_edge(clk) then 
OO <= INO1 or INO2 ;    
end if;
end process;
end arch_OR_2_Gate;