--
--	Exercise 2.6: Multiplicador de dos numeros sin signo
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

----------------------------------------------------
entity umul_n_bits is
    generic(
        N: integer := 4
    );
	port (
		a   : in  std_logic_vector( N - 1 downto 0);
		b   : in  std_logic_vector( N - 1 downto 0);
		mul : out std_logic_vector( N - 1 downto 0)
	);
end umul_n_bits;

--
architecture behavioral of umul_n_bits is
begin
	mul <= std_logic_vector(unsigned( a) * unsigned( b)); 
end behavioral;