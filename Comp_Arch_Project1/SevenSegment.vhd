----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/20/2017 01:14:21 AM
-- Design Name: 
-- Module Name: SevenSegment - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 
USE IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SevenSegment is
    Port (switch0: in STD_LOGIC_VECTOR(3 downto 0);
          switch1: in STD_LOGIC_VECTOR(3 downto 0);
          switch2: in STD_LOGIC_VECTOR(3 downto 0);
          switch3: in STD_LOGIC_VECTOR(3 downto 0);
          LED0: out STD_LOGIC_VECTOR(3 downto 0);
          LED1: out STD_LOGIC_VECTOR(3 downto 0);
          LED2: out STD_LOGIC_VECTOR(3 downto 0);
          LED3: out STD_LOGIC_VECTOR(3 downto 0);
          btnC: in std_logic;
          an: out STD_LOGIC_VECTOR(3 downto 0);
          seg: out STD_LOGIC_VECTOR(6 downto 0);
          CLK100MHZ: in std_logic
          );
end SevenSegment;

architecture Behavioral of SevenSegment is

component FrequencyDivider is
    port(normalclock: in std_logic;
         slowclock: out std_logic);
end component;

signal output0: STD_LOGIC_VECTOR(6 downto 0);
signal output1: STD_LOGIC_VECTOR(6 downto 0);
signal output2: STD_LOGIC_VECTOR(6 downto 0);
signal output3: STD_LOGIC_VECTOR(6 downto 0);
signal lowspeedclock: std_logic;

begin

sample: FrequencyDivider port map (normalclock=>CLK100MHZ, slowclock=>lowspeedclock); 

LED0<=switch0;
LED1<=switch1;
LED2<=switch2;
LED3<=switch3;

myprocess: process(lowspeedclock, btnC)
variable cnt : integer:= -1;
variable temp0 : std_logic_vector(3 downto 0):="0000";
variable temp1 : std_logic_vector(3 downto 0):="0000";
variable temp2 : std_logic_vector(3 downto 0):="0000";
variable temp3 : std_logic_vector(3 downto 0):="0000";
begin

if rising_edge(lowspeedclock) then
cnt:=cnt+1;

if cnt = 0 then

if btnC ='1' then

temp0:=switch0;
temp1:=switch1;
temp2:=switch2;
temp3:=switch3;

an<="1110";
seg<=output0;
if switch0 = "0000" then output0<="1000000";
elsif switch0 = "0001" then output0<="1111001";
elsif switch0 = "0010" then output0<="0100100";
elsif switch0 = "0011" then output0<="0110000";
elsif switch0 = "0100" then output0<="0011001";
elsif switch0 = "0101" then output0<="0010010";
elsif switch0 = "0110" then output0<="0000010";
elsif switch0 = "0111" then output0<="1111000";
elsif switch0 = "1000" then output0<="0000000";
elsif switch0 = "1001" then output0<="0010000";
elsif switch0 = "1010" then output0<="0001000";
elsif switch0 = "1011" then output0<="0000011";
elsif switch0 = "1100" then output0<="1000110";
elsif switch0 = "1101" then output0<="0100001";
elsif switch0 = "1110" then output0<="0000110";
elsif switch0 = "1111" then output0<="0001110";
end if;

elsif btnC ='0' then
an<="1110";
seg<=output0;
if temp0 = "0000" then output0<="1000000";
elsif temp0 = "0001" then output0<="1111001";
elsif temp0 = "0010" then output0<="0100100";
elsif temp0 = "0011" then output0<="0110000";
elsif temp0 = "0100" then output0<="0011001";
elsif temp0 = "0101" then output0<="0010010";
elsif temp0 = "0110" then output0<="0000010";
elsif temp0 = "0111" then output0<="1111000";
elsif temp0 = "1000" then output0<="0000000";
elsif temp0 = "1001" then output0<="0010000";
elsif temp0 = "1010" then output0<="0001000";
elsif temp0 = "1011" then output0<="0000011";
elsif temp0 = "1100" then output0<="1000110";
elsif temp0 = "1101" then output0<="0100001";
elsif temp0 = "1110" then output0<="0000110";
elsif temp0 = "1111" then output0<="0001110";
end if;
end if;

end if; -- if cnt = 0 ends

if cnt = 1 then

if btnC ='1' then

temp0:=switch0;
temp1:=switch1;
temp2:=switch2;
temp3:=switch3;

an<="1101";
seg<=output1;
if switch1 = "0000" then output1<="1000000";
elsif switch1 = "0001" then output1<="1111001";
elsif switch1 = "0010" then output1<="0100100";
elsif switch1 = "0011" then output1<="0110000";
elsif switch1 = "0100" then output1<="0011001";
elsif switch1 = "0101" then output1<="0010010";
elsif switch1 = "0110" then output1<="0000010";
elsif switch1 = "0111" then output1<="1111000";
elsif switch1 = "1000" then output1<="0000000";
elsif switch1 = "1001" then output1<="0010000";
elsif switch1 = "1010" then output1<="0001000";
elsif switch1 = "1011" then output1<="0000011";
elsif switch1 = "1100" then output1<="1000110";
elsif switch1 = "1101" then output1<="0100001";
elsif switch1 = "1110" then output1<="0000110";
elsif switch1 = "1111" then output1<="0001110";
end if;

