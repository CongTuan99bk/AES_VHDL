library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity aes_dec is 
	port (
		clk : std_logic;
		rst: std_logic;
		input: in std_logic_vector(127 downto 0);
		key: in std_logic_vector(127 downto 0);
		output: out std_logic_vector(127 downto 0)
	);
end aes_dec;

architecture behavioral of aes_dec is
	signal key_temp: std_logic_vector(127 downto 0);
	signal ciphertext: std_logic_vector(127 downto 0);
	type tempround is array (1 to 10) of integer;
	constant temp_round: tempround:=(1,2,3,4,5,6,7,8,9,10);
	type output_array is array (1 to 10) of std_logic_vector(127 downto 0);
	signal output_temp : output_array;
	type outputround is array (1 to 10) of std_logic_vector(127 downto 0);
	signal output_round : outputround;
	type keyround is array (1 to 10) of std_logic_vector(127 downto 0);
	signal key_round : keyround;
	signal input1: std_logic_vector(127 downto 0);
	signal count: integer range 1 to 10;

begin
	ciphertext <= input;
	key_temp <= key;
	--add roundkey0
	kp0: entity work.key_expansion
		port map(
			key => key_temp,
			round => temp_round(10), 
			next_key => key_round(10)
		);	
	ark0: entity work.add_roundkey
		port map(
			input1 => ciphertext,
			input2 => key_round(10),
			output => input1
		);

	--dec round 1
	kp1: entity work.key_expansion
		port map(
			key => key_temp,
			round => temp_round(9), 
			next_key => key_round(9)
		);	
	dr1: entity work.dec_round
		port map(
			input => input1,
			key => key_round(9),
			output => output_round(1)
		);
	output_temp(1) <= output_round(1);

	--dec round 2
	kp2: entity work.key_expansion
		port map(
			key => key_temp,
			round => temp_round(8), 
			next_key => key_round(8)
		);	
	dr2: entity work.dec_round
		port map(
			input => output_round(1),
			key => key_round(8),
			output => output_round(2)
		);
	output_temp(2) <= output_round(2);

	--dec round 3
	kp3: entity work.key_expansion
		port map(
			key => key_temp,
			round => temp_round(7), 
			next_key => key_round(7)
		);	
	dr3: entity work.dec_round
		port map(
			input => output_round(2),
			key => key_round(7),
			output => output_round(3)
		);
	output_temp(3) <= output_round(3);

	--dec round 4
	kp4: entity work.key_expansion
		port map(
			key => key_temp,
			round => temp_round(6), 
			next_key => key_round(6)
		);	
	dr4: entity work.dec_round
		port map(
			input => output_round(3),
			key => key_round(6),
			output => output_round(4)
		);
	output_temp(4) <= output_round(4);

	--dec round 5
	kp5: entity work.key_expansion
		port map(
			key => key_temp,
			round => temp_round(5), 
			next_key => key_round(5)
		);	
	dr5: entity work.dec_round
		port map(
			input => output_round(4),
			key => key_round(5),
			output => output_round(5)
		);
	output_temp(5) <= output_round(5);

	--dec round 6
	kp6: entity work.key_expansion
		port map(
			key => key_temp,
			round => temp_round(4), 
			next_key => key_round(4)
		);	
	dr6: entity work.dec_round
		port map(
			input => output_round(5),
			key => key_round(4),
			output => output_round(6)
		);
	output_temp(6) <= output_round(6);

	--dec round 7
	kp7: entity work.key_expansion
		port map(
			key => key_temp,
			round => temp_round(3), 
			next_key => key_round(3)
		);	
	dr7: entity work.dec_round
		port map(
			input => output_round(6),
			key => key_round(3),
			output => output_round(7)
		);
	output_temp(7) <= output_round(7);

	--dec round 8
	kp8: entity work.key_expansion
		port map(
			key => key_temp,
			round => temp_round(2), 
			next_key => key_round(2)
		);	
	dr8: entity work.dec_round
		port map(
			input => output_round(7),
			key => key_round(2),
			output => output_round(8)
		);
	output_temp(8) <= output_round(8);

	--dec round 9
	kp9: entity work.key_expansion
		port map(
			key => key_temp,
			round => temp_round(1), 
			next_key => key_round(1)
		);	
	dr9: entity work.dec_round
		port map(
			input => output_round(8),
			key => key_round(1),
			output => output_round(9)
		);
	output_temp(9) <= output_round(9);

	--dec round 10
	dr10: entity work.dec_last_round
		port map(
			input => output_round(9),
			key => key_temp,
			output => output_round(10)
		);
	output_temp(10) <= output_round(10);

	process (clk, rst)
	begin
		if rst = '1' then
			count <= 1;
		elsif clk'event and clk = '1' then
			count <= count +1;
		end if;
	end process;
	output <= output_temp(count);
end architecture behavioral;
