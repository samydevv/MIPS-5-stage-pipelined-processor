library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
  Entity Mux2By1_3bits is
    port(A,B :in std_logic_vector(2 downto 0);
         S   :in std_logic;
         Z   :out std_logic_vector(2 downto 0)
         );
  End Mux2By1_3bits;
 
Architecture arch_Mux2By1_3bits of Mux2By1_3bits is 
   begin
       Z <=   A when s='0'
         else B;
 End arch_Mux2By1_3bits;



