library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity Control is
  port(      ------input to control uint---------
       OP_Code              : in std_logic_vector(1  downto 0); 
       Function_Code        : in std_logic_vector(2  downto 0);
       Interrupt_in         : in std_logic;
       --Reset_in             : in std_logic;
             ------output of control uint---------
       ALU_Enable           : out std_logic;                     --temp(30)  
       CCR_Enable           : out std_logic;                     --temp(29)
       Output_Enable        : out std_logic;                     --temp(28)
       Call                 : out std_logic;                     --temp(27)
       RET                  : out std_logic;                     --temp(26)
       POP                  : out std_logic;                     --temp(25)
       PUSH                 : out std_logic;                     --temp(24)
       RTI                  : out std_logic;                     --temp(23)
       Stack_operation      : out std_logic;                     --temp(22)
       JMP                  : out std_logic;                     --temp(21)
       JMP_ZF               : out std_logic;                     --temp(20)
       JMP_CF               : out std_logic;                     --temp(19)
       JMP_NF               : out std_logic;                     --temp(18)
       Reg_Dst_selector     : out std_logic;                     --temp(17)
       WB                   : out std_logic_vector(1  downto 0); --temp(16 downto 15)
       MEM                  : out std_logic_vector(1  downto 0); --temp(14 downto 13)   temp(14)=> ReadEnable ,temp(13)=> WriteEnable  
       EX                   : out std_logic_vector(3  downto 0); --temp(12 downto  9)
       Selector_set_carry   : out std_logic_vector(1  downto 0); --temp(8  downto  7)
       Write_Enable         : out std_logic;                     --temp(6)
       Regsrc2_Control      : out std_logic;                     --temp(5)
       Sign_Extend_Enable   : out std_logic_vector(1  downto 0); --temp(4  downto  3)   
       Interrupt_out        : out std_logic;                     --temp(2) 
       --Reset_out            : out std_logic;                     --temp(1)
       Swap_Enable          : out std_logic                      --temp(0)
      );
End Entity Control;


