----------------------------------------------------------------------------------
-- Description: Configurable binary to BCD converter
--      DIGITS_BCD : number of BCD output digits (groups of 4 bits)
--      BITS_DATA  : number of bits in the binary input data
-- 
-- @author  Marco Antonio Garcia G.     g2marco@yahoo.com.mx
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--
entity binary_bcd_converter is
    --
    --  DIGITS_BCD : number of BCD output digits (groups of 4 bits)
    --  BITS_DATA  : number of bits in the binary input data
    --
    generic ( DIGITS_BCD: natural; BITS_DATA: natural);
    port (
        clk       : in    std_logic;
        reset     : in    std_logic;
        nconvert  : in    std_logic;
        data      : in    std_logic_vector( BITS_DATA  - 1 downto 0);
        bcd_digits: inout std_logic_vector((DIGITS_BCD*4) - 1 downto 0)
    );
end binary_bcd_converter;

--
architecture Behavioral of binary_bcd_converter is
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
    
    --
    component load_shift is
        --  
        --  DATA_BITS: length of the parallel data input
        --
        generic( DATA_BITS: natural);
        port (
            clk        : in  std_logic;
            reset      : in  std_logic;
            load_nshift: in  std_logic;                                     -- 1 parallel load, 0 shift left                                            
            data       : in  std_logic_vector( DATA_BITS - 1 downto 0);     -- parallel data input
            data_out   : out std_logic                                      -- serial data output
        );
    end component;
    
    --
    component  controlador is
       --
        --  DATA_BITS: length of the binary data that will be converted
        --
        generic( DATA_BITS: natural);
        port (
            clk           : in  std_logic;
            reset         : in  std_logic;
            nconvert      : in  std_logic;                                   -- input for starting a convertion  
            load_nshift   : out std_logic;                                   -- control signal for the load_shift block 
            hold_nconvert : out std_logic;                                   -- control signal for the binary_to_bcd block
            internal_reset: out std_logic                                    -- internal reset, before starting a new conversion
        );
   end component;
   
   --
   signal serial_data   : std_logic; 
   signal load_nshift   : std_logic;
   signal hold_nconvert : std_logic;
   signal internal_reset: std_logic;

begin

    convertidor : binary_to_bcd 
        generic map( DIGITS => DIGITS_BCD)
        port    map( clk => clk, reset => internal_reset, hold_nconvert => hold_nconvert, data_in => serial_data, bcd_digits => bcd_digits);
       
    registro    : load_shift
        generic map( DATA_BITS => BITS_DATA)
        port    map( clk => clk, reset => reset, load_nshift => load_nshift, data => data, data_out => serial_data);
    
    control     : controlador
        generic map( DATA_BITS => BITS_DATA)
        port    map(
            clk => clk, reset => reset, nconvert => nconvert, 
            load_nshift => load_nshift, hold_nconvert => hold_nconvert, internal_reset => internal_reset
        );
     
end Behavioral;
