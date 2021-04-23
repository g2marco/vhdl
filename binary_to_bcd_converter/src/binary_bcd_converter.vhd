library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity binary_bcd_converter is
    --
    -- DIGITOS  : numero de digitos BCD
    -- DATA_BITS: numero de bits del dato binario a convertir 
    --
    generic ( DIGITOS: natural; DATA_BITS: natural);
    port (
        clk       : in    std_logic;
        reset     : in    std_logic;
        nconvert  : in    std_logic;
        data      : in    std_logic_vector( DATA_BITS  - 1 downto 0);
        bcd_digits: inout std_logic_vector((DIGITOS*4) - 1 downto 0)
    );
end binary_bcd_converter;

architecture Behavioral of binary_bcd_converter is
    -- 
    component binary_to_bcd is
        generic( DIGITS : natural);
        port(
            clk       : in    std_logic;
            reset     : in    std_logic;
            nconvert  : in    std_logic;
            data_in   : in    std_logic;
            bcd_digits: inout std_logic_vector( (DIGITS*4) - 1 downto 0) 
        );
    end component;
    
    --
    component load_shift is
        generic( DATA_BITS: natural);
        port (
            reset   : in  std_logic;
            clk     : in  std_logic;
            load    : in  std_logic;
            data    : in  std_logic_vector( DATA_BITS - 1 downto 0);
            data_out: out std_logic
       );
    end component;
    
    --
    component  controlador is
       generic( DATA_BITS: natural);
       port (
           nconvert    : in  std_logic;        -- start of operation
           reset       : in  std_logic;
           clk         : in  std_logic;
           load_shift  : out std_logic;        -- control of parallel load - shift
           hold_convert: out std_logic;        -- control of binary to bcd converter
           init_convert: out std_logic
       );
   end component;
   
   --
   signal serial_data : std_logic; 
   signal load        : std_logic;
   signal convert     : std_logic;
   signal init_convert: std_logic;

begin

    convertidor : binary_to_bcd 
        generic map( DIGITOS)
        port    map( clk => clk, reset => init_convert, nconvert => convert, data_in => serial_data, bcd_digits => bcd_digits);
       
    registro    : load_shift
        generic map( DATA_BITS)
        port    map( clk => clk, reset => reset, load => load, data => data, data_out => serial_data);
    
    control     : controlador
        generic map( DATA_BITS)
        port    map( clk => clk, reset => reset, nconvert => nconvert, load_shift => load, hold_convert => convert, init_convert => init_convert);
     
end Behavioral;
