Library IEEE;
Use ieee.std_logic_1164.all;


Entity Preserved_CCR is
    port(rst,clk                      :in  std_logic;
         Interrupt                    :in  std_logic;
         RTI                          :in  std_logic;
         Flags_in                     :in  std_logic_vector (2 downto 0);
         Flags_Restor                 :out std_logic_vector (2 downto 0)
         );
End Entity Preserved_CCR;

Architecture arch_Preserved_CCR Of Preserved_CCR Is
    signal temp_Flags_Restor : std_logic_vector (2 downto 0);
    BEGIN
       process(clk,rst)
       begin
            if rst='1' then
               Flags_Restor <= (others=>'0');
            elsif rising_edge (clk) then 
                  if Interrupt='1' and RTI='0' then
                     temp_Flags_Restor<=Flags_in;
                     Flags_Restor<= (others=>'0');
                  else if RTI='1' and Interrupt='0' then
                     Flags_Restor<=temp_Flags_Restor;
                  end if;
                  end if;
            end if;  
        end process;
End arch_Preserved_CCR;      
         
