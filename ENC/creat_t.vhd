library ieee;
use ieee.std_logic_1164.all;

entity creat_t is
	port (		
		input : in std_logic_vector(31 downto 0);
		rcon_init: in std_logic_vector(31 downto 0);
		output : out std_logic_vector(31 downto 0)
	);
end creat_t;

architecture behavioral of creat_t is
	
	signal temp0, temp3: std_logic_vector(31 downto 0);
	signal temp1, temp2: std_logic_vector(127 downto 0);
begin
	temp0 <= input(23 downto 0) & input(31 downto 24);
	temp1 <= x"000000000000000000000000" & temp0(31 downto 0);
	sub_word: entity work.sub_bytes
		port map(
			input_data => temp1,
			output_data => temp2
		);
	temp3 <= temp2(31 downto 0);
	output <= temp3 xor rcon_init;
	
end architecture behavioral;
