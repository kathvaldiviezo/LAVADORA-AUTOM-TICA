library ieee;
use ieee.std_logic_1164.all;

Entity Conv_Decimal_Binario is
	Port(
	Ent : in std_logic_vector(9 downTo 0);
	BCD : out std_logic_vector(3 downTo 0));
end Conv_Decimal_Binario;

Architecture sol of Conv_Decimal_Binario is

Begin
	with Ent select
	BCD <="0000" when "1000000000", 
			"0001" when "0100000000",
			"0010" when "0010000000",
			"0011" when "0001000000",
			"0100" when "0000100000",
			"0101" when "0000010000",
			"0110" when "0000001000",
			"0111" when "0000000100",
			"1000" when "0000000010",
			"1001" when "0000000001",
			"0000" when others;
end sol;