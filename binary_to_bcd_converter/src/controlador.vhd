----------------------------------------------------------------------------------
-- Description: Main controller for the binary to BCD controller
-- 
-- @author  Marco Antonio Garcia G.     g2marco@yahoo.com.mx
----------------------------------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;
    use ieee.numeric_std.all;
    
--
entity controlador is
    --
    --  DATA_BITS: length of the binary data that will be converted
    --
    generic( DATA_BITS: natural);
    
    port (
        clk           : in  std_logic;
        reset         : in  std_logic;
        nconvert      : in  std_logic;                                   -- input for starting a convertion  
        load_nshift   : out std_logic;                                   -- control signal for the load_shift block 
        hold_nconvert : out std_logic;                                   -- control signal for the binary_to_bcd block
        internal_reset: out std_logic                                    -- internal reset, before starting a new conversion
    );
end controlador;

--
architecture behavioral of controlador is
    type etapas is ( hold, clear, convert);
    signal etapa: etapas;
    signal state: std_logic_vector( 4 downto 0) := (others => '0');

begin
    with state select   load_nshift <= '1' when "00001" | "00000", '0' when others;
                   
    with state select hold_nconvert <= '1' when "00000", '0' when others;
    
    internal_reset <= '1' when (etapa = clear or reset = '1') else '0'; -- resets binary_to_bcd_block before starting a new conversion
    
    states: process (clk) is 
        begin
            if rising_edge( clk) then
                if reset = '1' then 
                    etapa <= hold;
                    state <= (others => '0');
                else 
                    if etapa = hold then                                -- only in 'hold' state, a new convertion may start
                        if nconvert = '0' then              
                            etapa <= clear;                             -- load/shift keeps reading the current value
                        end if;

                    elsif  etapa = clear then 
                        etapa <= convert;                               -- start transform and shift process
                        state <= std_logic_vector( to_unsigned( DATA_BITS, state'length));
                    
                    else                                                -- in 'convert' state, or 'unknown', tries to reach the 'hold' state 
                        if state /= "00000" then
                            state <= state - 1;
                        else
                            etapa <= hold;
                        end if;                
                    end if;
                end if;
            end if;
        end process;

end behavioral;
