library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity DataMemory is
  port(--clk
      ReadEnable,WriteEnable      : in std_logic;
      address                     : in std_logic_vector(31 downto 0);
      datain                      : in std_logic_vector(31 downto 0);
      dataout,M10,M32             : out std_logic_vector(31 downto 0)
      );
End Entity DataMemory;

Architecture arch_DataMemory Of DataMemory IS
  type ram_data is array (0 to 4095) of std_logic_vector(15 downto 0); --2^12=4kB  
	signal dataMemory       : ram_data;
	signal raddress :  std_logic_vector(10 downto 0);
  BEGIN
       raddress<= std_logic_vector(unsigned(address(10 downto 0)) + 1);
       process(WriteEnable,ReadEnable) is
--         variable STARTUP: boolean := true;
	     begin
--	           if (STARTUP = true) then  -- for initialization of Data Memory during start of simulation
--	                dataMemory <= (others =>"0000000000000000");
--	                STARTUP :=false; -- now this portion of process will only execute once
	                
--	           else    
		       --if rising_edge(clk) then
		            if WriteEnable = '1' then
	                 dataMemory(to_integer(unsigned(address(10 downto 0)))) <= datain (15 downto 0);
	                 dataMemory(to_integer(unsigned(raddress))) <= datain (31 downto 16);
                end if;
		       --end if;
		        if ReadEnable = '1' then
	             dataout <= dataMemory(to_integer(unsigned(raddress))) & dataMemory(to_integer(unsigned(address(10 downto 0))));
            end if;
--          end if;
	     end process;
       M10 <= dataMemory(1) & dataMemory(0);
       M32 <= dataMemory(3) & dataMemory(2);
End arch_DataMemory;    


