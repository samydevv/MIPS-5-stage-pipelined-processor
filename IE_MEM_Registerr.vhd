library ieee;
use ieee.std_logic_1164.all;


Entity IE_MEM_Registerr is
  port(rst,clk,en:in std_logic;
       datain    :in std_logic_vector(210 downto 0);
       dataout   :out std_logic_vector(210 downto 0)
       );
End Entity;


Architecture arch_IE_MEM_Registerr of IE_MEM_Registerr is
  BEGIN
       process(clk,rst)
       begin
            if rst='1' then
               dataout<= (others =>'0');
            elsif falling_edge  (clk) then 
                  if en='1' then
                     dataout<=datain;
                  end if;
            end if;  
        end process;
END arch_IE_MEM_Registerr;






