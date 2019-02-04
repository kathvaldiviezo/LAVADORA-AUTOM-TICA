library ieee;
use ieee.std_logic_1164.all;

Entity Conv_Decimal_Binario is
	Port(
	Ent : in std_logic_vector(3 downTo 0);
	BCD : out std_logic_vector(3 downTo 0));
end Conv_Decimal_Binario;

Architecture sol of Conv_Decimal_Binario is

Begin
	with Ent select
	BCD <="0000" when "1000", 
			"0001" when "0100",
			"0010" when "0010",
			"0011" when "0001",
			"0000" when others;
end sol;