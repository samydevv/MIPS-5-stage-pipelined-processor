library ieee;
use ieee.std_logic_1164.all;


Entity Delay is
  port(clk       :in std_logic;
       datain    :in std_logic_vector(31 downto 0);
       dataout   :out std_logic_vector(31 downto 0)
       );
End Entity;


Architecture arch_Delay of Delay is
  BEGIN
       process(clk)
       begin
            if rising_edge  (clk) then 
                     dataout<=datain;
            end if;  
        end process;
END arch_Delay;





