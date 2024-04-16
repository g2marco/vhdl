--
--	Exercise 2.5: Sumado de N bits con acarreo de entrada y salida
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

----------------------------------------------------
entity sumador_n_bits is
    generic(
        N: integer := 4
    );
	port (
		a   : in  std_logic_vector( N - 1 downto 0);
		b   : in  std_logic_vector( N - 1 downto 0);
		c_in: in  std_logic;
		sum  : out std_logic_vector( N - 1 downto 0);
		c_out: out std_logic
	);
end sumador_n_bits;

--
architecture behavioral of sumador_n_bits is
begin
	suma: process( a, b, c_in) is
	   variable tmp: std_logic_vector( N downto 0);
	begin
	   tmp := (0 => c_in, others => '0');
	   tmp := std_logic_vector( unsigned( '0' & a) + unsigned( '0' &  b) + unsigned( tmp));
	   
	   c_out <= tmp( N); 
	   sum   <= tmp( N - 1 downto 0); 
	end process;
	
end behavioral;