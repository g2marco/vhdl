
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_vertical_sync is
end test_vertical_sync;

architecture Behavioral of test_vertical_sync is
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

    component vertical_sync is
        generic( FRONTP_COUNT: natural; PULSE_COUNT: natural; BACKP_COUNT: natural; FRAME_COUNT: natural); 
        port (
            clk        : in  std_logic;
            reset      : in  std_logic;
            end_of_line: in  std_logic;
            video_on   : out std_logic;
            vsync      : out std_logic;
            line_addr : out std_logic_vector( 9 downto 0)
        );
    end component; 

    -- driver signals
    signal clk  : std_logic;
    signal reset: std_logic;
    
    -- outputs
    signal hvideo_on   : std_logic;
    signal vvideo_on   : std_logic;
    
    signal hsync      : std_logic;
    signal vsync      : std_logic;
    
    signal end_of_line: std_logic;
    
    signal pixel_addr : std_logic_vector( 9 downto 0);
    signal line_addr  : std_logic_vector( 9 downto 0);
    
begin

    dut_hsync: horizontal_sync
        generic map( FRONTP_COUNT => 2, PULSE_COUNT => 4, BACKP_COUNT => 4, FRAME_COUNT => 8, CLOCKS_PER_PIXEL => 4)
        port    map( clk  => clk, reset =>reset, video_on => hvideo_on, hsync => hsync, end_of_line => end_of_line, pixel_addr => pixel_addr);
   
    dut_vsync: vertical_sync
        generic map( FRONTP_COUNT => 2, PULSE_COUNT => 2, BACKP_COUNT => 2, FRAME_COUNT => 8)
        port    map(
            clk  => clk, 
            reset =>reset, 
            end_of_line => end_of_line,
            video_on => vvideo_on,
            vsync => vsync, 
            line_addr => line_addr
        );
        
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
            wait for 50000 ns;
        end process;

end Behavioral;
