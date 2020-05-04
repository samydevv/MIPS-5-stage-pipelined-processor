LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

Entity SignExtend is
    port(Enable     :in  std_logic; 
         IMM_EA_in  :in  std_logic_vector(19 downto 0);
         IMM_EA_out :out std_logic_vector(31 downto 0)
        );
End Entity SignExtend;

Architecture arch_SignExtend of SignExtend is
  --SIGNAL EA : std_logic_vector(15 downto 0);
  Begin
       --EA <= IMM_EA_in(19 downto 4); 
    process(Enable)
      begin
        if (Enable = '0') then
               IMM_EA_out <= std_logic_vector(resize(signed(IMM_EA_in),IMM_EA_out'length));
        end if; 
        if (Enable = '1') then
               IMM_EA_out <= std_logic_vector(resize(signed(IMM_EA_in(19 downto 4)),IMM_EA_out'length));
         end if;
    end process;
 End arch_SignExtend;
