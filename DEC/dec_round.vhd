library ieee;
use ieee.std_logic_1164.all;

entity dec_round is 
	port (
		input: in std_logic_vector(127 downto 0);
		key: in std_logic_vector(127 downto 0);
		output: out std_logic_vector(127 downto 0)
	);
end dec_round;

architecture behavioral of dec_round is
	signal input_invsubbyte, output_invsubbyte: std_logic_vector(127 downto 0);
	signal input_invshiftrow, output_invshiftrow: std_logic_vector(127 downto 0);
	signal input_invmixcolumn, output_invmixcolumn: std_logic_vector(127 downto 0);
	signal input_addroundkey, output_addroundkey: std_logic_vector(127 downto 0);
	signal key_round: std_logic_vector(127 downto 0);
	--signal ciphertext: std_logic_vector(127 downto 0);
begin
	input_invshiftrow <= input;
	key_round <= key;
	isr: entity work.inv_shift_rows
		port map(
			input => input_invshiftrow,
			output => output_invshiftrow
		);
	input_invsubbyte <= output_invshiftrow;
	isb: entity work.inv_sub_bytes
		port map(
			input_data => input_invsubbyte,
			output_data => output_invsubbyte
		);
	input_addroundkey <= output_invsubbyte;
	ark: entity work.add_roundkey
		port map(
			input1 => input_addroundkey,
			input2 => key_round,
			output => output_addroundkey
		);
	input_invmixcolumn <= output_addroundkey;
	imc: entity work.inv_mix_columns
		port map(
			input => input_invmixcolumn,
			output => output_invmixcolumn
			);
	output <= output_invmixcolumn;
end architecture behavioral;
