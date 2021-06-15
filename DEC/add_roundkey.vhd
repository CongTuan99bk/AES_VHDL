library ieee;
use ieee.std_logic_1164.all;

entity add_roundkey is
	port (
		input1 : in std_logic_vector(127 downto 0);
		input2 : in std_logic_vector(127 downto 0);
		output : out std_logic_vector(127 downto 0)
	);
end add_roundkey;

architecture behavioral of add_roundkey is
	
begin
	output <= input1 xor input2;		
end architecture behavioral;
