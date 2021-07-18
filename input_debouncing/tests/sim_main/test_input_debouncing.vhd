library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity test_input_debouncing is
end test_input_debouncing;

architecture Behavioral of test_input_debouncing is
    -- 
    component input_debouncing is
        generic( SAMPLE_DIVIDER : natural := 200000; SAMPLES_LENGTH : natural := 16);
        port(
            clk     : in  std_logic;
            reset   : in  std_logic;
            data_in : in  std_logic;
            data_out: out std_logic
        );
    end component;
    
    -- driven signals 
    signal clk    : std_logic;
    signal reset  : std_logic;
    signal data_in: std_logic;
    
    -- outputs
    signal data_out : std_logic;
    
begin

    dut: input_debouncing
        generic map( SAMPLE_DIVIDER => 8, SAMPLES_LENGTH => 4)
        port    map( clk => clk, reset => reset, data_in => data_in, data_out => data_out);
        
    reloj: process is
        begin
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end process;
    
    clear: process is
        begin
            reset <= '1';
            wait for 30 ns;
            reset <= '0';
            wait for 5000 ns;
        end process;
    
    entrada: process is 
        begin
            data_in <= '0';
            wait for 650 ns;
            
            data_in <= '1';
            wait for 650 ns;             
        end process;
    
end Behavioral;
