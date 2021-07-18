--
--  Toma una muestra del dato de entrada cada vez que la entrada de habilitacion esta activa
--      al alcanzar un estado estable conmuta la salida
--
--
library ieee;
    use ieee.std_logic_1164.all;
--
entity debouncing is
    generic( SAMPLES_LENGTH: natural);
    
    port (
        clk     : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        enable_n: in  STD_LOGIC;
        data_in : in  std_logic; 
        data_out: out STD_LOGIC
   );
end debouncing;

architecture Behavioral of debouncing is
    signal samples : std_logic_vector( SAMPLES_LENGTH - 1 downto 0):= (others => '0');
    signal estate  : std_logic := '0';
    
    constant UNOS  : std_logic_vector( SAMPLES_LENGTH - 1 downto 0):= (others => '1');
    constant ZEROS : std_logic_vector( SAMPLES_LENGTH - 1 downto 0):= (others => '0');
begin
    
    data_out <= estate;
    
    sample: process (clk) is
        begin 
            if rising_edge( clk) then
                if reset = '1' then 
                    samples <= ZEROS;
                else
                    -- si la señal de enable esta activa, captura y recorre
                    if  enable_n = '0' then
                        samples <= samples( SAMPLES_LENGTH - 2 downto 0) & data_in;
                    end if;
                end if;
            end if;
        end process;
    
    next_state: process( clk) is
        begin
            if rising_edge( clk) then
                if  enable_n = '0' then
                    if  estate = '0' then
                        -- comparo contra 1, posible siguiente estado es 1
                        if samples = UNOS then
                            estate <= '1';
                        end if;
                    else
                        -- comparo contra 0, posible siguiente estado es 0
                        if samples = ZEROS then
                            estate <= '0';
                        end if;
                    end if;
                end if;
            end if;
        end process;
        
end Behavioral;
