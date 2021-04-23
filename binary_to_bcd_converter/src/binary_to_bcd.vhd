library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

entity binary_to_bcd is
    generic( DIGITS : natural := 4);
    port(
        clk       : in    std_logic;
        reset     : in    std_logic;
        nconvert  : in    std_logic;
        data_in   : in    std_logic;
        bcd_digits: out std_logic_vector( (DIGITS * 4) - 1 downto 0) 
    );
end binary_to_bcd;

architecture Behavioral of binary_to_bcd is
    signal next_digits   : std_logic_vector( (DIGITS * 4) - 1 downto 0);
    signal current_digits: std_logic_vector( (DIGITS * 4) - 1 downto 0);
    
begin
    
    bcd_digits <= current_digits;
    
    estados: process( clk, reset) is
        begin
            if reset = '1' then
                current_digits <= (others => '0');
            elsif rising_edge( clk) then
                if nconvert = '0' then
                    current_digits <= next_digits;
                end if;
            end if;
        end process;
    
    convert: process( current_digits, data_in, nconvert) is
        variable digit    : std_logic_vector(         3 downto 0); 
        variable siguiente: std_logic_vector( (DIGITS * 4) - 1 downto 0);
        
        begin
            siguiente := current_digits;
            
            for i in 1 to DIGITS loop 
                digit := siguiente( i*4 - 1 downto (i - 1)*4);
                if (digit > 4) then
                    digit := digit + 3;
                end if;
                siguiente( i*4 - 1 downto (i - 1)*4) := digit;
            end loop;
            
            next_digits <= (siguiente( siguiente'length - 2 downto 0) & data_in);         
       end process;

end Behavioral;
