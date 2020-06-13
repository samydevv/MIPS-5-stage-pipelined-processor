Library ieee; 
Use ieee.std_logic_1164.all; 
 
  Entity PC is 
  port (clk              : in std_logic; 
        StallEn          :in std_logic;
        PC_In            : in std_logic_vector(31 downto 0);
        PC_Out           : out std_logic_vector(31 downto 0)
        );
 End Entity PC; 

 Architecture arch_PC of PC is 
    SIGNAL tempDataout   : std_logic_vector(31 downto 0);
    SIGNAL en : std_logic;
  ----------------------------------------------------------    
    COMPONENT FallingRegisterr IS--Falling
      port(rst,clk,en  :in std_logic;
           datain      :in std_logic_vector(31 downto 0);
           dataout     :out std_logic_vector(31 downto 0)
           );
      END COMPONENT;
  ----------------------------------------------------------
    begin 
          PC_Reg : FallingRegisterr  port map ('0', clk,en, PC_In, tempDataout);
          en         <= '0' when (StallEn = '1') else
                    '1'; 
          PC_Out     <= tempDataout;
          
End arch_PC; 
