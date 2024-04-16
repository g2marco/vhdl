--
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.numeric_std.all;
	use ieee.math_real.all;
	
--
entity test_exercise_2_4 is
end entity;

-- 
architecture behavioral of test_exercise_2_4 is
    --
    component  mux_8_8b is
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
    end component;
    
    -- driven signals
    signal  a0  : std_logic_vector( 7 downto 0);
    signal  a1  : std_logic_vector( 7 downto 0);
    signal  a2  : std_logic_vector( 7 downto 0);
    signal  a3  : std_logic_vector( 7 downto 0);
    signal  a4  : std_logic_vector( 7 downto 0);
    signal  a5  : std_logic_vector( 7 downto 0);
    signal  a6  : std_logic_vector( 7 downto 0);
    signal  a7  : std_logic_vector( 7 downto 0);
    signal  sel : std_logic_vector( 2 downto 0);
    
    -- output signals
    signal salida: std_logic_vector( 7 downto 0);
    
    
begin

    dut:  mux_8_8b
        port map ( x0 => a0, x1 => a1, x2 => a2, x3 => a3, x4 => a4, x5 => a5, x6 => a6, x7 => a7, sel => sel, y => salida);
        
    inputs: process
        variable seed1, seed2: positive;            -- seed values for random generator
        variable rand        : real;                -- random real-number value in range 0 to 1.0
        variable int_rand    : integer;             -- random integer value in range 0..4095 
        variable value       : std_logic_vector( 15 downto 0);

        begin
            for i in 0 to 7 loop
                uniform( seed1, seed2, rand);              -- generate random number
                int_rand := integer( trunc( rand * 65535.0));
                value    := std_logic_vector( to_unsigned( int_rand, value'length)); 
                
                a0 <= value( 14 downto  7); 
                a1 <= value( 13 downto  6); 
                a2 <= value( 12 downto  5); 
                a3 <= value( 11 downto  4);  
                
                a4 <= value( 10 downto  3); 
                a5 <= value(  9 downto  2); 
                a6 <= value(  8 downto  1); 
                a7 <= value(  7 downto  0);
                
                wait for 20 ns;
            end loop;
        end process;
    
    selector: process
        begin
            for i in 0 to 7 loop
                sel  <= conv_std_logic_vector( i, sel'length);
                wait for 150 ns;
            end loop;
        end process;
     
end behavioral;