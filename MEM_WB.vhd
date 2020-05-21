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
		 Reg_WB_Value_2         : out std_logic_vector(31 downto 0);
		 IN_Port_IN             : in std_logic_vector(31 downto 0);
	   IN_Port_out            : out std_logic_vector(31 downto 0)
        );
End Entity MEM_WB;


Architecture arch_MEM_WB Of MEM_WB Is
  BEGIN
       process(clk,rst)
       begin
            if rst='1' then
		            WB_out                  <=   (others =>'0');              
                Write_Enable_out        <=   '0';
                Swap_Enable_out         <=   '0'; 
			          Data_MEM_out            <=   (others =>'0');  
			         	Reg_WB_address1_out     <=   (others =>'0');  
			         	Result_ALU_out          <=   (others =>'0');  
			         	Reg_WB_address2_out     <=   (others =>'0');  
			         	Reg_WB_Value_2          <=   (others =>'0');  
						    IN_Port_out             <= (others =>'0');
				
            elsif falling_edge (clk) then                                  
		               WB_out               <=  WB_in;                
				           Write_Enable_out     <=  Write_Enable_in;
                   Swap_Enable_out      <=  Swap_Enable_in;
				           Data_MEM_out         <=  Data_MEM_in;   
				           Reg_WB_address1_out  <=  Reg_WB_address1_in;
				           Result_ALU_out       <=  Result_ALU_in;     
				           Reg_WB_address2_out  <=  Rscr1_Address_in;  
				           Reg_WB_Value_2       <=  Rsrc2_Value_in; 
						       IN_Port_out          <= IN_Port_IN;						   
            end if;
          end process;                    
  
End arch_MEM_WB;
