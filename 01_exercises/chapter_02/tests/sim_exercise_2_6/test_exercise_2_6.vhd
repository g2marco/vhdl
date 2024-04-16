--
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.numeric_std.all;
	use ieee.math_real.all;
	
--
entity test_exercise_2_6 is
end entity;

-- 
architecture behavioral of test_exercise_2_6 is
    --
    component  umul_n_bits is
        generic( N: integer := 4 );
        port (
		  a   : in  std_logic_vector( N - 1 downto 0);
		  b   : in  std_logic_vector( N - 1 downto 0);
          mul : out std_logic_vector( N - 1 downto 0)
	   );
    end component;
    
    constant DATA_LENGTH : integer := 4;
    
    -- driven signals
    signal  opA      : std_logic_vector( DATA_LENGTH -1 downto 0);
    signal  opB      : std_logic_vector( DATA_LENGTH -1 downto 0);
    
    -- output signals
    signal  resultado: std_logic_vector( DATA_LENGTH -1 downto 0);
    
begin

    dut:  umul_n_bits
        generic map ( N => DATA_LENGTH)
        port map ( a => opA, b => opB, mul => resultado)
    ;
        
    inputs: process
    begin
        opA <= "0100";
        opB <= "0011";

        wait for 20 ns;
    end process;
     
end behavioral;