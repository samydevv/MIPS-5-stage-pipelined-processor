library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity DataMemory is
  port(clk,ReadEnable,WriteEnable : in std_logic;
      address                     : in std_logic_vector(31 downto 0);
      datain                      : in std_logic_vector(31 downto 0);
      dataout,M10,M32             : out std_logic_vector(31 downto 0)
      );
End Entity DataMemory;

Architecture arch_DataMemory Of DataMemory IS
  type ram_data is array (0 to 1048575) of std_logic_vector(15 downto 0); --2^32=4GB  4294967295
	signal dataMemory       : ram_data;
	signal raddress :  std_logic_vector(31 downto 0);
  BEGIN
       M10 <= dataMemory(1) & dataMemory(0);
       M32 <= dataMemory(3) & dataMemory(2);
       raddress<= std_logic_vector(unsigned(address) + 1);
       process(clk) is
	     begin
		       --if rising_edge(clk) then
		            if WriteEnable = '1' then
	                 dataMemory(to_integer(unsigned(address))) <= datain (15 downto 0);
	                 dataMemory(to_integer(unsigned(raddress))) <= datain (31 downto 16);
                end if;
		       --end if;
		        if ReadEnable = '1' then
	             dataout <= dataMemory(to_integer(unsigned(raddress))) & dataMemory(to_integer(unsigned(address)));
            end if;
	     end process;
End arch_DataMemory;    


