Library ieee; 
Use ieee.std_logic_1164.all; 
 
  Entity PC is 
  port (Clk          : in std_logic; 
        StallEn        :in std_logic;
        PC_In        : in std_logic_vector(31 downto 0);
        PC_Out       : out std_logic_vector(31 downto 0)
        );
 End Entity PC; 

 Architecture arch_PC of PC is 
    begin 
	       Process (Clk)
 	          begin 
 		        if rising_edge(Clk) then 
 		         if (StallEn='0') then
 		            PC_Out <= PC_In;
 		           end if;
 		        end if; 
	       end process;
End arch_PC; 