elsif btnC ='0' then
an<="1101";
seg<=output1;
if temp1 = "0000" then output1<="1000000";
elsif temp1 = "0001" then output1<="1111001";
elsif temp1 = "0010" then output1<="0100100";
elsif temp1 = "0011" then output1<="0110000";
elsif temp1 = "0100" then output1<="0011001";
elsif temp1 = "0101" then output1<="0010010";
elsif temp1 = "0110" then output1<="0000010";
elsif temp1 = "0111" then output1<="1111000";
elsif temp1 = "1000" then output1<="0000000";
elsif temp1 = "1001" then output1<="0010000";
elsif temp1 = "1010" then output1<="0001000";
elsif temp1 = "1011" then output1<="0000011";
elsif temp1 = "1100" then output1<="1000110";
elsif temp1 = "1101" then output1<="0100001";
elsif temp1 = "1110" then output1<="0000110";
elsif temp1 = "1111" then output1<="0001110";
end if;
end if;

end if; -- if cnt = 1 ends

if cnt = 2 then

if btnC = '1' then
temp0:=switch0;
temp1:=switch1;
temp2:=switch2;
temp3:=switch3;

an<="1011";
seg<=output2;
if switch2 = "0000" then output2<="1000000";
elsif switch2 = "0001" then output2<="1111001";
elsif switch2 = "0010" then output2<="0100100";
elsif switch2 = "0011" then output2<="0110000";
elsif switch2 = "0100" then output2<="0011001";
elsif switch2 = "0101" then output2<="0010010";
elsif switch2 = "0110" then output2<="0000010";
elsif switch2 = "0111" then output2<="1111000";
elsif switch2 = "1000" then output2<="0000000";
elsif switch2 = "1001" then output2<="0010000";
elsif switch2 = "1010" then output2<="0001000";
elsif switch2 = "1011" then output2<="0000011";
elsif switch2 = "1100" then output2<="1000110";
elsif switch2 = "1101" then output2<="0100001";
elsif switch2 = "1110" then output2<="0000110";
elsif switch2 = "1111" then output2<="0001110";
end if;

elsif btnC = '0' then
an<="1011";
seg<=output2;
if temp2 = "0000" then output2<="1000000";
elsif temp2 = "0001" then output2<="1111001";
elsif temp2 = "0010" then output2<="0100100";
elsif temp2 = "0011" then output2<="0110000";
elsif temp2 = "0100" then output2<="0011001";
elsif temp2 = "0101" then output2<="0010010";
elsif temp2 = "0110" then output2<="0000010";
elsif temp2 = "0111" then output2<="1111000";
elsif temp2 = "1000" then output2<="0000000";
elsif temp2 = "1001" then output2<="0010000";
elsif temp2 = "1010" then output2<="0001000";
elsif temp2 = "1011" then output2<="0000011";
elsif temp2 = "1100" then output2<="1000110";
elsif temp2 = "1101" then output2<="0100001";
elsif temp2 = "1110" then output2<="0000110";
elsif temp2 = "1111" then output2<="0001110";
end if;
end if;

end if; -- if cnt = 2 ends

if cnt = 3 then

if btnC = '1' then

temp0:=switch0;
temp1:=switch1;
temp2:=switch2;
temp3:=switch3;

an<="0111";
seg<=output3;
if switch3 = "0000" then output3<="1000000";
elsif switch3 = "0001" then output3<="1111001";
elsif switch3 = "0010" then output3<="0100100";
elsif switch3 = "0011" then output3<="0110000";
elsif switch3 = "0100" then output3<="0011001";
elsif switch3 = "0101" then output3<="0010010";
elsif switch3 = "0110" then output3<="0000010";
elsif switch3 = "0111" then output3<="1111000";
elsif switch3 = "1000" then output3<="0000000";
elsif switch3 = "1001" then output3<="0010000";
elsif switch3 = "1010" then output3<="0001000";
elsif switch3 = "1011" then output3<="0000011";
elsif switch3 = "1100" then output3<="1000110";
elsif switch3 = "1101" then output3<="0100001";
elsif switch3 = "1110" then output3<="0000110";
elsif switch3 = "1111" then output3<="0001110";
end if;
cnt:=-1;

elsif btnC ='0' then 
an<="0111";
seg<=output3;
if temp3 = "0000" then output3<="1000000";
elsif temp3 = "0001" then output3<="1111001";
elsif temp3 = "0010" then output3<="0100100";
elsif temp3 = "0011" then output3<="0110000";
elsif temp3 = "0100" then output3<="0011001";
elsif temp3 = "0101" then output3<="0010010";
elsif temp3 = "0110" then output3<="0000010";
elsif temp3 = "0111" then output3<="1111000";
elsif temp3 = "1000" then output3<="0000000";
elsif temp3 = "1001" then output3<="0010000";
elsif temp3 = "1010" then output3<="0001000";
elsif temp3 = "1011" then output3<="0000011";
elsif temp3 = "1100" then output3<="1000110";
elsif temp3 = "1101" then output3<="0100001";
elsif temp3 = "1110" then output3<="0000110";
elsif temp3 = "1111" then output3<="0001110";
end if;
cnt:=-1;
end if;

end if; -- if cnt = 3 ends

end if; -- if rising edge ends

end process;

end Behavioral;
