library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;

entity display_controller is
    generic( BITS: integer := 21);
    port ( 
        clk      : in  std_logic;
        reset    : in  std_logic;
        digitos  : in  std_logic_vector (15 downto 0);
        display  : out std_logic_vector ( 3 downto 0);
        segmentos: out std_logic_vector ( 7 downto 0)
    );
end display_controller;

architecture Behavioral of display_controller is
    signal cuenta : std_logic_vector (BITS - 1 downto 0);
    signal digito : std_logic_vector (3 downto 0);  
    
    alias  estado : std_logic_vector (1 downto 0) is cuenta( BITS - 1 downto BITS - 2);
    
    alias digito0 : std_logic_vector (3 downto 0) is digitos(  3 downto 0);
    alias digito1 : std_logic_vector (3 downto 0) is digitos(  7 downto 4);
    alias digito2 : std_logic_vector (3 downto 0) is digitos( 11 downto 8);
    alias digito3 : std_logic_vector (3 downto 0) is digitos( 15 downto 12);

begin
    process ( clk, reset)
    begin
        if (reset = '1') then
            cuenta <= (others =>'0');            
        elsif ( clk'event and clk = '1') then
            cuenta <= cuenta + 1;            
        end if;
    end process;
    
    display <= "1111" when reset  = '1'  else
               "1110" when estado = "00" else
               "1101" when estado = "01" else
               "1011" when estado = "10" else
               "0111" when estado = "11" else
               "1111";
    
    with estado select
        digito <= digito0 when "00",
                  digito1 when "01",
                  digito2 when "10",
                  digito3 when others;
    
    segmentos <= "11111111" when reset  = '1'  else 
                 "11000000" when digito = "0000" else
                 "11111001" when digito = "0001" else
                 "10100100" when digito = "0010" else
                 "10110000" when digito = "0011" else
                 "10011001" when digito = "0100" else
                 "10010010" when digito = "0101" else
                 "10000010" when digito = "0110" else
                 "11111000" when digito = "0111" else
                 "10000000" when digito = "1000" else
                 "10011000" when digito = "1001" else
                 "10001000" when digito = "1010" else
                 "10000011" when digito = "1011" else
                 "11000011" when digito = "1100" else
                 "10100001" when digito = "1101" else
                 "10000110" when digito = "1110" else
                 "10001110";
end Behavioral;