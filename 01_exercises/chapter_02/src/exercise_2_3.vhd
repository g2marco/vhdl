--
--	Exercise 2.3: Multiplexor de 4 a 1 (4 bit) 
--		Implementar un multiplexor de 4 a 1 utilizando la sentencia 'when'

library ieee;
use ieee.std_logic_1164.all;

----------------------------------------------------
entity mux_4_4b is

	port (
		x0  : in  std_logic_vector( 3 downto 0);
		x1  : in  std_logic_vector( 3 downto 0);
		x2  : in  std_logic_vector( 3 downto 0);
		x3  : in  std_logic_vector( 3 downto 0);
		sel : in  std_logic_vector( 1 downto 0);
		y   : out std_logic_vector( 3 downto 0)
	);
end mux_4_4b;

--
architecture when_expr of mux_4_4b is
begin

    y <= x0 when sel = "00" else
         x1 when sel = "01" else
         x2 when sel = "10" else
         x3;  

end when_expr;