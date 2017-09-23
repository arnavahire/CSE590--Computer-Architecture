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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GuessingGame is
    Port (switch: in STD_LOGIC_VECTOR(15 downto 0);
          LED: out STD_LOGIC_VECTOR(15 downto 0):="0000000000000000";
          btnD: in std_logic;
          an: out STD_LOGIC_VECTOR(3 downto 0):="0000";
          seg: out STD_LOGIC_VECTOR(6 downto 0);
          CLK100MHZ: in std_logic
          );
end GuessingGame;

architecture Behavioral of GuessingGame is

component ClockDivider is
    port(normalclock: in std_logic;
         slowclock: out std_logic);
end component;

signal lowspeedclock: std_logic;
signal switch0: std_logic_vector(3 downto 0);
signal switch1: std_logic_vector(3 downto 0);
signal switch2: std_logic_vector(3 downto 0);
signal switch3: std_logic_vector(3 downto 0);
signal temp: std_logic_vector(15 downto 0);

begin

sample: ClockDivider port map (normalclock=>CLK100MHZ, slowclock=>lowspeedclock); 

switch0<=switch(3 downto 0);
switch1<=switch(7 downto 4);
switch2<=switch(11 downto 8);
switch3<=switch(15 downto 12);

process1: process(lowspeedclock,btnD)
variable cnt : integer:= -1;
variable counter : integer:= 0;
variable delay : integer:= 0;
variable LEDdelay : integer:= 0;
variable operand1 : std_logic_vector(15 downto 0):="0000000000000000";
variable operand2 : std_logic_vector(15 downto 0):="0000000000000000";
variable large : std_logic:= '0'; -- to show '2 HI' msg on seven segment display
variable small : std_logic:= '0'; -- to show '2 LO' msg on seven segment display
variable guess : integer:=0;
variable finalGuessVector : std_logic_vector(15 downto 0):="0000000000000000";
variable Guess0 : std_logic_vector(3 downto 0);
variable Guess1 : std_logic_vector(3 downto 0);
variable Guess2 : std_logic_vector(3 downto 0);
variable Guess3 : std_logic_vector(3 downto 0);
variable flag :  integer:=0;

begin
if rising_edge(lowspeedclock) then

cnt:=cnt+1;
LED<="0000000000000000";
--------------------------------------------- Code for program logic ---------------------------------------------------------
delay:=delay+1;
LEDdelay:=LEDdelay+1;
if delay>=400 then

if btnD = '1' then

if counter = 0 then
operand1:=switch;
delay:=0;
counter:=counter+1;
flag:=0;

elsif counter = 1 then
operand2:=switch;
delay:=0;
counter:=counter+1;
flag:=0;
end if; --counter code ends

