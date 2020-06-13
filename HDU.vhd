Library IEEE;
Use ieee.std_logic_1164.all;

ENTITY HDU IS
	PORT (	IdExMemRead: IN std_logic;
		    IdExRdst1,IfIdRsrc1,IfIdRsrc2: IN std_logic_vector(2 DOWNTO 0);
			Stall: OUT std_logic;
      UseScrs1,UseScrs2: in std_logic);
END HDU;

ARCHITECTURE archHDU OF HDU IS
	BEGIN
	
	Stall <= '1' WHEN IdExMemRead = '1' AND ((IdExRdst1 = IfIdRsrc1 AND UseScrs1='1') or (IdExRdst1 = IfIdRsrc2 AND UseScrs2='1')) ELSE
	         '0';
	
END archHDU;