library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AND_2_Gate is
    Port ( INA1 : in  STD_LOGIC;    
           INA2 : in  STD_LOGIC;    
           OA   : out STD_LOGIC 
           );  
end entity AND_2_Gate;

architecture arch_AND_2_Gate of AND_2_Gate is
begin
    OA <= INA1 and INA2;    
end arch_AND_2_Gate;
