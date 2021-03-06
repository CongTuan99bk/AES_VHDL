library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_bench is 
end test_bench;

architecture behavioral of test_bench is

	component aes_dec is 
	port (
		clk: in std_logic;
		rst: in std_logic;
		input: in std_logic_vector(127 downto 0);
		key: in std_logic_vector(127 downto 0);
		output: out std_logic_vector(127 downto 0)
	);
end component;
		constant clock_frequency : integer := 100e6; --100MHz
		constant clock_period : time := 1000 ms / clock_frequency;
		signal clk : std_logic := '1';
		signal rst : std_logic := '0';
		signal input: std_logic_vector(127 downto 0);
		signal key: std_logic_vector(127 downto 0);
		signal output: std_logic_vector(127 downto 0);

begin
	clk <= not clk after clock_period/2;
	test: aes_dec port map (clk,rst,input,key,output);
	testing: process
	begin	
		input <= x"29C3505F571420F6402299B31A02D73A";
		key <= x"5468617473206D79204B756E67204675";	
		wait for 1 ps;
	end process;
end behavioral;
