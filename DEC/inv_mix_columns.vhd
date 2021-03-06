library ieee;
use ieee.std_logic_1164.all;

entity inv_mix_columns is
	port (
		input: in std_logic_vector(127 downto 0);
		output: out std_logic_vector(127 downto 0)
	);
end inv_mix_columns;

architecture behavioral of inv_mix_columns is
	signal col_0, col_1, col_2, col_3: std_logic_vector(31 downto 0);
begin
	mix_col_0 : entity work.inv_mix_a_column
		port map(
			input  => input(127 downto 96),
			output => col_0
		);
	mix_col_1 : entity work.inv_mix_a_column
		port map(
			input  => input(95 downto 64),
			output => col_1
		);
	mix_col_2 : entity work.inv_mix_a_column
		port map(
			input  => input(63 downto 32),
			output => col_2
		);
	mix_col_3 : entity work.inv_mix_a_column
		port map(
			input  => input(31 downto 0),
			output => col_3
		);

	output(127 downto 96) <= col_0;
	output(95 downto 64) <= col_1;
	output(63 downto 32) <= col_2;
	output(31 downto 0) <= col_3;
end architecture behavioral;
