library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;

entity controller is
    port ( 
        clk      : in  std_logic;
        reset    : in  std_logic;
        button   : in  std_logic;
        bin_data : out std_logic_vector ( 11 downto 0);
        display  : out std_logic_vector ( 3 downto 0);
        segmentos: out std_logic_vector ( 7 downto 0)
    );
end controller;

architecture Behavioral of controller is
    constant DIGITOS_BCD: natural := 4;
    constant DATA_BITS  : natural := 12;

    -- 
    component display_controller 
        port(
            clk      : in  std_logic;
            reset    : in  std_logic;
            digitos  : in  std_logic_vector (15 downto 0);
            display  : out std_logic_vector ( 3 downto 0);
            segmentos: out std_logic_vector ( 7 downto 0)
        );    
    end component;
    
    --
    component binary_bcd_converter is
        generic ( DIGITOS: natural; DATA_BITS: natural);
        port (
            clk       : in    std_logic;
            reset     : in    std_logic;
            nconvert  : in    std_logic;
            data      : in    std_logic_vector( DATA_BITS  - 1 downto 0);
            bcd_digits: inout std_logic_vector((DIGITOS*4) - 1 downto 0)
        );
    end component;
    
    component input_debouncing is
        generic( SAMPLE_DIVIDER : natural := 200000; SAMPLES_LENGTH : natural := 16);
        port(
            clk     : in  std_logic;
            reset   : in  std_logic;
            data_in : in  std_logic;
            data_out: out std_logic
        );
    end component;
    
    --
    
    signal bcd_digits : std_logic_vector ( (DIGITOS_BCD*4) - 1 downto 0) := (others => '0');
        
    signal data            : std_logic_vector ( DATA_BITS - 1 downto 0) := (others => '0');
    signal inc             : std_logic := '0';
    signal data_disponible : std_logic := '1';
    signal button_debounced: std_logic;
    
begin
    display_control: display_controller
        port    map( clk => clk, reset => reset, digitos => bcd_digits, display => display, segmentos => segmentos);
    
    converter      : binary_bcd_converter
        generic map( DIGITOS_BCD,  DATA_BITS)
        port    map( clk => clk, reset => reset, nconvert => data_disponible, data => data, bcd_digits => bcd_digits);
    
    button_debounce: input_debouncing
        port    map( clk => clk, reset => reset, data_in => button, data_out => button_debounced);
        
    bin_data <= data;
    
    process( clk)
    begin
        if rising_edge( clk) then
            if reset = '1' then
                data <= (others => '0');
                
            elsif ( button_debounced = '1') then
                if ( inc = '0') then
                   data <= data + 1;
                   inc <= '1';
                   data_disponible <= '0';
                else 
                    data_disponible <= '1';
                end if;
            else
                inc <= '0';
                data_disponible <= '1';
            end if; 
        end if;
    end process;
    
end Behavioral;
