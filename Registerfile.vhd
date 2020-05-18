library ieee;
use ieee.std_logic_1164.all;

Entity RegisterFile is
  port(rst,clk                :in std_logic;
       WriteEnable            :in std_logic;
       SwapEnable             :in std_logic;
       Rsrc1,Rsrc2            :in std_logic_vector(2 downto 0);   --Address of Rscr1,Rscr2
       Rsrc1_Out,Rsrc2_Out    :out std_logic_vector(31 downto 0); --Output data to ALU
       WriteData1,WriteData2  :in  std_logic_vector(31 downto 0); --Data from writeback
       WriteReg1,WriteReg2    :in std_logic_vector(2 downto 0);    --Address of Reg1,Reg2 from writeback
       R0,R1,R2,R3,R4,R5,R6,R7:out std_logic_vector(31 downto 0) 
       );
End Entity;

Architecture arch_RegisterFile Of RegisterFile Is
      COMPONENT Registerr IS
      port(rst,clk,en  :in std_logic;
           datain      :in std_logic_vector(31 downto 0);
           dataout     :out std_logic_vector(31 downto 0)
           );
      END COMPONENT;
      ----------------------------------------------------------
      COMPONENT Decoder is
      port(en         :in std_logic;
         dinput       :in std_logic_vector(2 downto 0);
         doutput      :out std_logic_vector(7 downto 0)
         );
      End COMPONENT;
      ----------------------------------------------------------
      COMPONENT Mux2_1 is
      port(A,B :in std_logic_vector(31 downto 0);
           S   :in std_logic;
           Z   :out std_logic_vector(31 downto 0)
         );
      End COMPONENT;
      ----------------------------------------------------------
      COMPONENT OR_2 is
      port(A,B :in std_logic_vector(7 downto 0);
           Z   :out std_logic_vector(7 downto 0)
         );
      End COMPONENT;
      ----------------------------------------------------------
      COMPONENT Mux8_1 is
      port(A1,A2,A3,A4,A5,A6,A7,A8 :in std_logic_vector(31 downto 0);
         S                         :in std_logic_vector(2 downto 0);
         Z                         :out std_logic_vector(31 downto 0)
         );
      End COMPONENT;
      ----------------------------------------------------------
      SIGNAL WriteReg1_decoder_Output     : std_logic_vector(7 DOWNTO 0);
      SIGNAL WriteReg2_decoder_Output     : std_logic_vector(7 DOWNTO 0);
      SIGNAL Enables_of_Registers         : std_logic_vector(7 DOWNTO 0); 
      SIGNAL Temp1                        : std_logic_vector(7 DOWNTO 0); 
      SIGNAL MuxR1_out,MuxR2_out,
      MuxR3_out,MuxR4_out,MuxR5_out,
      MuxR6_out,MuxR7_out,MuxR8_out       : std_logic_vector(31 DOWNTO 0); 
	    
	    SIGNAL Selector_Mux2_1              : std_logic_vector(7 DOWNTO 0); 
	    SIGNAL R0_out,R1_out,R2_out,
	    R3_out,R4_out,R5_out,R6_out,R7_out  : std_logic_vector(31 DOWNTO 0);
BEGIN
	         
	         WriteReg1_Decoder  : Decoder port map (WriteEnable,WriteReg1,WriteReg1_decoder_Output);
	         WriteReg2_Decoder  : Decoder port map (WriteEnable,WriteReg2,Temp1); 
	        
           WriteReg2_decoder_Output <= "00000000"     WHEN WriteEnable ='1' and SwapEnable ='0'
                                    else  Temp1       WHEN WriteEnable ='1' and SwapEnable ='1';
           Selector_Mux2_1          <= "00000000"     WHEN WriteEnable ='1' and SwapEnable ='0'
	                                   else Temp1       WHEN WriteEnable ='1' and SwapEnable ='1';  

           -------------------------------- CREATING 8 INSTANCES MUX2_1 -----------------------------------------
           Mux_R1             : Mux2_1  port map (WriteData1,WriteData2,Selector_Mux2_1(0),MuxR1_out);
           Mux_R2             : Mux2_1  port map (WriteData1,WriteData2,Selector_Mux2_1(1),MuxR2_out);
           Mux_R3             : Mux2_1  port map (WriteData1,WriteData2,Selector_Mux2_1(2),MuxR3_out);
           Mux_R4             : Mux2_1  port map (WriteData1,WriteData2,Selector_Mux2_1(3),MuxR4_out);
           Mux_R5             : Mux2_1  port map (WriteData1,WriteData2,Selector_Mux2_1(4),MuxR5_out);
           Mux_R6             : Mux2_1  port map (WriteData1,WriteData2,Selector_Mux2_1(5),MuxR6_out);
           Mux_R7             : Mux2_1  port map (WriteData1,WriteData2,Selector_Mux2_1(6),MuxR7_out);
           Mux_R8             : Mux2_1  port map (WriteData1,WriteData2,Selector_Mux2_1(7),MuxR8_out);
                    
           WriteReg_OR        : OR_2    port map (WriteReg1_decoder_Output,WriteReg2_decoder_Output,Enables_of_Registers);
           -------------------------------- CREATING 8 INSTANCES Registers --------------------------------------
    	      R_0 : Registerr  port map (rst, clk, Enables_of_Registers(0), MuxR1_out, R0_out);  
           R_1 : Registerr  port map (rst, clk, Enables_of_Registers(1), MuxR2_out, R1_out);
           R_2 : Registerr  port map (rst, clk, Enables_of_Registers(2), MuxR3_out, R2_out);  
           R_3 : Registerr  port map (rst, clk, Enables_of_Registers(3), MuxR4_out, R3_out);
           R_4 : Registerr  port map (rst, clk, Enables_of_Registers(4), MuxR5_out, R4_out);  
           R_5 : Registerr  port map (rst, clk, Enables_of_Registers(5), MuxR6_out, R5_out);
           R_6 : Registerr  port map (rst, clk, Enables_of_Registers(6), MuxR7_out, R6_out);  
           R_7 : Registerr  port map (rst, clk, Enables_of_Registers(7), MuxR8_out, R7_out);
           
           -------------------------------- CREATING 2 INSTANCES MUX8_1 ----------------------------------------
           Mux_Rscr1:  Mux8_1  port map (R0_out,R1_out,R2_out,R3_out,R4_out,R5_out,R6_out,R7_out,Rsrc1,Rsrc1_Out);
           Mux_Rscr2:  Mux8_1  port map (R0_out,R1_out,R2_out,R3_out,R4_out,R5_out,R6_out,R7_out,Rsrc2,Rsrc2_Out);
           -------------------------------- Assigne output of registers ----------------------------------------
           R0 <= R0_out;
           R1 <= R1_out;
           R2 <= R2_out;
           R3 <= R3_out;
           R4 <= R4_out;
           R5 <= R5_out;
           R6 <= R6_out;
           R7 <= R7_out;
       

End arch_RegisterFile; 

