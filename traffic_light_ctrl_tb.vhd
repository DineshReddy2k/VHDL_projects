library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity traffic_light_ctrl_tb is
end traffic_light_ctrl_tb;

architecture Behavioral of traffic_light_ctrl_tb is

component traffic_light_ctrl is
	port ( reset : in std_logic;
		   clk : in std_logic;
		   start : in std_logic;
		   red : out std_logic;
		   yellow : out std_logic;
		   green : out std_logic );
end component traffic_light_ctrl;

signal reset : std_logic := '0';
signal clk : std_logic := '0';
signal start : std_logic := '0';
signal red : std_logic := '0';
signal yellow : std_logic := '0';
signal green : std_logic := '0';
		   
constant clk_signal : time := 10 ns;

begin
	uut : traffic_light_ctrl
		port map( reset => reset,
				   clk => clk,
				   start => start,
				   red => red,
				   yellow => yellow,
				   green => green );

		clk_p : process
		begin
			clk <= '0';
			wait for clk_signal/2;
			clk <= '1';
			wait for clk_signal/2;
		end process clk_p;
		
		stim_p : process
		begin
			wait for clk_signal;
			reset <= '1';
			wait for clk_signal;
			reset <= '0';
			wait for clk_signal;
			start <= '1';
			wait for clk_signal * 20;
			start <= '0';
			wait for clk_signal;
			report " tlctsm test bench done";
			wait;
		end process stim_p;
		
end Behavioral;
