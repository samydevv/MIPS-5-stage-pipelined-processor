library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
  Entity MuxStall is
    port(ALU_Enable_in           : in std_logic;                       
         CCR_Enable_in           : in std_logic;                     
         Output_Enable_in        : in std_logic;                     
         Call_in                 : in std_logic;                     
         RET_in                  : in std_logic;                     
         POP_in                  : in std_logic;                     
         PUSH_in                 : in std_logic;                     
         RTI_in                  : in std_logic;                     
         Stack_operation_in      : in std_logic;                     
         JMP_in                  : in std_logic;                     
         JMP_ZF_in               : in std_logic;                     
         JMP_CF_in               : in std_logic;                     
         JMP_NF_in               : in std_logic;                     
         Reg_Dst_selector_in     : in std_logic;                     
         WB_in                   : in std_logic_vector(1  downto 0); 
         MEM_in                  : in std_logic_vector(1  downto 0); 
         EX_in                   : in std_logic_vector(3  downto 0); 
         Selector_set_carry_in   : in std_logic_vector(1  downto 0); 
         Write_Enable_in         : in std_logic;                     
         Regsrc2_Control_in      : in std_logic;                     
         Sign_Extend_Enable_in   : in std_logic_vector(1  downto 0); 
         Interrupt_out_in        : in std_logic;                     
         Input_Enable_in         : in std_logic;                     
         Swap_Enable_in          : in std_logic;                     
         
         -----outputs---------------------------------------------------------
         ALU_Enable_out           : out std_logic;                     
         CCR_Enable_out           : out std_logic;                     
         Output_Enable_out        : out std_logic;                     
         Call_out                 : out std_logic;                     
         RET_out                  : out std_logic;                     
         POP_out                  : out std_logic;                     
         PUSH_out                 : out std_logic;                     
         RTI_out                  : out std_logic;                     
         Stack_operation_out      : out std_logic;                     
         JMP_out                  : out std_logic;                     
         JMP_ZF_out               : out std_logic;                     
         JMP_CF_out               : out std_logic;                     
         JMP_NF_out               : out std_logic;                     
         Reg_Dst_selector_out     : out std_logic;                     
         WB_out                   : out std_logic_vector(1  downto 0); 
         MEM_out                  : out std_logic_vector(1  downto 0); 
         EX_out                   : out std_logic_vector(3  downto 0); 
         Selector_set_carry_out   : out std_logic_vector(1  downto 0); 
         Write_Enable_out         : out std_logic;                     
         Regsrc2_Control_out      : out std_logic;                     
         Sign_Extend_Enable_out   : out std_logic_vector(1  downto 0); 
         Interrupt_out_out        : out std_logic;                     
         Input_Enable_out         : out std_logic;                     
         Swap_Enable_out          : out std_logic;   
          LDD_Enable_in           : in std_logic;   
         LDD_Enable_out           : out std_logic; 
           
         Selector                 : in  std_logic
         );
  End MuxStall;
 
Architecture arch_MuxStall of MuxStall is 

   begin
         ALU_Enable_out           <= '0' WHEN Selector = '1'ELSE ALU_Enable_in;    							
         CCR_Enable_out           <='0' WHEN Selector = '1' ELSE CCR_Enable_in;
         Output_Enable_out        <='0' WHEN Selector = '1' ELSE Output_Enable_in;
         Call_out                 <='0' WHEN Selector = '1' ELSE Call_in;
         RET_out                  <='0' WHEN Selector = '1' ELSE RET_in;
         POP_out                  <='0' WHEN Selector = '1' ELSE POP_in;
         PUSH_out                 <='0' WHEN Selector = '1' ELSE PUSH_in;
         RTI_out                  <='0' WHEN Selector = '1' ELSE RTI_in;
         Stack_operation_out      <='0' WHEN Selector = '1' ELSE Stack_operation_in;
         JMP_out                  <='0' WHEN Selector = '1' ELSE JMP_in;
         JMP_ZF_out               <='0' WHEN Selector = '1' ELSE JMP_ZF_in;
         JMP_CF_out               <='0' WHEN Selector = '1' ELSE JMP_CF_in;
         JMP_NF_out               <='0' WHEN Selector = '1' ELSE JMP_NF_in;
         Reg_Dst_selector_out     <='0' WHEN Selector = '1' ELSE Reg_Dst_selector_in;
         WB_out                   <=(others =>'0') WHEN Selector = '1' ELSE WB_in;
         MEM_out                  <=(others =>'0') WHEN Selector = '1' ELSE MEM_in;
         EX_out                   <=(others =>'0') WHEN Selector = '1' ELSE EX_in;
         Selector_set_carry_out   <=(others =>'0') WHEN Selector = '1' ELSE Selector_set_carry_in;
         Write_Enable_out         <='0' WHEN Selector = '1' ELSE Write_Enable_in;
         Regsrc2_Control_out      <='0' WHEN Selector = '1' ELSE Regsrc2_Control_in;
         Sign_Extend_Enable_out   <=(others =>'0') WHEN Selector = '1' ELSE Sign_Extend_Enable_in;
         Interrupt_out_out        <='0' WHEN Selector = '1' ELSE Interrupt_out_in;
         Input_Enable_out         <='0' WHEN Selector = '1' ELSE Input_Enable_in;          
         Swap_Enable_out          <='0' WHEN Selector = '1' ELSE Swap_Enable_in;
         LDD_Enable_out           <='0' WHEN Selector = '1' ELSE LDD_Enable_in;
         
 End arch_MuxStall;


