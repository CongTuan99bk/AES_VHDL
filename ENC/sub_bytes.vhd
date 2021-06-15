library ieee;
use ieee.std_logic_1164.all;

library work;
use work.all;

entity sub_bytes is
	port (
		input_data : in std_logic_vector(127 downto 0);
		output_data : out std_logic_vector(127 downto 0)
	);
end sub_bytes;

architecture behavioral of sub_bytes is

begin 
	gen : for i in 0 to 15 generate
		sbox_inst : entity work.sbox
			port map(
				input_data((i + 1)*8 - 1 downto i*8), -- portmap tu sbox sang sub_bytes
				output_data((i + 1)*8 - 1 downto i*8)
			);		
	end generate gen;
	
end architecture behavioral;
	
