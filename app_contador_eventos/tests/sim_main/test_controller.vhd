library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;

entity test_controller is
end test_controller;

architecture Behavioral of test_controller is
    --
    component controller is
        port ( 
            clk      : in  std_logic;
            reset    : in  std_logic;
            button   : in  std_logic;
            bin_data : out std_logic_vector ( 11 downto 0);
            display  : out std_logic_vector ( 3 downto 0);
            segmentos: out std_logic_vector ( 7 downto 0)
        );
    end component;
    
    signal clk      : std_logic;
    signal reset    : std_logic;
    signal button   : std_logic;
    signal bin_data : std_logic_vector ( 11 downto 0);
    signal display  : std_logic_vector ( 3 downto 0);
    signal segmentos: std_logic_vector ( 7 downto 0);
    
begin
    dut: controller
        port    map( clk => clk, reset => reset, button => button, bin_data => bin_data, display => display, segmentos => segmentos);

    reloj: process is
        begin
            clk <= '0';
            wait for 10 ns;
            
            clk <= '1';
            wait for 10 ns;
        end process;
    
    clear: process is
        begin
            reset <= '1';
            wait for 55 ns;
            
            reset <= '0';
            wait for 1145 ns;
        end process;
    
    incrementa: process is
        begin
            button <= '0';
            wait for 100 ns;
            
            button <= '1';
            wait for 300 ns;
            
        end process;
            

end Behavioral;
