----------------------------------------------------------------------------------
-- Description:     Configurable length shift register with parallel load 
-- 
-- @author  Marco Antonio Garcia G.     g2marco@yahoo.com.mx
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity load_shift is
    generic( DATA_BITS: natural);
    
    port (  reset, clk : in  std_logic;
            load       : in  std_logic;
            data       : in  std_logic_vector( DATA_BITS - 1 downto 0);
            data_out   : out std_logic
    );
end load_shift;

architecture Behavioral of load_shift is
    signal siguiente : std_logic_vector( DATA_BITS - 1 downto 0);  
    signal actual    : std_logic_vector( DATA_BITS - 1 downto 0) := (others => '0');

begin

    data_out <= actual(DATA_BITS - 1);
    
    proc_siguiente: process( load, reset, data, actual) is
        begin
            if ( reset = '1') then
                siguiente <= (others => '0');
            else
                case load is
                    when '1'    => siguiente <= data;                                       -- load
                    when '0'    => siguiente <= (actual(DATA_BITS - 2 downto 0) & '0');     -- shift
                    when others => siguiente <= actual;                                     -- hold
                end case;
            end if;
        end process proc_siguiente;

    proc_register: process( clk) is
        begin
            if ( clk'event and clk = '1') then
                actual <= siguiente;
            end if;
        end process proc_register;
    
end Behavioral;