if counter = 2 then
delay:=0;
if operand1 = operand2 then -- when operand 2 is equal to operand1 then we wil brighten all LEDs and display number of guesses taken on seven segment display
guess:=guess+1;
counter:=100;
large:='0';
small:='0';
finalGuessVector:=std_logic_vector(to_unsigned(guess,finalGuessVector'length));
Guess0:=finalGuessVector(3 downto 0);
Guess1:=finalGuessVector(7 downto 4);
Guess2:=finalGuessVector(11 downto 8);
Guess3:=finalGuessVector(15 downto 12);

elsif operand2 > operand1 then -- when operand 2 is greater than operand1 then we wil display msg '2 HI' on seven segment display
large:='1';
small:='0';
counter:=1;
guess:=guess+1;  -- increase guess for each wrong attempt
elsif operand2 < operand1 then -- when operand 2 is smaller than operand1 then we wil display msg '2 LO' on seven segment display
small:='1';
large:='0';
counter:=1;
guess:=guess+1; -- increase guess for each wrong attempt
end if; -- equality check for operands ends

end if; -- counter = 2 code ends

end if; -- btnD = 1 code end

--if btnD = '0' then

if counter = 0 then
LED<=switch;
elsif counter = 1 then
LED<=switch;
elsif counter = 100 then

if LEDdelay>=100 then
LED<="1111111111111111";
LEDdelay:=0;
end if;

end if; -- counter = 100 code ends

--end if; --btnD = 0 code ends

end if; -- Delay code ends
-----------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------ Code for display --------------------------------------------------------------

if cnt = 0 then
an<="1110";

if flag = 1 then
if counter /= 100 then
    if switch0 = "0000" then seg<="1000000";
    elsif switch0 = "0001" then seg<="1111001";
    elsif switch0 = "0010" then seg<="0100100";
    elsif switch0 = "0011" then seg<="0110000";
    elsif switch0 = "0100" then seg<="0011001";
    elsif switch0 = "0101" then seg<="0010010";
    elsif switch0 = "0110" then seg<="0000010";
    elsif switch0 = "0111" then seg<="1111000";
    elsif switch0 = "1000" then seg<="0000000";
    elsif switch0 = "1001" then seg<="0010000";
    elsif switch0 = "1010" then seg<="0001000";
    elsif switch0 = "1011" then seg<="0000011";
    elsif switch0 = "1100" then seg<="1000110";
    elsif switch0 = "1101" then seg<="0100001";
    elsif switch0 = "1110" then seg<="0000110";
    elsif switch0 = "1111" then seg<="0001110";
    end if; -- switch0 code ends
end if;

elsif flag = 0 then
if counter = 0 then
        seg<="1111001";  -- display 1 on anode 0
elsif counter = 1 and large = '1' then
        seg<="1111001"; --display I on anode 0
elsif counter = 1 and small = '1' then
        seg<="1000000"; --display O on anode 0
elsif counter = 1 then
        seg<="0100100";  -- display 2 on anode 0
elsif counter = 100 then
    if Guess0 = "0000" then seg<="1000000";
    elsif Guess0 = "0001" then seg<="1111001";
    elsif Guess0 = "0010" then seg<="0100100";
    elsif Guess0 = "0011" then seg<="0110000";
    elsif Guess0 = "0100" then seg<="0011001";
    elsif Guess0 = "0101" then seg<="0010010";
    elsif Guess0 = "0110" then seg<="0000010";
    elsif Guess0 = "0111" then seg<="1111000";
    elsif Guess0 = "1000" then seg<="0000000";
    elsif Guess0 = "1001" then seg<="0010000";
    elsif Guess0 = "1010" then seg<="0001000";
    elsif Guess0 = "1011" then seg<="0000011";
    elsif Guess0 = "1100" then seg<="1000110";
    elsif Guess0 = "1101" then seg<="0100001";
    elsif Guess0 = "1110" then seg<="0000110";
    elsif Guess0 = "1111" then seg<="0001110";
    end if; -- Guess1 code ends
end if;
end if; -- flag = 0 code ends 

elsif cnt = 1 then

if flag = 1 then
an<="1101";
if counter /= 100 then
    if switch1 = "0000" then seg<="1000000";
    elsif switch1 = "0001" then seg<="1111001";
    elsif switch1 = "0010" then seg<="0100100";
    elsif switch1 = "0011" then seg<="0110000";
    elsif switch1 = "0100" then seg<="0011001";
    elsif switch1 = "0101" then seg<="0010010";
    elsif switch1 = "0110" then seg<="0000010";
    elsif switch1 = "0111" then seg<="1111000";
    elsif switch1 = "1000" then seg<="0000000";
    elsif switch1 = "1001" then seg<="0010000";
    elsif switch1 = "1010" then seg<="0001000";
    elsif switch1 = "1011" then seg<="0000011";
    elsif switch1 = "1100" then seg<="1000110";
    elsif switch1 = "1101" then seg<="0100001";
    elsif switch1 = "1110" then seg<="0000110";
    elsif switch1 = "1111" then seg<="0001110";
    end if; -- switch1 code ends
end if;

elsif flag = 0 then
if counter = 0 then
an<="1111"; -- display nothing on this anode
elsif counter = 1 and large = '1' then
        an<="1101";
        seg<="0001001"; -- display H on anode 1
elsif counter = 1 and small ='1' then
        an<="1101";
        seg<="1000111"; -- display L on anode 1
elsif counter= 1 then
        an<="1111"; -- display nothing on this anode  
elsif counter = 100 then
an<="1101";
    if Guess1 = "0000" then seg<="1000000";
    elsif Guess1 = "0001" then seg<="1111001";
    elsif Guess1 = "0010" then seg<="0100100";
    elsif Guess1 = "0011" then seg<="0110000";
    elsif Guess1 = "0100" then seg<="0011001";
    elsif Guess1 = "0101" then seg<="0010010";
    elsif Guess1 = "0110" then seg<="0000010";
    elsif Guess1 = "0111" then seg<="1111000";
    elsif Guess1 = "1000" then seg<="0000000";
    elsif Guess1 = "1001" then seg<="0010000";
    elsif Guess1 = "1010" then seg<="0001000";
    elsif Guess1 = "1011" then seg<="0000011";
    elsif Guess1 = "1100" then seg<="1000110";
    elsif Guess1 = "1101" then seg<="0100001";
    elsif Guess1 = "1110" then seg<="0000110";
    elsif Guess1 = "1111" then seg<="0001110";
    end if; -- Guess1 code ends                
end if;
end if; -- flag = 0 code ends

elsif cnt = 2 then

if flag = 1 then
an<="1011";
if counter /= 100 then
    if switch2 = "0000" then seg<="1000000";
    elsif switch2 = "0001" then seg<="1111001";
    elsif switch2 = "0010" then seg<="0100100";
    elsif switch2 = "0011" then seg<="0110000";
    elsif switch2 = "0100" then seg<="0011001";
    elsif switch2 = "0101" then seg<="0010010";
    elsif switch2 = "0110" then seg<="0000010";
    elsif switch2 = "0111" then seg<="1111000";
    elsif switch2 = "1000" then seg<="0000000";
    elsif switch2 = "1001" then seg<="0010000";
    elsif switch2 = "1010" then seg<="0001000";
    elsif switch2 = "1011" then seg<="0000011";
    elsif switch2 = "1100" then seg<="1000110";
    elsif switch2 = "1101" then seg<="0100001";
    elsif switch2 = "1110" then seg<="0000110";
    elsif switch2 = "1111" then seg<="0001110";
    end if; -- switch2 code ends
end if;

elsif flag = 0 then
if counter = 0 then
an<="1011";
seg<="1000111"; -- display L on anode 2
elsif counter = 1 and large = '1' then
        an<="1111"; -- display nothing on this anode
elsif counter = 1 and small = '1' then
        an<="1111"; -- display nothing on this anode
elsif counter = 1 then
        an<="1011";
        seg<="1000111"; -- display L on anode 2 
elsif counter = 100 then
an<="1011";
    if Guess2 = "0000" then seg<="1000000";
    elsif Guess2 = "0001" then seg<="1111001";
    elsif Guess2 = "0010" then seg<="0100100";
    elsif Guess2 = "0011" then seg<="0110000";
    elsif Guess2 = "0100" then seg<="0011001";
    elsif Guess2 = "0101" then seg<="0010010";
    elsif Guess2 = "0110" then seg<="0000010";
    elsif Guess2 = "0111" then seg<="1111000";
    elsif Guess2 = "1000" then seg<="0000000";
    elsif Guess2 = "1001" then seg<="0010000";
    elsif Guess2 = "1010" then seg<="0001000";
    elsif Guess2 = "1011" then seg<="0000011";
    elsif Guess2 = "1100" then seg<="1000110";
    elsif Guess2 = "1101" then seg<="0100001";
    elsif Guess2 = "1110" then seg<="0000110";
    elsif Guess2 = "1111" then seg<="0001110";
    end if; -- Guess2 code ends
end if;
end if; --flag = 0 code ends

elsif cnt = 3 then

if flag = 1 then
an<="0111";
if counter /= 100 then
    if switch3 = "0000" then seg<="1000000";
    elsif switch3 = "0001" then seg<="1111001";
    elsif switch3 = "0010" then seg<="0100100";
    elsif switch3 = "0011" then seg<="0110000";
    elsif switch3 = "0100" then seg<="0011001";
    elsif switch3 = "0101" then seg<="0010010";
    elsif switch3 = "0110" then seg<="0000010";
    elsif switch3 = "0111" then seg<="1111000";
    elsif switch3 = "1000" then seg<="0000000";
    elsif switch3 = "1001" then seg<="0010000";
    elsif switch3 = "1010" then seg<="0001000";
    elsif switch3 = "1011" then seg<="0000011";
    elsif switch3 = "1100" then seg<="1000110";
    elsif switch3 = "1101" then seg<="0100001";
    elsif switch3 = "1110" then seg<="0000110";
    elsif switch3 = "1111" then seg<="0001110";
    end if; -- switch3 code ends
end if;

elsif flag = 0 then
if counter = 0 then
an<="0111";
seg<="0001100"; -- display P on anode 3
elsif counter = 1 and large = '1' then
        an<="0111";
        seg<="0100100";  -- display 2 on anode 3
elsif counter = 1 and small = '1' then
        an<="0111";
        seg<="0100100";  -- display 2 on anode 3
elsif counter = 1 then
        an<="0111";
        seg<="0001100"; -- display P on anode 3
elsif counter = 100 then
an<="0111";
    if Guess3 = "0000" then seg<="1000000";
    elsif Guess3 = "0001" then seg<="1111001";
    elsif Guess3 = "0010" then seg<="0100100";
    elsif Guess3 = "0011" then seg<="0110000";
    elsif Guess3 = "0100" then seg<="0011001";
    elsif Guess3 = "0101" then seg<="0010010";
    elsif Guess3 = "0110" then seg<="0000010";
    elsif Guess3 = "0111" then seg<="1111000";
    elsif Guess3 = "1000" then seg<="0000000";
    elsif Guess3 = "1001" then seg<="0010000";
    elsif Guess3 = "1010" then seg<="0001000";
    elsif Guess3 = "1011" then seg<="0000011";
    elsif Guess3 = "1100" then seg<="1000110";
    elsif Guess3 = "1101" then seg<="0100001";
    elsif Guess3 = "1110" then seg<="0000110";
    elsif Guess3 = "1111" then seg<="0001110";
    end if; -- Guess1 code ends
end if;
end if; -- flag = 0 code ends
cnt:=-1;
end if; -- cnt code ends
-----------------------------------------------------------------------------------------------------------------------------
end if; -- rising edge ends

if temp /= switch then
temp<=switch;
flag:=1;
end if;
end process;
end Behavioral;
