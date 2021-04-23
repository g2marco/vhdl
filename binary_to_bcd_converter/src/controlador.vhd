--
--  Controlador para conversion binario - bcd
--
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;
    use ieee.numeric_std.all;
--
entity controlador is
    -- numero de bits del numero binario
    generic( DATA_BITS: natural := 16);
    
    port (
        nconvert    : in  std_logic;        -- start of operation  
        reset       : in  std_logic;
        clk         : in  std_logic;
        load_shift  : out std_logic;        -- control of parallel load - shift
        hold_convert: out std_logic;         -- control of binary to bcd converter
        init_convert: out std_logic
    );
end controlador;
--
architecture behavioral of controlador is
    type etapas is ( hold, clear, convert);
    signal etapa: etapas;
    signal state: std_logic_vector( 4 downto 0) := (others => '0');
begin
    with state select 
    load_shift <= '1' when "00001" | "00000",
                  '0' when others;
                   
    with state select
    hold_convert <= '1' when "00000",
                    '0' when others;
    
    init_convert <= '1' when etapa = clear or reset = '1' else '0';
    
    states: process (clk, reset) is 
        begin
            if reset = '1' then 
                state <= (others => '0');
                etapa <= hold;
            elsif rising_edge( clk) then
                if etapa = hold then
                    if nconvert = '0' then
                        etapa <= clear;
                    end if;

                elsif  etapa = clear then 
                    etapa <= convert;
                    state <= std_logic_vector( to_unsigned( DATA_BITS, state'length));
                    
                else
                    if state /= "00000" then
                        state <= state - 1;
                    else 
                        etapa <= hold;
                    end if;                
                end if;
            end if;
        end process;

end behavioral;
