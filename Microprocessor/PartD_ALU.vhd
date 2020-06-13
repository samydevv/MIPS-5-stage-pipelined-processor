Library IEEE;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

ENTITY partD IS
PORT ( S0,S1,Cin:IN std_logic;
       CF:OUT std_logic;
       A: IN std_logic_vector (31 DOWNTO 0);
       B: IN std_logic_vector (31 DOWNTO 0);
       F: OUT std_logic_vector (31 DOWNTO 0));
END partD;

ARCHITECTURE archD OF partD IS
BEGIN
	F<= A WHEN S1='0' AND S0='0'
	ELSE B WHEN S1='0' AND S0='1';
	
	CF<=Cin;
END archD;