library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;

entity test_binary_to_bcd is
end test_binary_to_bcd;

architecture behavioral of test_binary_to_bcd is
    --
    
    component binary_to_bcd is
        --
        --  DIGITS : number of BCD digits
        --
        generic( DIGITS: natural);
        port(
            clk          : in  std_logic;
            reset        : in  std_logic;
            hold_nconvert: in  std_logic;                                   -- 1 hold , 0 convertion
            data_in      : in  std_logic;                                   -- serial data input
            bcd_digits   : out std_logic_vector( (DIGITS * 4) - 1 downto 0) -- 
        );
    end component;
    
    -- Señales de entrada.
    signal clk          : std_logic := '0';
    signal reset        : std_logic := '0';
    signal hold_nconvert: std_logic := '1'; 
    signal data_in      : std_logic := '0';
   
    -- Señales de salida.
    signal bcd_digits: std_logic_vector (15 downto 0);

    -- Definición del perido del reloj.
    constant clk_period : time := 10 ns;

begin
    dut: binary_to_bcd 
        generic map( DIGITS => 4)
        port    map( clk => clk, reset => reset, hold_nconvert => hold_nconvert, data_in => data_in, bcd_digits => bcd_digits);

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
       hold_nconvert <= '1';
       data_in <= '1';
       wait for 54 ns;
       
       hold_nconvert <= '0';
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
       
       hold_nconvert <= '1';
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

