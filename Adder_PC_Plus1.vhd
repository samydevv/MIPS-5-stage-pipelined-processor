LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

Entity PC_Plus1 is
    port( 
          PC: in std_logic_vector(31 downto 0);
          PcPlus1: out std_logic_vector(31 downto 0)
        );
End Entity;

Architecture arch_PC_Plus1 of PC_Plus1 is
    SIGNAL AddressInteger1: integer:= 0;
    SIGNAL SUM1: integer := 0;
    Begin 
         AddressInteger1  <=    to_integer(unsigned(PC));
         SUM1             <=    AddressInteger1+1;
         PcPlus1          <=    std_logic_vector(to_unsigned(SUM1,32));

End arch_PC_Plus1 ;



