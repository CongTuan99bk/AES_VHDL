library ieee;
use ieee.std_logic_1164.all;

entity key_expansion is
	port (		
		key : in std_logic_vector(127 downto 0);
		round: in integer range 1 to 10;
		next_key : out std_logic_vector(127 downto 0)		
	);
end key_expansion;

architecture behavioral of key_expansion is
	type temp is array (1 to 10) of std_logic_vector(31 downto 0);
	signal t: temp; 
	type word is array (0 to 43) of std_logic_vector(31 downto 0);
	signal w: word;
	type round_key is array (0 to 10) of std_logic_vector(127 downto 0);
	signal round_key_init: round_key;
	type rcon is array (1 to 10) of std_logic_vector(31 downto 0);
	constant rcon_init: rcon:= (x"01000000",x"02000000",x"04000000",x"08000000",x"10000000",x"20000000",x"40000000",x"80000000",x"1B000000",x"36000000");
begin
	w(0) <= key(127 downto 96);
	w(1) <= key(95 downto 64);
	w(2) <= key(63 downto 32);
	w(3) <= key(31 downto 0);
	round_key_init(0) <= key;
	gen : for i in 1 to 10 generate
		creat_t_init : entity work.creat_t
			port map(
				input => w(4*i-1),
				rcon_init => rcon_init(i),
				output => t(4*i/4)
			);	
		w(4*i) <= t(4*i/4) xor w(4*i-4);
		w(4*i+1) <= w(4*i) xor w(4*i-3);
		w(4*i+2) <= w(4*i+1) xor w(4*i-2);
		w(4*i+3) <= w(4*i+2) xor w(4*i-1);
		round_key_init(i) <= w(4*i) & w(4*i+1) & w(4*i+2) & w(4*i+3);
	end generate gen;
	
	--rk: entity work.clock
		--port map(
			--round => round
		--);

	k : process (round, round_key_init) is
		begin
		case round is
			when 1 => next_key <= round_key_init(1);
			when 2 => next_key <= round_key_init(2);
			when 3 => next_key <= round_key_init(3);
			when 4 => next_key <= round_key_init(4);
			when 5 => next_key <= round_key_init(5);
			when 6 => next_key <= round_key_init(6);
			when 7 => next_key <= round_key_init(7);
			when 8 => next_key <= round_key_init(8);
			when 9 => next_key <= round_key_init(9);
			when 10 => next_key <= round_key_init(10);
		end case;
	end process;
end architecture behavioral;
