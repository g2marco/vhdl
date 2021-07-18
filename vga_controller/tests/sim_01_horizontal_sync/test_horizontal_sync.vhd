
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_horizontal_sync is
end test_horizontal_sync;

architecture Behavioral of test_horizontal_sync is
    -- components
        
    component horizontal_sync is
        generic( FRONTP_COUNT: natural; PULSE_COUNT: natural; BACKP_COUNT: natural; FRAME_COUNT: natural; CLOCKS_PER_PIXEL: natural);
        port (
            clk        : in  std_logic;
            reset      : in  std_logic;
            video_on   : out std_logic;
            hsync      : out std_logic;
            end_of_line: out std_logic;
            pixel_addr : out std_logic_vector( 9 downto 0)
        );
    end component;

    -- driver signals
    signal clk  : std_logic;
    signal reset: std_logic;
    
    -- outputs
    signal video_on   : std_logic;
    signal hsync      : std_logic;
    signal end_of_line: std_logic;
    signal pixel_addr : std_logic_vector( 9 downto 0);
begin

    dut_hsync: horizontal_sync
        generic map( FRONTP_COUNT => 2, PULSE_COUNT => 4, BACKP_COUNT => 4, FRAME_COUNT => 8, CLOCKS_PER_PIXEL => 4)
        port    map( clk  => clk, reset =>reset, video_on => video_on, hsync => hsync, end_of_line => end_of_line, pixel_addr => pixel_addr);
   
    reloj: process is
        begin
            clk <= '0';
            wait for 5 ns;
            
            clk <= '1';
            wait for 5 ns;
        end process;

    clear: process is
        begin
            reset <= '1';
            wait for 30 ns;
            
            reset <= '0';
            wait for 1270 ns;
        end process;

end Behavioral;
