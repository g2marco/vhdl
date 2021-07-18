--
library ieee;
    use ieee.std_logic_1164.all;


entity input_debouncing is
    generic( SAMPLE_DIVIDER : natural := 200000; SAMPLES_LENGTH : natural := 16);
    port(
        clk     : in  std_logic;
        reset   : in  std_logic;
        data_in : in  std_logic;
        data_out: out std_logic
    );
end input_debouncing;

architecture Behavioral of input_debouncing is
    --
    component  debouncing is
        generic( SAMPLES_LENGTH: natural);
        port (
            clk     : in  STD_LOGIC;
            reset   : in  STD_LOGIC;
            enable_n: in  STD_LOGIC;
            data_in : in  std_logic; 
            data_out: out STD_LOGIC
        );
    end component;
    
    component sample_signal_generator is
        generic( CUENTA_MAXIMA: natural);
        port (
            clk      : in STD_LOGIC;
            reset    : in STD_LOGIC;
            enable_n : out STD_LOGIC
        );
    end component;
    
    --
    signal enable_n: std_logic;
    
begin

    generator: sample_signal_generator
        generic map ( CUENTA_MAXIMA => SAMPLE_DIVIDER)
        port    map ( clk => clk, reset => reset, enable_n => enable_n);
    
    debouncer: debouncing
        generic map ( SAMPLES_LENGTH => SAMPLES_LENGTH)
        port    map (  clk => clk, reset => reset, enable_n => enable_n, data_in => data_in, data_out => data_out);

end Behavioral;
