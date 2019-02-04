library ieee;
use ieee.std_logic_1164.all;

entity controlador is
Port(
		Resetn, clock: in std_logic;
		Encender, Start, Remojar, Jeans, Toall, Norm, Del: in std_logic;
		Fin3s, llenando, finllenado, finlavado, FinRemojo: in std_logic;
		Vacio, FinDesague, FinExprimido1, FinEnjuague1: in std_logic;
		FinExprimido2, Finllenado2, FinEnjuague2, FinDesague2: in std_logic;
		FinExprimidoF, FinAlarma: in std_logic;
		ldtempo, Encendido, SelRemojo, EnR, EnProgram: out std_logic;
		Error, contar, EnP, valvula, MoverMot, Bomba: out std_logic;
		Centrifugar, Fin: out std_logic;
		est: out std_logic_vector(4 downTo 0)
		);
end controlador;

Architecture sol of controlador is
type estado is (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, llenar, lavar, remojando, desague, centrifug, llenar2, 
						enjuague1, desague2, exprimido2, llenar3, enjuague2, desague3, exprimidof);
signal y: estado; 

begin

--transitions
Process(Resetn, clock)
begin
	if Resetn = '0' then y <= T1;
	elsif clock'event and clock = '1' then
		case y is
			when T1 => if encender = '1' then y<= T2; end if;
			when T2 => if encender = '0' then y<= T3; end if;
			when T3 => if Start = '1' then y<= T4;
							elsif Remojar = '0' then y<= T3;
							else y<= T5; end if;
			when T4 => if start = '0' then y<= T6; end if;
			when T5 => if remojar = '0' then y<= T3; end if;
			when T6 => if Del = '1' then
								if Norm = '1' then y<= T7;
								elsif Toall = '1' then y<= T7;
								elsif Jeans = '1' then y<= T7;
								else y<= T8; end if;
							elsif Norm = '1' then
								if Del = '1' then y<= t7;
								elsif Toall ='1' then y<= t7;
								elsif Jeans = '1' then y<= T7;
								else y<= T8; end if;
							elsif Toall = '1' then
								if Del = '1' then y<= T7;
								elsif Toall = '1' then y<= T7;
								elsif Jeans = '1' then y<= T7;
								else y<= T8; end if;
							elsif Jeans = '1' then
								if Del = '1' then y<= T7;
								elsif Toall = '1' then y<= T7;
								elsif Norm = '1' then y<= T7;
								else y<= T8; end if;
							else y<= T7; end if;
				when T7 => if Fin3s <= '1' then y<= T3; end if;
				when T8 => y<= llenar;
				when llenar => if llenando = '0' then y<=lavar;
									elsif finllenado = '0' then y<= llenar;
									else y <= T9; end if;
				when T9 => if llenando = '0' then y<= lavar; end if;
				when lavar => if FinLavado = '1' then y<=remojando; end if;
				when remojando => if FinRemojo = '1' then y<=desague; end if;
				when desague => if vacio = '1' then y<=centrifug;
										elsif FinDesague = '1' then y<= T10; end if;
				when T10 => if vacio = '1' then y<=centrifug; end if;
				when Centrifug => if FinExprimido1 = '1' then y<=llenar2; end if;
				when llenar2 => if llenando = '0' then y<= Enjuague1;
										elsif Finllenado = '1' then y<= T11; end if;
				when T11 => if llenando = '0' then y<= Enjuague1; end if;
				when Enjuague1 => if FinEnjuague1 = '1' then y<= desague2; end if;
				when desague2 => if vacio = '1' then y<= exprimido2; 
										elsif FinDesague = '1' then y<= T12; end if;
				when T12 => if vacio = '1' then y<= Exprimido2; end if;
				when exprimido2 => if Del = '1' then y<= ExprimidoF;
											elsif finExprimido2 = '1' then y<= llenar3; end if;
				when llenar3 => if llenando = '0' then y<= Enjuague2;
									elsif FinLlenado2 = '1' then y<= T14; end if;
				when T14 => if llenando = '0' then y<= Enjuague2; end if;
				when Enjuague2 => if FinEnjuague2 = '1' then y<= desague3; end if;
				when Desague3 => if Vacio = '1' then y<= ExprimidoF; 
										elsif FinDesague2 = '1' then y<= T15; end if;
				when T15 => if Vacio = '1' then y<= ExprimidoF; end if;
				when ExprimidoF => if FinExprimidoF = '1' then y<= T13; end if;
				when T13 => if FinAlarma = '1' then y<=T1; end if;
								
		end case;
	end if;
end process;

