Library IEEE;
Use ieee.std_logic_1164.all;

ENTITY partB IS
PORT ( S0,S1,Cin:IN std_logic;
       CF: OUT std_logic;
       A,B: IN std_logic_vector (31 DOWNTO 0);
       F: OUT std_logic_vector (31 DOWNTO 0));
END partB;

ARCHITECTURE archB OF partB IS
  SIGNAL RESULT:std_logic_vector(31 DOWNTO 0);
BEGIN 
	RESULT<= A AND B WHEN S1='0' AND S0='0'
	ELSE A OR B WHEN S1='0' AND S0='1'
	ELSE NOT A WHEN S1='1' AND S0='0';
	  
	F<=RESULT;
	  
	CF<=Cin;
END archB;