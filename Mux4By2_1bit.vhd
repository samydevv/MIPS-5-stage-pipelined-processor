library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
  Entity Mux4By2_1bits is
    port(A,B,C :in  std_logic;
         S     :in  std_logic_vector (1 downto 0);
         Z     :out std_logic
         );
  End Mux4By2_1bits;
 
Architecture arch_Mux4By2_1bits of Mux4By2_1bits is 
   begin
       Z <=   A when s="00"
         else B when s="01"
         else C when s="10";
 End arch_Mux4By2_1bits;





