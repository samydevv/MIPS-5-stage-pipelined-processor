library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity Control is
  port(      ------input to control uint---------
       OP_Code              : in std_logic_vector(1  downto 0); 
       Function_Code        : in std_logic_vector(2  downto 0);
       Interrupt_in         : in std_logic;
       Reset_in             : in std_logic;
             ------output of control uint---------
       Output_Enable        : out std_logic;                     --temp(27)
       Call                 : out std_logic;                     --temp(26)
       RET                  : out std_logic;                     --temp(25)
       POP                  : out std_logic;                     --temp(24)
       PUSH                 : out std_logic;                     --temp(23)
       RTI                  : out std_logic;                     --temp(22)
       Stack_operation      : out std_logic;                     --temp(21)
       JMP                  : out std_logic;                     --temp(20)
       JMP_ZF               : out std_logic;                     --temp(19)
       JMP_CF               : out std_logic;                     --temp(18)
       JMP_NF               : out std_logic;                     --temp(17)
       Reg_Dst_selector     : out std_logic;                     --temp(16)
       WB                   : out std_logic_vector(1  downto 0); --temp(15 downto 14)
       MEM                  : out std_logic_vector(1  downto 0); --temp(13 downto 12)   temp(13)=> ReadEnable ,temp(12)=> WriteEnable  
       EX                   : out std_logic_vector(3  downto 0); --temp(11 downto  8)
       Selector_set_carry   : out std_logic_vector(1  downto 0); --temp(7  downto  6)
       Write_Enable         : out std_logic;                     --temp(5)
       Regsrc2_Control      : out std_logic;                     --temp(4)
       Sign_Extend_Enable   : out std_logic;                     --temp(3)
       Interrupt_out        : out std_logic;                     --temp(2) 
       Reset_out            : out std_logic;                     --temp(1)
       Swap_Enable          : out std_logic                      --temp(0)
      );
End Entity Control;


Architecture arch_Control Of Control Is
  signal temp : std_logic_vector(27 downto 0); 
  BEGIN
       temp <=     "0000000000000000000001000000" when OP_Code = "11" and  Function_Code ="001" and Interrupt_in ='0' and Reset_in = '0'
            else   "0000000000000000000010000000" when OP_Code = "11" and  Function_Code ="010" and Interrupt_in ='0' and Reset_in = '0'
            else   "1000000000000000000000000000" when OP_Code = "11" and  Function_Code ="011" and Interrupt_in ='0' and Reset_in = '0'
            else   "0000000000001000000000100000" when OP_Code = "11" and  Function_Code ="100" and Interrupt_in ='0' and Reset_in = '0'
            else   "0000101000000001000000000000" when OP_Code = "11" and  Function_Code ="101" and Interrupt_in ='0' and Reset_in = '0'            
            else   "0001001000010110000000100000" when OP_Code = "11" and  Function_Code ="110" and Interrupt_in ='0' and Reset_in = '0'                        
            else   "0000000000000000000000000000";  
            
            
            
            
            
       Output_Enable        <= temp(27);
       Call                 <= temp(26);
       RET                  <= temp(25);
       POP                  <= temp(24);                     
       PUSH                 <= temp(23);
       RTI                  <= temp(22);
       Stack_operation      <= temp(21);
       JMP                  <= temp(20);
       JMP_ZF               <= temp(19);
       JMP_CF               <= temp(18);
       JMP_NF               <= temp(17);
       Reg_Dst_selector     <= temp(16);
       WB                   <= temp(15 downto 14);
       MEM                  <= temp(13 downto 12);
       EX                   <= temp(11 downto  8);
       Selector_set_carry   <= temp(7  downto  6);
       Write_Enable         <= temp(5);
       Regsrc2_Control      <= temp(4);
       Sign_Extend_Enable   <= temp(3);
       Interrupt_out        <= temp(2);
       Reset_out            <= temp(1);
       Swap_Enable          <= temp(0);                          
End arch_Control;    

