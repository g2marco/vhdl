----------------------------------------------------------------------------------
-- Description: Configurable length shift register with parallel load and 
--              serial data output
-- 
-- @author  Marco Antonio Garcia G.     g2marco@yahoo.com.mx
----------------------------------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;

--
entity load_shift is
    --  
    --  DATA_BITS: length of the parallel data input
    --
    generic( DATA_BITS: natural);
    
    port (
        clk        : in  std_logic;
        reset      : in  std_logic;
        load_nshift: in  std_logic;                                     -- 1 parallel load, 0 shift left                                            
        data       : in  std_logic_vector( DATA_BITS - 1 downto 0);     -- parallel data input
        data_out   : out std_logic                                      -- serial data output
    );
end load_shift;

--
architecture behavioral of load_shift is
    constant ZEROS   : std_logic_vector( DATA_BITS - 1 downto 0) := (others => '0');
    
    signal siguiente : std_logic_vector( DATA_BITS - 1 downto 0) := ZEROS;  
    signal actual    : std_logic_vector( DATA_BITS - 1 downto 0) := ZEROS;

begin

    data_out <= actual( DATA_BITS - 1);
    
    proc_register: process( clk) is
        begin
            if rising_edge( clk) then
                if reset = '1' then
                    actual <= (others => '0');
                else
                    actual <= siguiente;
                end if;
            end if;
        end process proc_register;
    
    
    proc_siguiente: process( load_nshift, data, actual) is
        begin
            case load_nshift is
                when '0'    => siguiente <= (actual(DATA_BITS - 2 downto 0) & '0');     -- shift
                when '1'    => siguiente <= data;                                       -- load
                when others => siguiente <= ZEROS;
            end case;
        end process proc_siguiente;
            
end behavioral;
