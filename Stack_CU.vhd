library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


Entity Stack_CU is
    port(rst,clk                :in std_logic;
         Call_in                : in std_logic;                    
         RET_in                 : in std_logic;                    
         POP_in                 : in std_logic;                    
         PUSH_in                : in std_logic;                    
         RTI_in                 : in std_logic; 
         Interrupt_in           : in std_logic;
         SP                     : out std_logic_vector(10 downto 0);
         SP_address             : out std_logic_vector(31 downto 0)
        );
End Entity Stack_CU;


Architecture arch_Stack_CU Of Stack_CU Is
    signal SP_output,SP_input : std_logic_vector(10 downto 0) ; --:= (others =>'1'); -- Set Initial Value of SP
   signal temp_zeros : std_logic_vector(20 downto 0) := (others =>'0');
   signal en : std_logic;
   --------------------------------------------------------------------
   COMPONENT SP_Register IS
      port(rst,clk,en  :in std_logic;
           datain      :in std_logic_vector(10 downto 0);
           dataout     :out std_logic_vector(10 downto 0)
           );
      END COMPONENT;
    -------------------------------------------------------------------
  BEGIN
        en <= '1' when (PUSH_in='1' or POP_in='1' or Call_in='1' or RET_in='1' or RTI_in='1' or Interrupt_in='1')
             else '0';
     			SP_address    <= temp_zeros & SP_output when rst='1' else
							         temp_zeros & SP_output when PUSH_in='1'    else
							         temp_zeros & std_logic_vector(to_unsigned(to_integer(unsigned(SP_output))+0,11)) when  POP_in='1'  else
							         temp_zeros & SP_output when Call_in='1'    else
			                 temp_zeros & std_logic_vector(to_unsigned(to_integer(unsigned(SP_output))+0,11)) when  RET_in='1' else
                       temp_zeros & std_logic_vector(to_unsigned(to_integer(unsigned(SP_output))+0,11)) when  RTI_in='1'   else
                       temp_zeros & SP_output when Interrupt_in='1'  ;                       
                       
			SP_input    <=  
							        std_logic_vector(to_unsigned(to_integer(unsigned(SP_output))-2,11)) when  PUSH_in='1'    else
							        std_logic_vector(to_unsigned(to_integer(unsigned(SP_output))+2,11)) when  POP_in='1'    else
							        std_logic_vector(to_unsigned(to_integer(unsigned(SP_output))-2,11)) when  Call_in='1'   else
							        std_logic_vector(to_unsigned(to_integer(unsigned(SP_output))+2,11)) when  RET_in='1'    else
							        std_logic_vector(to_unsigned(to_integer(unsigned(SP_output))+2,11)) when  RTI_in='1'    else
							        std_logic_vector(to_unsigned(to_integer(unsigned(SP_output))-2,11)) when  Interrupt_in='1' ; 
			SP          <=  SP_output;
							        						 
        SP_Reg: SP_Register port map (rst,clk,en,SP_input,SP_output);
			

End arch_Stack_CU;
