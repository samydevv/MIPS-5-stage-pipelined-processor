library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity SP_Register is
  port(rst,clk,en:in std_logic;
       datain    :in std_logic_vector(10 downto 0);
       dataout   :out std_logic_vector(10 downto 0)
       );
End Entity;


Architecture arch_SP_Register of SP_Register is
  BEGIN
       process(clk,rst)
       begin
            if rst='1' then
               dataout<=(others=>'1');
            elsif rising_edge (clk) then 
                  if en='1' then
                     dataout<=datain;
                  end if;
            end if;  
        end process;
END arch_SP_Register;

