Library IEEE;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

ENTITY partC IS
PORT ( S0,S1,Cin:IN std_logic;
       A: IN std_logic_vector (31 DOWNTO 0);
	     Imm: IN std_logic_vector (31 DOWNTO 0);
       CF: OUT std_logic;
       F: OUT std_logic_vector (31 DOWNTO 0));
END partC;

ARCHITECTURE archC OF partC IS
	SIGNAL SHL_CONCAT: unsigned (32 DOWNTO 0);
	SIGNAL SHR_CONCAT: unsigned (32 DOWNTO 0);
	SIGNAL RESULT: unsigned (32 DOWNTO 0);
BEGIN
	SHL_CONCAT<=Cin & unsigned(A(31 DOWNTO 0));
	SHR_CONCAT<=unsigned(A(31 DOWNTO 0)) & Cin;
	
	RESULT<= shift_left(SHL_CONCAT, to_integer(unsigned(Imm))) WHEN S1='0' AND S0='0'
	ELSE shift_right(SHR_CONCAT, to_integer(unsigned(Imm))) WHEN S1='0' AND S0='1';
	
	F<= std_logic_vector(RESULT(31 DOWNTO 0)) WHEN S1='0' AND S0='0'
	ELSE std_logic_vector(RESULT(32 DOWNTO 1)) WHEN S1='0' AND S0='1';
	
	CF<= RESULT(32) WHEN S1='0' AND S0='0'
	ELSE RESULT(0) WHEN S1='0' AND S0='1';
END archC;

