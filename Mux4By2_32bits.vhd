library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
  Entity Mux4By2_32bits is
    port(A,B,C :in std_logic_vector(31 downto 0);
         S   :in std_logic_vector(1 downto 0);
         Z   :out std_logic_vector(31 downto 0)
         );
  End Mux4By2_32bits;
 
Architecture arch_Mux4By2_32bits of Mux4By2_32bits is 
   begin
       Z <=   A when s="00"
         else B when s="01"
         else C when s="10";
 End arch_Mux4By2_32bits;



