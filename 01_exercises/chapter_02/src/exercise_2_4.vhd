--
--	Exercise 2.4: Multiplexor de 8 a 1 (8 bit) 
--		Implementar un multiplexor de 8 a 1 utilizando la sentencia 'select'

library ieee;
use ieee.std_logic_1164.all;

----------------------------------------------------
entity mux_8_8b is

	port (
		x0  : in  std_logic_vector( 7 downto 0);
		x1  : in  std_logic_vector( 7 downto 0);
		x2  : in  std_logic_vector( 7 downto 0);
		x3  : in  std_logic_vector( 7 downto 0);
		x4  : in  std_logic_vector( 7 downto 0);
		x5  : in  std_logic_vector( 7 downto 0);
		x6  : in  std_logic_vector( 7 downto 0);
		x7  : in  std_logic_vector( 7 downto 0);
		sel : in  std_logic_vector( 2 downto 0);
		y   : out std_logic_vector( 7 downto 0)
	);
end mux_8_8b;

--
architecture select_expr of mux_8_8b is
begin

	with sel select 
    	y <= x0 when "000",
             x1 when "001",
             x2 when "010",
             x3 when "011", 
             x4 when "100",
             x5 when "101",
             x6 when "110",
             x7 when others;

end select_expr;