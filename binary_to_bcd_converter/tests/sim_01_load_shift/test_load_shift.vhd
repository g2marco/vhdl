library ieee;
    use ieee.std_logic_1164.all;

entity test_load_shift is
end test_load_shift;

architecture Behavioral of test_load_shift is
    constant DATA_BITS: natural := 16;
    
    component load_shift
        generic( DATA_BITS: natural);
        port (
            reset   : in  std_logic;
            clk     : in  std_logic;
            load    : in  std_logic;
            data    : in  std_logic_vector( DATA_BITS -1 downto 0);
            data_out: out std_logic
        );
    end component;
    
    signal reset   : std_logic := '0';
    signal clk     : std_logic := '0';
    signal load    : std_logic := '0';
    signal data    : std_logic_vector( DATA_BITS - 1 downto 0) := "0011001100110011";
    signal data_out: std_logic := '0';
    
begin
    uut: load_shift 
        generic map( DATA_BITS)
        port    map( reset, clk, load, data, data_out);

    clock_signal: process is
        begin
            clk <= '0';
            wait for 10ns;
            clk <= '1';
            wait for 10ns;
        end process clock_signal;
    
    reset_signal: process is
        begin
            reset <= '1';
            wait for 25ns;
            reset <= '0';
            wait for 500ns;
        end process reset_signal;
    
    load_signal: process is
        begin
            load <= '1';
            wait for 50ns;
            load <= '0';
            wait for 500ns;
        end process load_signal;
        
    data <= "0011001100110011";
            
end Behavioral;
