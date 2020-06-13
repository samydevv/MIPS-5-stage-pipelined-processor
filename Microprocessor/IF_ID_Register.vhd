library ieee;
use ieee.std_logic_1164.all;


Entity IF_ID_Registerr is
  port(rst,clk,en:in std_logic;
       datain    :in std_logic_vector(127 downto 0);
       dataout   :out std_logic_vector(127 downto 0)
       );
End Entity;


Architecture arch_IF_ID_Registerr of IF_ID_Registerr is
  SIGNAL temp1 : std_logic_vector(4 downto 0):= (others =>'1');
  SIGNAL temp01 : std_logic_vector(26 downto 0):= (others =>'0');
  SIGNAL temp02 : std_logic_vector(95 downto 0):= (others =>'0');
  BEGIN
       process(clk,rst)
       begin
            if rst='1' then
               dataout<= temp02 & temp1 & temp01;
            elsif falling_edge  (clk) then 
                  if en='1' then
                     dataout<=datain;
                  end if;
            end if;  
        end process;
END arch_IF_ID_Registerr;



