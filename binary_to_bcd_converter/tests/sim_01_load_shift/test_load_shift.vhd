library ieee;
    use ieee.std_logic_1164.all;

entity test_load_shift is
end test_load_shift;

architecture behavioral of test_load_shift is
    constant DATA_BITS: natural := 16;
    
    component load_shift
        generic( DATA_BITS: natural);
        port (
            clk        : in  std_logic;
            reset      : in  std_logic;
            load_nshift: in  std_logic;                                     -- 1 parallel load, 0 shift left                                            
            data       : in  std_logic_vector( DATA_BITS - 1 downto 0);     -- parallel data input
            data_out   : out std_logic                                      -- serial data output
        );
    end component;
    
    signal reset   : std_logic := '0';
    signal clk     : std_logic := '0';
    signal load    : std_logic := '0';
    signal data    : std_logic_vector( DATA_BITS - 1 downto 0) := "0011001100110011";
    signal data_out: std_logic := '0';
    
begin
    uut: load_shift 
        generic map( DATA_BITS => DATA_BITS)
        port    map( clk => clk, reset => reset, load_nshift => load, data => data, data_out => data_out);

    clock_signal: process is
        begin
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end process clock_signal;
    
    reset_signal: process is
        begin
            reset <= '1';
            wait for 30 ns;
            reset <= '0';
            wait for 470 ns;
        end process reset_signal;
    
    load_signal: process is
        begin
            load <= '1';
            wait for 50 ns;
            load <= '0';
            wait for 200 ns;
        end process load_signal;
        
    data <= "0011001100110011";
            
end behavioral;
