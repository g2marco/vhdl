
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_binary_bcd_converter is
end test_binary_bcd_converter;

architecture Behavioral of test_binary_bcd_converter is
    constant DATA_BITS : natural := 12;
    constant DIGITOS   : natural := 4;
    
    component binary_bcd_converter
        generic ( DIGITOS: natural; DATA_BITS: natural);
        port (
            clk       : in    std_logic;
            reset     : in    std_logic;
            nconvert  : in    std_logic;
            data      : in    std_logic_vector( DATA_BITS  - 1 downto 0);
            bcd_digits: inout std_logic_vector((DIGITOS*4) - 1 downto 0)
        );
    end component;
    
    signal nconvert  : std_logic;        -- start of operation  
    signal reset     : std_logic;
    signal clk       : std_logic;
    signal data      : std_logic_vector( DATA_BITS  - 1 downto 0);
    signal bcd_digits: std_logic_vector((DIGITOS*4) - 1 downto 0);
    
begin
    uut: binary_bcd_converter
        generic map( DIGITOS => DIGITOS, DATA_BITS => DATA_BITS)
        port    map( clk => clk, reset => reset, nconvert => nconvert, data => data, bcd_digits => bcd_digits);
    
    data <= "111001110011";     -- 3699 d
    
    clock: process is
        begin
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end process;
    
    init: process is 
        begin
            reset <= '1';
            wait for 15 ns;
            reset <= '0';
            wait for 500ns;
        end process;
    
    convert: process is 
        begin
            nconvert <= '1';
            wait for 31 ns;
            
            nconvert <= '0';
            wait for 20 ns;
            
            nconvert <= '1';
            wait for 450 ns;            
        end process;
    
end Behavioral;