Architecture arch_Control Of Control Is
  signal temp : std_logic_vector(30 downto 0); 
  BEGIN
       temp <=     "0100000000000000000000010000000" when OP_Code = "11" and  Function_Code ="001" and Interrupt_in ='0' --and Reset_in = '0'
            
            else   "0100000000000000000000100000000" when OP_Code = "11" and  Function_Code ="010" and Interrupt_in ='0' --and Reset_in = '0'
																														 --
            else   "0010000000000000000000000000000" when OP_Code = "11" and  Function_Code ="011" and Interrupt_in ='0' --and Reset_in = '0'
																														 --
            else   "0000000000000010000000001000000" when OP_Code = "11" and  Function_Code ="100" and Interrupt_in ='0' --and Reset_in = '0'
																														 --
            else   "0000001010000000010000000000000" when OP_Code = "11" and  Function_Code ="101" and Interrupt_in ='0' --and Reset_in = '0'            
																														 --
            else   "0000010010000001100000001000000" when OP_Code = "11" and  Function_Code ="110" and Interrupt_in ='0' --and Reset_in = '0'                        
																														 --
            else   "1000000000000000001100001000001" when OP_Code = "10" and  Function_Code ="000" and Interrupt_in ='0' --and Reset_in = '0'                                      
																														 --
            else   "1100000000000000000000001000000" when OP_Code = "10" and  Function_Code ="001" and Interrupt_in ='0' --and Reset_in = '0'                                                  
																														 --
            else   "1100000000000000000001001000000" when OP_Code = "10" and  Function_Code ="010" and Interrupt_in ='0' --and Reset_in = '0'                                                  
																														 --
            else   "1100000000000000000100001000000" when OP_Code = "10" and  Function_Code ="011" and Interrupt_in ='0' --and Reset_in = '0'                                                             
																														 --
            else   "1100000000000000000101001000000" when OP_Code = "10" and  Function_Code ="100" and Interrupt_in ='0' --and Reset_in = '0'              
																														 --
            else   "1100000000000100000110001000000" when OP_Code = "10" and  Function_Code ="101" and Interrupt_in ='0' --and Reset_in = '0'            
																														 --
            else   "1100000000000100000010001000000" when OP_Code = "10" and  Function_Code ="110" and Interrupt_in ='0' --and Reset_in = '0'                           
																														 --
            else   "1100000000000100000011001000000" when OP_Code = "10" and  Function_Code ="111" and Interrupt_in ='0' --and Reset_in = '0'                
																														 --
            else   "0100000000100000000000000000000" when OP_Code = "01" and  Function_Code ="000" and Interrupt_in ='0' --and Reset_in = '0'              
																														 --
            else   "0100000000001000000000000000000" when OP_Code = "01" and  Function_Code ="001" and Interrupt_in ='0' --and Reset_in = '0'                            
																														 --
            else   "0100000000010000000000000000000" when OP_Code = "01" and  Function_Code ="010" and Interrupt_in ='0' --and Reset_in = '0'                          
																														 --
            else   "0000000001000000000000000000000" when OP_Code = "01" and  Function_Code ="011" and Interrupt_in ='0' --and Reset_in = '0'
																														 --
            else   "0001000010000000010000000000000" when OP_Code = "01" and  Function_Code ="100" and Interrupt_in ='0' --and Reset_in = '0'                          
																														 --
            else   "0000100010000000100000000000000" when OP_Code = "01" and  Function_Code ="101" and Interrupt_in ='0' --and Reset_in = '0'
																														 --
            else   "0100000110000000100000000000000" when OP_Code = "01" and  Function_Code ="110" and Interrupt_in ='0' --and Reset_in = '0'
																														 --
            else   "1100000000000000000000001101000" when OP_Code = "00" and  Function_Code ="000" and Interrupt_in ='0' --and Reset_in = '0'  
																														 --
            else   "1100000000000100001000001101000" when OP_Code = "00" and  Function_Code ="001" and Interrupt_in ='0' --and Reset_in = '0'   
																														 --
            else   "1100000000000100001001001101000" when OP_Code = "00" and  Function_Code ="010" and Interrupt_in ='0' --and Reset_in = '0'   
																														 --
            else   "1000000000000000001101001110000" when OP_Code = "00" and  Function_Code ="011" and Interrupt_in ='0' --and Reset_in = '0'   
																														 --
            else   "1000000000000001101101001111000" when OP_Code = "00" and  Function_Code ="100" and Interrupt_in ='0' --and Reset_in = '0'   
																														 --
            else   "1000000000000000011101000111000" when OP_Code = "00" and  Function_Code ="101" and Interrupt_in ='0' --and Reset_in = '0'   
            
            --else   "00000000000000000000000000010" when Interrupt_in ='0' and Reset_in = '1'               
            
            else   "0000000010000000010000000000100" when Interrupt_in ='1' --and Reset_in = '0'               
            
            else   "0000000000000000000000000000000";  
            
            
            
            
       ALU_Enable           <= temp(30);  
       CCR_Enable           <= temp(29);     
       Output_Enable        <= temp(28);
       Call                 <= temp(27);
       RET                  <= temp(26);
       POP                  <= temp(25);                     
       PUSH                 <= temp(24);
       RTI                  <= temp(23);
       Stack_operation      <= temp(22);
       JMP                  <= temp(21);
       JMP_ZF               <= temp(20);
       JMP_CF               <= temp(19);
       JMP_NF               <= temp(18);
       Reg_Dst_selector     <= temp(17);
       WB                   <= temp(16 downto 15);
       MEM                  <= temp(14 downto 13);
       EX                   <= temp(12 downto  9);
       Selector_set_carry   <= temp(8  downto  7);
       Write_Enable         <= temp(6);
       Regsrc2_Control      <= temp(5);
       Sign_Extend_Enable   <= temp(4  downto  3);
       Interrupt_out        <= temp(2);
       --Reset_out            <= temp(1);
       Swap_Enable          <= temp(0);                          
End arch_Control;    

