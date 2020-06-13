library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity DataMemory is
  port(clk,PP                      : in std_logic;     
       WriteEnable                 : in std_logic;
       address                     : in std_logic_vector(31 downto 0);
       datain                      : in std_logic_vector(31 downto 0);
       dataout,M10,M32             : out std_logic_vector(31 downto 0)
      );
End Entity DataMemory;

Architecture arch_DataMemory Of DataMemory IS
  type ram_data is array (0 to 4095) of std_logic_vector(15 downto 0); --2^12=4kB  
	signal dataMemory       : ram_data;
	signal rpp       : std_logic_vector(31 downto 0);
  BEGIN
      
       process(clk,address,PP,WriteEnable,datain) is
	     begin
    	       rpp <= std_logic_vector(unsigned(address(31 downto 0)) - 1);
	          if rising_edge(clk) then
		           if (WriteEnable = '1') and (PP='0') then
	              dataMemory(to_integer(unsigned(address(10 downto 0)))) <= datain (15 downto 0);
	              dataMemory(to_integer(unsigned(address(10 downto 0)) + 1)) <= datain (31 downto 16);
              else if (WriteEnable = '1') and (PP='1') then
	              dataMemory(to_integer(unsigned(address(10 downto 0)))) <= datain (15 downto 0);
	              dataMemory(to_integer(unsigned(rpp(10 downto 0)))) <= datain (31 downto 16);
               end if;
               end if;
            end if;
	     end process;
	     dataout <= dataMemory(to_integer(unsigned(rpp(10 downto 0)))) & dataMemory(to_integer(unsigned(address(10 downto 0)))) when PP='1'  else 
	                dataMemory(to_integer(unsigned(address(10 downto 0)) + 1)) & dataMemory(to_integer(unsigned(address(10 downto 0))));
	     M10 <= dataMemory(1) & dataMemory(0);
       M32 <= dataMemory(3) & dataMemory(2);
End arch_DataMemory;    



