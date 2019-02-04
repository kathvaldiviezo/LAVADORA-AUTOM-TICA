library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity restador is
	generic(n: integer := 4);
	port(
		a,b: in std_logic_vector(n-1 downto 0);
		s: out std_logic_vector(n-1 downto 0)
	);
end restador;

architecture comp of restador is
begin
	s <= a-b;
end comp;