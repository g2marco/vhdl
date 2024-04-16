--
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.numeric_std.all;
	use ieee.math_real.all;
	
--
entity test_exercise_2_5 is
end entity;

-- 
architecture behavioral of test_exercise_2_5 is
    --
    component  sumador_n_bits is
        generic( N: integer := 4 );
        port (
		  a   : in  std_logic_vector( N - 1 downto 0);
		  b   : in  std_logic_vector( N - 1 downto 0);
          c_in: in  std_logic;
          sum  : out std_logic_vector( N - 1 downto 0);
          c_out: out std_logic
	   );
    end component;
    
    constant DATA_LENGTH : integer := 4;
    
    -- driven signals
    signal  opA      : std_logic_vector( DATA_LENGTH -1 downto 0);
    signal  opB      : std_logic_vector( DATA_LENGTH -1 downto 0);
    signal  carry_in : std_logic;
    
    -- output signals
    signal  suma     : std_logic_vector( DATA_LENGTH -1 downto 0);
    signal  carry_out: std_logic;
    
begin

    dut:  sumador_n_bits
        generic map ( N => DATA_LENGTH)
        port map ( a => opA, b => opB, c_in => carry_in, sum => suma, c_out => carry_out)
    ;
        
    inputs: process
    begin
        opA <= "0101";
        opB <= "0011";
        carry_in <= '0';
               
        wait for 20 ns;
    end process;
     
end behavioral;