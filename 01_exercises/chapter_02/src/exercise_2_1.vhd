--
--	Exercise 2.1: Multiplexer de 2 a 1 (8 bits)
--		Implementar un multiplexor de 4 a 1 de forma que:
--          x = 0's cuando sel = 00
--          x = a   cuando sel = 01
--          x = b   cuando sel = 10
--          x = Z's de otra forma 
--

library ieee;
use ieee.std_logic_1164.all;

----------------------------------------------------
entity mux is

	port (
		a  : in  std_logic_vector( 7 downto 0);
		b  : in  std_logic_vector( 7 downto 0);
		sel: in  std_logic_vector( 1 downto 0);
		x  : out std_logic_vector( 7 downto 0)
	);
end mux;

--
architecture example of mux is
begin

	mux_proc: process( a, b, sel) is				-- invoked whenever a, b or sel changes
		begin
			if  sel = "00"   then					-- x = 0's
				x <= (others => '0');
			elsif sel = "01" then					-- x = a
				x <= a;
			elsif sel = "10" then					-- x = b
				x <= b;
			else									-- x = Z's
				x <= (others => 'Z');
			end if;
		end process;

end example;