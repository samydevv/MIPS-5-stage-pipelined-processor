library ieee;
use ieee.std_logic_1164.all;

Entity Decoder is
    port(en        :in std_logic;
         dinput    :in std_logic_vector(2 downto 0);
         doutput   :out std_logic_vector(7 downto 0));
End Entity;

Architecture arch_Decoder of Decoder is
  begin
      doutput <= "00000001" when en='1' and dinput="000"
	          else "00000010" when en='1' and dinput="001"
	          else "00000100" when en='1' and dinput="010"
            else "00001000" when en='1' and dinput="011"
            else "00010000" when en='1' and dinput="100"
            else "00100000" when en='1' and dinput="101"
            else "01000000" when en='1' and dinput="110"
            else "10000000" when en='1' and dinput="111";
End arch_Decoder ;