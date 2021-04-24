----------------------------------------------------------------------------------
-- Description: binary to bcd converter with hold/convert control input 
-- 
-- @author  Marco Antonio Garcia G.     g2marco@yahoo.com.mx
----------------------------------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

--
entity binary_to_bcd is
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
end binary_to_bcd;

--
architecture behavioral of binary_to_bcd is
    signal next_digits   : std_logic_vector( (DIGITS * 4) - 1 downto 0);
    signal current_digits: std_logic_vector( (DIGITS * 4) - 1 downto 0);
    
begin
    
    bcd_digits <= current_digits;
    
    estados: process( clk) is
        begin
            if rising_edge( clk) then
                if reset = '1' then
                    current_digits <= (others => '0');
                elsif hold_nconvert = '0' then                          -- 0: convert
                    current_digits <= next_digits;
                end if;                                                 -- 1: hold
            end if;
        end process;
    
    convert: process( current_digits, data_in) is
        variable digit    : std_logic_vector( 3 downto 0); 
        variable siguiente: std_logic_vector( (DIGITS * 4) - 1 downto 0);
        
        begin
            siguiente := current_digits;
  
            -- transform (conditional excess 3)          
            for i in 1 to DIGITS loop 
                digit := siguiente( i*4 - 1 downto (i - 1)*4);
                if (digit > 4) then
                    digit := digit + 3;
                end if;
                siguiente( i*4 - 1 downto (i - 1)*4) := digit;
            end loop;
            
            -- shift to the left
            next_digits <= (siguiente( siguiente'length - 2 downto 0) & data_in);         
       end process;

end behavioral;
