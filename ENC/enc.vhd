library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity enc is 
	port (
		--clk: in std_logic;
		input: in std_logic_vector(127 downto 0);
		key: in std_logic_vector(127 downto 0);
		output: out std_logic_vector(127 downto 0)
	);
end enc;

architecture behavioral of enc is

	constant clock_frequency : integer := 100e6; --100MHz
	constant clock_period : time := 1000 ms / clock_frequency;
	signal clk : std_logic := '1';
	signal rst : std_logic := '0';
	--signal clr: std_logic_vector(127 downto 0); 
	signal temp_round : integer range 1 to 10;

	signal input_subbyte0,input_subbyte1, output_subbyte: std_logic_vector(127 downto 0);
	signal input_shiftrow, output_shiftrow: std_logic_vector(127 downto 0);
	signal input_mixcolumn, output_mixcolumn: std_logic_vector(127 downto 0);
	signal input_addroundkey, output_addroundkey: std_logic_vector(127 downto 0);
	signal key_round: std_logic_vector(127 downto 0);
	signal key_temp: std_logic_vector(127 downto 0);
	signal ciphertext: std_logic_vector(127 downto 0);
begin
	--clk <= clock;
	--clr <= x"00000000000000000000000000000000";  
	clk <= not clk after clock_period/2;
	ciphertext <= input;
	key_temp <= key;
	ark0: entity work.add_roundkey
		port map(
			input1 => ciphertext,
			input2 => key_temp,
			output => input_subbyte0
		);
	input_subbyte1 <= input_subbyte0;
	--input_subbyte2 <= input_subbyte0;
	kp: entity work.key_expansion
		port map(
			key => key_temp,
			round => temp_round, 
			next_key => key_round
		);	
	sb: entity work.sub_bytes
		port map(
			input_data => input_subbyte1,
			output_data => output_subbyte
		);
	--sb2: entity work.sub_bytes
		--port map(
			--input_data => input_subbyte2,
			--output_data => output_subbyte
		--);
	sr: entity work.shift_rows
		port map(
			input => output_subbyte,
			output => output_shiftrow
		);
	mc: entity work.mix_columns
		port map(
			input => output_shiftrow,
			output => output_mixcolumn
			);
	ark: entity work.add_roundkey
		port map(
			input1 => output_mixcolumn,
			input2 => key_round,
			output => output_addroundkey
		);
	--fb: entity work.feedback
		--port map(
			--input1 => output_addroundkey,
			--input2 => input_subbyte2,
			--output => input_subbyte1
		--);
	process (clk, rst)
	begin
		--clk <= not clk after clock_period/2;
		--ciphertext <= input;
		--key_temp <= key;
		--input_subbyte1 <= input_subbyte0;
		--temp_round <= 0;
		if rst = '1' then
			temp_round <= 1;
		elsif clk'event and clk = '1' then
			temp_round <= temp_round +1;
			--input_subbyte1 <= output_addroundkey;
			
		end if;
	--output <= output_addroundkey;
	end process;
	output <= output_addroundkey;
	--input_subbyte2 <= output_addroundkey;
end architecture behavioral;
