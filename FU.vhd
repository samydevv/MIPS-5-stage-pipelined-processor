Library IEEE;
Use ieee.std_logic_1164.all;

ENTITY FU IS
	PORT (Rsrc1, Rsrc2: IN std_logic_vector(2 DOWNTO 0);
		    ExMemRdst1,ExMemRdst2: IN std_logic_vector(2 DOWNTO 0);
		    MemWbRdst1,MemWbRdst2: IN std_logic_vector(2 DOWNTO 0);
		    SELA: OUT std_logic_vector(2 DOWNTO 0);
		    SELB: OUT std_logic_vector(2 DOWNTO 0);
	      SwapEn: IN std_logic);
END FU;

ARCHITECTURE archFU OF FU IS
	BEGIN
		SELA<= "001" WHEN Rsrc1=MemWbRdst1 AND SwapEn='0'
		ELSE "010" WHEN Rsrc1=ExMemRdst1	 AND SwapEn='0'	
		ELSE "011" WHEN Rsrc1=MemWbRdst2	 AND SwapEn='1'	
		ELSE "100" WHEN Rsrc1=ExMemRdst2	 AND SwapEn='1'	
		ELSE "000";
		
		SELB<= "001" WHEN Rsrc2=MemWbRdst1 AND SwapEn='0'
		ELSE "010" WHEN Rsrc2=ExMemRdst1	 AND SwapEn='0'	
		ELSE "011" WHEN Rsrc2=MemWbRdst2	 AND SwapEn='1'	
		ELSE "100" WHEN Rsrc2=ExMemRdst2	 AND SwapEn='1'	
		ELSE "000";
END archFU;