library ieee;
use ieee.std_logic_1164.all;

entity mix_a_column is
	port (
		input: in std_logic_vector(31 downto 0);
		output: out std_logic_vector(31 downto 0)
	);
end mix_a_column;

architecture behavioral of mix_a_column is
	signal temp0_2, temp0_3: std_logic_vector(7 downto 0);
	signal temp1_2, temp1_3: std_logic_vector(7 downto 0);
	signal temp2_2, temp2_3: std_logic_vector(7 downto 0);
	signal temp3_2, temp3_3: std_logic_vector(7 downto 0);
begin	
	mul_02 : entity work.mul2
		port map(
			input  => input(31 downto 24),
			output => temp0_2
		);
	mul_03 : entity work.mul3
		port map(
			input  => input(23 downto 16),
			output => temp0_3
		);
	mul_12 : entity work.mul2
		port map(
			input  => input(23 downto 16),
			output => temp1_2
		);
	mul_13 : entity work.mul3
		port map(
			input  => input(15 downto 8),
			output => temp1_3
		);
	mul_22 : entity work.mul2
		port map(
			input  => input(15 downto 8),
			output => temp2_2
		);
	mul_23 : entity work.mul3
		port map(
			input  => input(7 downto 0),
			output => temp2_3
		);
	mul_32 : entity work.mul2
		port map(
			input  => input(7 downto 0),
			output => temp3_2
		);
	mul_33 : entity work.mul3
		port map(
			input  => input(31 downto 24),
			output => temp3_3
		);
	
	output(31 downto 24) <= temp0_2 xor temp0_3 xor input(15 downto 8) xor input(7 downto 0);
	output(23 downto 16) <= temp1_2 xor temp1_3 xor input(31 downto 24) xor input(7 downto 0);
	output(15 downto 8) <= temp2_2 xor temp2_3 xor input(31 downto 24) xor input(23 downto 16);
	output(7 downto 0) <= temp3_2 xor temp3_3 xor input(23 downto 16) xor input(15 downto 8);
end architecture behavioral;
