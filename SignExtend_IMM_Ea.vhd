LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

Entity SignExtend is
    port(Enable     :in  std_logic_vector(1  downto 0); 
         IMM_EA_in  :in  std_logic_vector(19 downto 0);
         IMM_EA_out :out std_logic_vector(31 downto 0)
        );
End Entity SignExtend;

Architecture arch_SignExtend of SignExtend is
  SIGNAL rEA : std_logic_vector(11 downto 0);
  SIGNAL rIMM : std_logic_vector(15 downto 0);
  Begin
       rIMM <= "0000000000000000"; 
       rEA <= "000000000000";
    process(Enable)
      begin
        if (Enable = "00") then
               IMM_EA_out <= std_logic_vector(resize(signed(IMM_EA_in),IMM_EA_out'length));
        end if; 
        if (Enable = "01") then
               IMM_EA_out <= std_logic_vector(resize(signed(IMM_EA_in(19 downto 4)),IMM_EA_out'length));
         end if;
        if (Enable = "10") then
               IMM_EA_out <= rIMM & IMM_EA_in(19 downto 4) ;
         end if;
        if (Enable = "11") then
               IMM_EA_out <= rEA & IMM_EA_in ;
         end if;         
    end process;
 End arch_SignExtend;
