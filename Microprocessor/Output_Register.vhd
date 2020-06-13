library ieee;
use ieee.std_logic_1164.all;


Entity Output_Register is
  port(rst,clk,en:in std_logic;
       datain    :in std_logic_vector(31 downto 0);
       dataout   :out std_logic_vector(31 downto 0)
       );
End Entity Output_Register;


Architecture arch_Output_Register of Output_Register is
  BEGIN
       process(clk,rst)
       begin
            if rst='1' then
               dataout<=(others=>'0');
            elsif rising_edge (clk) then 
                  if en='1' then
                     dataout<=datain;
                  end if;
            end if;  
        end process;
END arch_Output_Register;


