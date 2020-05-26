library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
  Entity Mux5By3_32bits is
    port(A,B,C,D,E :in std_logic_vector(31 downto 0);
         S   :in std_logic_vector(2 downto 0);
         Z   :out std_logic_vector(31 downto 0)
         );
  End Mux5By3_32bits;
 
Architecture arch_Mux5By3_32bits of Mux5By3_32bits is 
   begin
       Z <=   B when s="001"
         else C when s="010"
         else D when s="011"
         else E when s="100"
         else A;
 End arch_Mux5By3_32bits;





