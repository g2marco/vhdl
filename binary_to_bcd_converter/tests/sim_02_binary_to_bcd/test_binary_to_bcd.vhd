library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;

entity test_binary_to_bcd is
end test_binary_to_bcd;

architecture Behavioral of test_binary_to_bcd is
    component binary_to_bcd is port(
        clk       : in    std_logic;
        reset     : in    std_logic;
        nconvert  : in    std_logic;
        data_in   : in    std_logic;
        bcd_digits: inout std_logic_vector( 15 downto 0)
    );
    end component;
    
    -- Señales de entrada.
    signal clk      : std_logic := '0';
    signal reset    : std_logic := '0';
    signal nconvert : std_logic := '1'; 
    signal data_in  : std_logic := '0';
   
    -- Señales de salida.
    signal bcd_digits: std_logic_vector (15 downto 0);

    -- Definición del perido del reloj.
    constant clk_period : time := 10 ns;
begin
     
   -- Usar la unidad bajo prueba.
   uut: binary_to_bcd PORT MAP ( clk => clk, reset => reset, nconvert => nconvert, data_in => data_in, bcd_digits => bcd_digits);

   -- Generar reloj.
   clk_process: process
   begin
       clk <= '0';
       wait for clk_period/2;
       clk <= '1';
       wait for clk_period/2;
   end process;

   -- Estímulos.
   stim_proc: process
   begin
       nconvert <= '1';
       data_in <= '1';
       wait for 54 ns;
       
       nconvert <= '0';
       data_in <= '1';
       wait for 28 ns;
       
       data_in <= '0';
       wait for 21 ns;
       
       data_in <= '1';
       wait for 14 ns;
       
       data_in <= '1';
       wait for 14 ns;
       
       data_in <= '0';
       wait for 21 ns;
       
       data_in <= '1';
       wait for 14 ns;
       
       nconvert <= '1';
       wait for 100ns;
       
    end process;
    
    reset_proc: process
    begin
        reset <= '1';
        wait for 30ns;
        reset <= '0';
        wait for 370ns;
    end process;
           
end Behavioral;

