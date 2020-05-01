library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity InstructionMemory is
  port(clk            : in std_logic;
      PC_value        : in std_logic_vector(31 downto 0);
      Instruction_out : out std_logic_vector(31 downto 0)
      );
End Entity InstructionMemory;

Architecture arch_InstructionMemory Of InstructionMemory Is
  type ram_type is array (0 to 1048575) of std_logic_vector(15 downto 0); --2^32=4GB  4294967295
	signal ram       : ram_type;
	signal rPC_value :  std_logic_vector(31 downto 0);
  BEGIN
       rPC_value<= std_logic_vector(unsigned(PC_value) + 1);
       process(clk) is
	     begin
		        
	     end process;
	Instruction_out    <= ram(to_integer(unsigned(PC_value)))& ram(to_integer(unsigned(rPC_value)));
End arch_InstructionMemory;    