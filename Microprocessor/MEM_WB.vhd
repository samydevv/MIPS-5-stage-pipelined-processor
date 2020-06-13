LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

Entity MEM_WB is
    port(rst,clk                :in std_logic;
                 -----in Port-----                             
     WB_in                  : in std_logic_vector(1  downto 0);
     Write_Enable_in        : in std_logic;                                                     
     Swap_Enable_in         : in std_logic;
		 Data_MEM_in            : in std_logic_vector(31 downto 0);
		 Reg_WB_address1_in     : in std_logic_vector(2 downto 0);
		 Result_ALU_in          : in std_logic_vector(31 downto 0);
		 Rscr1_Address_in       : in std_logic_vector(2 downto 0);
		 Rsrc2_Value_in         : in std_logic_vector(31 downto 0);
                      -----out Port-----                
     WB_out                 : out std_logic_vector(1  downto 0);
     Write_Enable_out       : out std_logic;                                                        
     Swap_Enable_out        : out std_logic;
		 Data_MEM_out           : out std_logic_vector(31 downto 0);
		 Reg_WB_address1_out    : out std_logic_vector(2 downto 0);
		 Result_ALU_out         : out std_logic_vector(31 downto 0);
		 Reg_WB_address2_out    : out std_logic_vector(2 downto 0);
		 Reg_WB_Value_2         : out std_logic_vector(31 downto 0)
	--	 IN_Port_IN             : in std_logic_vector(31 downto 0);
	--  IN_Port_out            : out std_logic_vector(31 downto 0)
        );
End Entity MEM_WB;


Architecture arch_MEM_WB Of MEM_WB Is
  SIGNAL tempDatain ,tempDataout   : std_logic_vector(105 downto 0);
  --------------------------------------------------------------------
   COMPONENT MEM_WB_Registerr is
        port(rst,clk,en:in std_logic;
       datain    :in std_logic_vector(105 downto 0);
       dataout   :out std_logic_vector(105 downto 0)
       );
      End COMPONENT;
    -------------------------------------------------------------------
  BEGIN
		           tempDatain   <= WB_in & Write_Enable_in & Swap_Enable_in & Data_MEM_in &    
				                      Reg_WB_address1_in  & Result_ALU_in  & Rscr1_Address_in &
				                      Rsrc2_Value_in;
		           
             MEMWB_Reg: MEM_WB_Registerr port map (rst,clk,'1',tempDatain,tempDataout);                           
		               WB_out               <=  tempDataout(105 downto 104);
				           Write_Enable_out     <=  tempDataout(103);
                   Swap_Enable_out      <=  tempDataout(102);
				           Data_MEM_out         <=  tempDataout(101 downto 70);
				           Reg_WB_address1_out  <=  tempDataout(69 downto 67);
				           Result_ALU_out       <=  tempDataout(66 downto 35);
				           Reg_WB_address2_out  <=  tempDataout(34 downto 32);
				           Reg_WB_Value_2       <=  tempDataout(31 downto 0); 				                    
  
End arch_MEM_WB;
