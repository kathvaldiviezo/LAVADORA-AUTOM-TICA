library ieee;
use ieee.std_logic_1164.all;

Entity cadenaToBit is
	Port(
	Ent : in std_logic_vector(7 downTo 0);
	a: out std_logic;
	b: out std_logic;
	c: out std_logic;
	d: out std_logic;
	e: out std_logic;
	f: out std_logic;
	g: out std_logic;
	h: out std_logic);
end cadenaToBit;

Architecture sol of cadenaToBit is

Begin
	a <= Ent(7);
	b <= Ent(6);
	c <= Ent(5);
	d <= Ent(4);
	e <= Ent(3);
	f <= Ent(2);
	g <= Ent(1);
	h <= Ent(0);
end sol;