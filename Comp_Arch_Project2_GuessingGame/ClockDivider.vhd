----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/19/2017 11:54:44 AM
-- Design Name: 
-- Module Name: SimulateFlipFlop - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ClockDivider is
port(--LED0: out std_logic;
    normalclock: in std_logic;
    slowclock: out std_logic);
end ClockDivider;

architecture Behavioral of ClockDivider is

component DFlipFlop is 
    port(  clk : in STD_LOGIC;
           q : out STD_LOGIC);
end component;

--signal clock: std_logic := '0';
signal y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16,y17,y18,y19,y20,y21,y22,y23: std_logic;

begin
--clock<= not clock after 10 ns;
uut1: DFlipFlop port map (clk=>normalclock,q=>y1);
uut2: DFlipFlop port map (clk=>y1,q=>y2);
uut3: DFlipFlop port map (clk=>y2,q=>y3);
uut4: DFlipFlop port map (clk=>y3,q=>y4);
uut5: DFlipFlop port map (clk=>y4,q=>y5);
uut6: DFlipFlop port map (clk=>y5,q=>y6);
uut7: DFlipFlop port map (clk=>y6,q=>y7);
uut8: DFlipFlop port map (clk=>y7,q=>y8);
uut9: DFlipFlop port map (clk=>y8,q=>y9);
uut10: DFlipFlop port map (clk=>y9,q=>y10);
uut11: DFlipFlop port map (clk=>y10,q=>y11);
uut12: DFlipFlop port map (clk=>y11,q=>y12);
uut13: DFlipFlop port map (clk=>y12,q=>y13);
uut14: DFlipFlop port map (clk=>y13,q=>y14);
uut15: DFlipFlop port map (clk=>y14,q=>y15);
uut16: DFlipFlop port map (clk=>y15,q=>y16);
uut17: DFlipFlop port map (clk=>y16,q=>y17);
uut18: DFlipFlop port map (clk=>y17,q=>y18);
--uut19: DFlipFlop port map (clk=>y18,q=>y19);
--uut20: DFlipFlop port map (clk=>y19,q=>y20);
--uut21: DFlipFlop port map (clk=>y20,q=>y21);
--uut22: DFlipFlop port map (clk=>y21,q=>y22);
--uut23: DFlipFlop port map (clk=>y22,q=>y23);

slowclock<=y18;
--LED0<=y23;

end Behavioral;
