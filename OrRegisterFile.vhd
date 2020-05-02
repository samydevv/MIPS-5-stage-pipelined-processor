library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
  Entity OR_2 is
    port(A,B :in std_logic_vector(7 downto 0);
         Z   :out std_logic_vector(7 downto 0)
         );
  End OR_2;
 
Architecture arch_OR_2 of OR_2 is 
   begin
       Z <= A or B;
 End arch_OR_2;
