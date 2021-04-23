
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_controlador is
end test_controlador;

architecture Behavioral of test_controlador is
    constant DATA_BITS : natural := 12;
    
    component controlador
        generic( DATA_BITS: natural);
        port (
            nconvert    : in  std_logic;        -- start of operation  
            reset       : in  std_logic;
            clk         : in  std_logic;
            load_shift  : out std_logic;        -- control of parallel load - shift
            hold_convert: out std_logic         -- control of binary to bcd converter
        );
    end component;
    
    signal nconvert    : std_logic;        -- start of operation  
    signal reset       : std_logic;
    signal clk         : std_logic;
    signal load_shift  : std_logic;        -- control of parallel load - shift
    signal hold_convert: std_logic;         -- control of binary to bcd converter
    
begin
    uut: controlador
        generic map( DATA_BITS)
        port    map( nconvert, reset, clk, load_shift, hold_convert);
        
    clock: process is
        begin
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
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
