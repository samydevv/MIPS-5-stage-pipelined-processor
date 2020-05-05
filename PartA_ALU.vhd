Library IEEE;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

ENTITY partA IS
PORT ( S0,S1,Cin: IN std_logic;
       CF: OUT std_logic;
       A,B: IN std_logic_vector (31 DOWNTO 0);
       F: OUT std_logic_vector (31 DOWNTO 0));
END partA;

ARCHITECTURE archA OF partA IS
  SIGNAL RESULT:unsigned(32 DOWNTO 0);
BEGIN
  RESULT<='0' & unsigned(A) + unsigned(B) WHEN S1='0' AND S0='0'
	ELSE '0' & unsigned(A) - unsigned(B) WHEN S1='0' AND S0='1'
	ELSE '0' & unsigned(A) + 1 WHEN S1='1' AND S0='0'
	ELSE '0' & unsigned(A) - 1 WHEN S1='1' AND S0='1';
	  
	F<= std_logic_vector(RESULT(31 DOWNTO 0));
	
	CF<= RESULT(32);
END archA;

