
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_controlador is
end test_controlador;

architecture Behavioral of test_controlador is
    constant DATA_BITS : natural := 12;
    
    component controlador
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
    end component;
    
    signal clk           : std_logic;
    signal reset         : std_logic;
    signal nconvert      : std_logic;        -- start of operation  
    signal load_nshift   : std_logic;        -- control of parallel load - shift
    signal hold_nconvert : std_logic;        -- control of binary to bcd converter
    signal internal_reset: std_logic;        -- reset of binary to bcd converter
    
begin
    dut: controlador
        generic map( DATA_BITS => DATA_BITS)
        port    map( clk => clk, reset => reset, nconvert => nconvert, load_nshift => load_nshift, hold_nconvert => hold_nconvert, internal_reset => internal_reset);

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
