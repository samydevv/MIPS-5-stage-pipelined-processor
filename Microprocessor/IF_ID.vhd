LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

Entity IF_ID is
    port(
       rst,clk        :in std_logic;
       FlushEn        :in std_logic;
       StallEn        :in std_logic;
       Instruction_in : in  std_logic_vector(31 downto 0);
       PC_in          : in  std_logic_vector(31 downto 0);
       PC_Plus_2_1_in : in  std_logic_vector(31 downto 0);
       
       OP_Code        : out std_logic_vector(1  downto 0); 
       Function_Code  : out std_logic_vector(2  downto 0); 
       Rscr1_Address  : out std_logic_vector(2  downto 0); 
       Rscr2_Address  : out std_logic_vector(2  downto 0); 
       Rdst_Address   : out std_logic_vector(2  downto 0); 
       Imm_EA         : out std_logic_vector(19 downto 0); 
       PC_out         : out std_logic_vector(31 downto 0); 
       PC_Plus_2_1_out: out std_logic_vector(31 downto 0); 
	     IN_Port_IN     : in std_logic_vector(31 downto 0);  
	     IN_Port_out    : out std_logic_vector(31 downto 0)
        );
End Entity IF_ID;


Architecture arch_IF_ID Of IF_ID Is
  SIGNAL tempDatain ,tempDataout   : std_logic_vector(127 downto 0);
  SIGNAL en,erst : std_logic;
  --------------------------------------------------------------------
   COMPONENT IF_ID_Registerr is
        port(rst,clk,en:in std_logic;
       datain    :in std_logic_vector(127 downto 0);
       dataout   :out std_logic_vector(127 downto 0)
       );
      End COMPONENT;
    -------------------------------------------------------------------
  
  BEGIN
      tempDatain <= PC_in & PC_Plus_2_1_in & IN_Port_IN &Instruction_in;
      en         <= '0' when (StallEn = '1') else
                    '1'; 
      erst         <= '1' when (FlushEn = '1' or rst ='1') else
                      '0';                     
       IFID_Reg: IF_ID_Registerr port map (erst,clk,en,tempDatain,tempDataout);
               
               PC_out         <= tempDataout(127 downto  96);
               PC_Plus_2_1_out<= tempDataout(95 downto  64);  
               IN_Port_out    <= tempDataout(63 downto  32);  
               OP_Code        <= tempDataout(31 downto 30);
               Function_Code  <= tempDataout(29 downto 27);
               Rscr1_Address  <= tempDataout(23 downto 21);
               Rscr2_Address  <= tempDataout(20 downto 18);
               Rdst_Address   <= tempDataout(26 downto 24);
               Imm_EA         <= tempDataout(20 downto  1);  
			         
                 
End arch_IF_ID;    
