--
--	Exercise 2.2: Multiplexor de 4 a 1 (1 bit) 
--		Implementar un multiplexor de 4 a 1 utilizando una expresion booleana
--

library ieee;
use ieee.std_logic_1164.all;

----------------------------------------------------
entity mux_4_1b is

	port (
		x0  : in  std_logic;
		x1  : in  std_logic;
		x2  : in  std_logic;
		x3  : in  std_logic;
		sel : in  std_logic_vector( 1 downto 0);
		y   : out std_logic
	);
end mux_4_1b;

--
architecture bool_expr of mux_4_1b is
begin

    y <= ((not sel(1)) and (not sel(0)) and x0) or ((not sel(1)) and sel(0) and x1) or (sel(1) and (not sel(0)) and x2) or (sel(1) and sel(0) and x3);  

end bool_expr;