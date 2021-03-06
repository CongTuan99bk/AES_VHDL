library ieee;
use ieee.std_logic_1164.all;

entity enc_round is 
	port (
		input: in std_logic_vector(127 downto 0);
		key: in std_logic_vector(127 downto 0);
		output: out std_logic_vector(127 downto 0)
	);
end enc_round;

architecture behavioral of enc_round is
	signal input_subbyte, output_subbyte: std_logic_vector(127 downto 0);
	signal input_shiftrow, output_shiftrow: std_logic_vector(127 downto 0);
	signal input_mixcolumn, output_mixcolumn: std_logic_vector(127 downto 0);
	signal input_addroundkey, output_addroundkey: std_logic_vector(127 downto 0);
	signal key_round: std_logic_vector(127 downto 0);
	--signal ciphertext: std_logic_vector(127 downto 0);
begin
	input_subbyte <= input;
	key_round <= key;
	sb: entity work.sub_bytes
		port map(
			input_data => input_subbyte,
			output_data => output_subbyte
		);
	input_shiftrow <= output_subbyte;
	sr: entity work.shift_rows
		port map(
			input => input_shiftrow,
			output => output_shiftrow
		);
	input_mixcolumn <= output_shiftrow;
	mc: entity work.mix_columns
		port map(
			input => input_mixcolumn,
			output => output_mixcolumn
			);
	input_addroundkey <= output_mixcolumn;
	ark: entity work.add_roundkey
		port map(
			input1 => input_addroundkey,
			input2 => key_round,
			output => output_addroundkey
		);
		output <= output_addroundkey;
end architecture behavioral;