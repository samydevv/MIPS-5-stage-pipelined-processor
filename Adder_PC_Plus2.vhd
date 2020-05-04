LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

Entity PC_Plus2 is
    port( 
          PC: in std_logic_vector(31 downto 0);
          PcPlus2: out std_logic_vector(31 downto 0)
        );
End Entity PC_Plus2;

Architecture arch_PC_Plus2 of PC_Plus2 is
    SIGNAL AddressInteger2   : integer:= 0;
    SIGNAL SUM2              : integer := 0;
    Begin 
         AddressInteger2  <=    to_integer(unsigned(PC));
         SUM2             <=    AddressInteger2+2;
         PcPlus2          <=    std_logic_vector(to_unsigned(SUM2,32));

End arch_PC_Plus2 ;

