Library IEEE;
Use ieee.std_logic_1164.all;


Entity CCR is
    port(rst,clk                      :in  std_logic;
         Cin,Nin,Zin                  :in  std_logic;
         Reset_CF,Reset_ZF,Reset_NF   :in  std_logic;
         RTI                          :in  std_logic;
         Flags_Restor                 :in  std_logic_vector (2 downto 0);
         Flags_out                    :out std_logic_vector (2 downto 0);
         Enable                       :in  std_logic);
End Entity CCR;

Architecture arch_CCR Of CCR Is
    signal C_out,Z_out,N_out : std_logic; 
    BEGIN
         C_out <= '0' when Reset_CF = '1' else  --and Enable ='1' else
                  Cin ; --when Enable ='1';  
         Z_out <= '0' when Reset_ZF = '1'else -- and Enable ='1' else
                  Zin ; --when Enable ='1';
         N_out <= '0' when Reset_NF = '1' else -- and Enable ='1' else
                  Nin; --when Enable ='1';                                    
         process(clk,rst)
         begin
              if rst='1' then           
                 Flags_out <= (others=>'0');
              elsif rising_edge (clk) then 
                  if RTI='0' then
                     if Enable ='1' then
                     Flags_out<= C_out & Z_out & N_out;
                     end if;
                  else
                      Flags_out <= Flags_Restor;
                  end if;
              end if;  
        end process;
        
                  
End arch_CCR;      
         
