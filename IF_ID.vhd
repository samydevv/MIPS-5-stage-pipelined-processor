LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

Entity IF_ID is
    port(
       rst,clk        :in std_logic;
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
       PC_Plus_2_1_out: out std_logic_vector(31 downto 0)
        );
End Entity IF_ID;


Architecture arch_IF_ID Of IF_ID Is
  BEGIN
       process(clk,rst)
       begin
            if rst='1' then
               PC_out          <= (others =>'0');
               PC_Plus_2_1_out <= (others =>'0');
               OP_Code         <= (others =>'0');
               Function_Code   <= (others =>'0');
               Rscr1_Address   <= (others =>'0');
               Rscr2_Address   <= (others =>'0');
               Rdst_Address    <= (others =>'0');
               Imm_EA          <= (others =>'0');
               
            elsif rising_edge (clk) then    
               PC_out         <= PC_in;
               PC_Plus_2_1_out <= PC_Plus_2_1_in; 
               OP_Code        <= Instruction_in(31 downto 30);
               Function_Code  <= Instruction_in(29 downto 27);
               Rscr1_Address  <= Instruction_in(23 downto 21);
               Rscr2_Address  <= Instruction_in(20 downto 18);
               Rdst_Address   <= Instruction_in(26 downto 24);
               Imm_EA         <= Instruction_in(20 downto  1);  
            end if;
          end process;
                 
End arch_IF_ID;    
