library ieee;
use ieee.std_logic_1164.all;

entity inv_mix_a_column is
	port (
		input: in std_logic_vector(31 downto 0);
		output: out std_logic_vector(31 downto 0)
	);
end inv_mix_a_column;

architecture behavioral of inv_mix_a_column is
	signal temp0_9, temp0_11, temp0_13, temp0_14: std_logic_vector(7 downto 0);
	signal temp1_9, temp1_11, temp1_13, temp1_14: std_logic_vector(7 downto 0);
	signal temp2_9, temp2_11, temp2_13, temp2_14: std_logic_vector(7 downto 0);
	signal temp3_9, temp3_11, temp3_13, temp3_14: std_logic_vector(7 downto 0);
begin	
	mul_09 : entity work.mul9
		port map(
			input  => input(7 downto 0),
			output => temp0_9
		);
	mul_011 : entity work.mul11
		port map(
			input  => input(23 downto 16),
			output => temp0_11
		);
	mul_013 : entity work.mul13
		port map(
			input  => input(15 downto 8),
			output => temp0_13
		);
	mul_014 : entity work.mul14
		port map(
			input  => input(31 downto 24),
			output => temp0_14
		);

	mul_19 : entity work.mul9
		port map(
			input  => input(31 downto 24),
			output => temp1_9
		);
	mul_111 : entity work.mul11
		port map(
			input  => input(15 downto 8),
			output => temp1_11
		);
	mul_113 : entity work.mul13
		port map(
			input  => input(7 downto 0),
			output => temp1_13
		);
	mul_114 : entity work.mul14
		port map(
			input  => input(23 downto 16),
			output => temp1_14
		);

	mul_29 : entity work.mul9
		port map(
			input  => input(23 downto 16),
			output => temp2_9
		);
	mul_211 : entity work.mul11
		port map(
			input  => input(7 downto 0),
			output => temp2_11
		);
	mul_213 : entity work.mul13
		port map(
			input  => input(31 downto 24),
			output => temp2_13
		);
	mul_214 : entity work.mul14
		port map(
			input  => input(15 downto 8),
			output => temp2_14
		);

	mul_39 : entity work.mul9
		port map(
			input  => input(15 downto 8),
			output => temp3_9
		);
	mul_311 : entity work.mul11
		port map(
			input  => input(31 downto 24),
			output => temp3_11
		);
	mul_313 : entity work.mul13
		port map(
			input  => input(23 downto 16),
			output => temp3_13
		);
	mul_314 : entity work.mul14
		port map(
			input  => input(7 downto 0),
			output => temp3_14
		);
	
	output(31 downto 24) <= temp0_9 xor temp0_11 xor temp0_13 xor temp0_14;
	output(23 downto 16) <= temp1_9 xor temp1_11 xor temp1_13 xor temp1_14;
	output(15 downto 8) <= temp2_9 xor temp2_11 xor temp2_13 xor temp2_14;
	output(7 downto 0) <= temp3_9 xor temp3_11 xor temp3_13 xor temp3_14;

end architecture behavioral;
