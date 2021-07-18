--
--  Create a single pulse every X ms
--

library ieee;
    use ieee.std_logic_1164.all;

entity sample_signal_generator is
    generic( CUENTA_MAXIMA: natural);
    
    port (
        clk      : in STD_LOGIC;
        reset    : in STD_LOGIC;
        enable_n : out STD_LOGIC
    );
end sample_signal_generator;

architecture Behavioral of sample_signal_generator is
    signal cuenta: natural range 0 to CUENTA_MAXIMA := 0;
begin
    with cuenta select 
    enable_n <= '0' when CUENTA_MAXIMA, '1' when others;
    
    counter: process( clk) is 
        begin
            if rising_edge( clk) then
                if reset = '1' then
                    cuenta <= 0;
                elsif cuenta = CUENTA_MAXIMA  then 
                    cuenta <= 0;
                else 
                    cuenta <= cuenta + 1;
                end if;
            end if;
        end process;
    
end Behavioral;
