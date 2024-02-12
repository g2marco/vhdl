--
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	
--
entity test_exercise_2_1 is
end entity;

-- 
architecture behavioral of test_exercise_2_1 is
    --
    component  mux is
        port (
            a  : in  std_logic_vector( 7 downto 0);
            b  : in  std_logic_vector( 7 downto 0);
            sel: in  std_logic_vector( 1 downto 0);
            x  : out std_logic_vector( 7 downto 0)
        );
    end component;
    
    -- driven signals
    signal  a  : std_logic_vector( 7 downto 0);
    signal  b  : std_logic_vector( 7 downto 0);
    signal  sel: std_logic_vector( 1 downto 0);
    
    -- output signals
    signal    x: std_logic_vector( 7 downto 0);
    
begin

    dut:  mux
        port map ( a => a, b => b, sel => sel, x => x);
        
    a_and_b: process
        begin
            for i in 0 to 7 loop
                a <= conv_std_logic_vector( 2**i -   1, a'length);
                b <= conv_std_logic_vector( 2**i + 127, b'length);
                wait for 50 ns;
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