--salidas
process(Resetn, clock, start, Fin3s, Remojar, llenando, Finlavado, FinRemojo, vacio, FinExprimido1, FinEnjuague1, FinExprimido2, FinEnjuague2, 
			FinExprimidoF, FinAlarma)
begin 
ldtempo <= '0'; EnR <= '0'; Encendido <= '0'; SelRemojo <= '0'; EnR <= '0'; EnProgram <= '0';
Error <= '0'; contar <= '0'; EnP <= '0'; valvula <= '0'; MoverMot <= '0'; Bomba <= '0';
Centrifugar <= '0'; est <= "00000"; Fin <= '0';

case y is
	when T1 => est <= "00001"; ldTempo <= '1'; EnR <= '1';
	when T2 => est <= "00010";
	when T3 => est <= "00011"; encendido <= '1'; 
	when T4 => est <= "00100"; encendido <= '1'; 
					if start = '1' then EnProgram <= '1'; end if;
	when T5 => est <= "00101"; SelRemojo <= '1';encendido <= '1'; 
					if Remojar = '1' then EnR <= '1'; end if;
	when T6 => est <= "00110";encendido <= '1'; 
	when T7 => est <= "00111"; Error <= '1'; Contar <= '1';encendido <= '1'; 
					if fin3s = '1' then ldTempo <= '1'; end if;
	when T8 => est <= "01000"; EnP <= '1'; encendido <= '1'; 
	when T9 => est <= "01001"; ldTempo <= '1'; Error <= '1'; valvula <= '1';encendido <= '1'; 
	when T10 => est <= "01010"; error <= '1'; ldTempo <= '1'; Bomba <= '1';encendido <= '1'; 
	when T11 => est <= "01011"; error <= '1'; ldTempo <= '1'; valvula <= '1';encendido <= '1'; 
	when T12 => est <= "01100"; error <= '1'; ldTempo <= '1'; Bomba <= '1';encendido <= '1'; 
	when T13 => est <= "01101"; Fin <= '1'; Contar <= '1'; encendido <= '1'; 
	when T14 => est <= "01110"; error <= '1'; ldTempo <= '1'; valvula <= '1';encendido <= '1'; 
	when T15 => est <= "01111"; error <= '1'; ldTempo <= '1'; Bomba <= '1';encendido <= '1'; 
	when llenar => est <= "10000"; valvula <= '1'; contar <= '1'; encendido <= '1'; 
					if llenando = '0' then ldTempo <= '1'; end if;
	when lavar => est <= "10001"; MoverMot <= '1'; Contar <= '1';encendido <= '1'; 
					if finLavado = '1' then ldTempo <= '1'; end if;
	when remojando => est <= "10010"; Contar <= '1';encendido <= '1'; 
					if finRemojo = '1' Then ldTempo <= '1'; end if;
	when desague => est <= "10011"; Bomba <= '1'; Contar <= '1';encendido <= '1'; 
					if vacio = '1' then ldtempo <= '1'; end if;
	when centrifug => est <= "10100"; Centrifugar <= '1'; Contar <= '1';encendido <= '1'; 
					if FinExprimido1 = '1' then ldTempo <= '1'; end if;
	when llenar2 => est <= "10101"; Valvula <= '1'; contar <= '1';encendido <= '1'; 
							if llenando = '0' then ldTempo <= '1'; end if;
	when Enjuague1 => est <= "10110"; MoverMot <= '1'; Contar <= '1'; encendido <= '1'; 
						if FinEnjuague1 = '1' then ldTempo <= '1'; end if;
	when Desague2 => est <= "10111"; Bomba <= '1'; Contar <= '1';encendido <= '1'; 
						if vacio = '1' then ldTempo <= '1'; end if;
	when Exprimido2 => est <= "11000"; Centrifugar <= '1'; Contar <= '1'; encendido <= '1'; 
						if FinExprimido2 = '1' then ldTempo <= '1'; end if;
	when llenar3 => est <= "11001"; Valvula <= '1'; contar <= '1';encendido <= '1'; 
						if llenando = '0' then ldTempo <= '1'; end if;
	when Enjuague2 => est <= "11010"; MoverMot <= '1'; Contar <= '1';encendido <= '1'; 
						if FinEnjuague2 = '1' then ldTempo <= '1'; end if;
	when desague3 => est <= "11011"; Bomba <= '1'; Contar <= '1'; encendido <= '1'; 
						if vacio <= '1' then ldTempo <= '1'; end if;
	when ExprimidoF => est <= "11100"; Centrifugar <= '1'; Contar <= '1';encendido <= '1'; 
						if FinExprimidoF = '1' then ldTempo <= '1'; end if;
	end case;
end process;
end sol;
						
