--
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.numeric_std.all;
	use ieee.math_real.all;
	
--
entity test_exercise_2_3 is
end entity;

-- 
architecture behavioral of test_exercise_2_3 is
    --
    component  mux_4_4b is
        port (
            x0  : in  std_logic_vector( 3 downto 0);
            x1  : in  std_logic_vector( 3 downto 0);
            x2  : in  std_logic_vector( 3 downto 0);
            x3  : in  std_logic_vector( 3 downto 0);
            sel : in  std_logic_vector( 1 downto 0);
            y   : out std_logic_vector( 3 downto 0)
        );
    end component;
    
    -- driven signals
    signal  a0  : std_logic_vector( 3 downto 0);
    signal  a1  : std_logic_vector( 3 downto 0);
    signal  a2  : std_logic_vector( 3 downto 0);
    signal  a3  : std_logic_vector( 3 downto 0);
    signal  sel : std_logic_vector( 1 downto 0);
    
    -- output signals
    signal salida: std_logic_vector( 3 downto 0);
    
    
begin

    dut:  mux_4_4b
        port map ( x0 => a0, x1 => a1, x2 => a2, x3 => a3,  sel => sel, y => salida);
        
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
                
                a0 <= value( 15 downto 12); 
                a1 <= value( 11 downto  8); 
                a2 <= value(  7 downto  4); 
                a3 <= value(  3 downto  0);  

                wait for 20 ns;
            end loop;
        end process;
    
    selector: process
        begin
            for i in 0 to 3 loop
                sel  <= conv_std_logic_vector( i, sel'length);
                wait for 150 ns;
            end loop;
        end process;
     
end behavioral;