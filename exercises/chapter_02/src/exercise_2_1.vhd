--	Exercise 2.1: Multiplexer
--		A multiplexer is depicted in figure 2.9. According to the truth table, the output
--	should be equal to one of the inputs if sel = "01" (x = a) or sel = "10" (x = b), but
-- 	should be zero or high impedance if sel = "00" or sel = "11", respectively.
--
--	a) Complete the VHDL code below.
--	b) Write relevant comments regarding your solution (as in example 2.2).
--	c) Compile and simulate the code, checking whether it works as expected.
--
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
				x <= "00000000";
			elsif sel = "01" then					-- x = a
				x <= a;
			elsif sel = "10" then					-- x = b
				x <= b;
			else									-- x = Z's
				x <= "ZZZZZZZZ";
			end if;
		end process;

end example;