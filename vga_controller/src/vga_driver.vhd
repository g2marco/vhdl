library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;

entity vga_driver is
    port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        hsync   : out std_logic;
        vsync   : out std_logic;
        vgaRed  : out std_logic_vector(3 downto 0);
        vgaBlue : out std_logic_vector(3 downto 0);
        vgaGreen: out std_logic_vector(3 downto 0)
    );
end vga_driver;

architecture Behavioral of vga_driver is
    --
    
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
    
    -- internal signals
    signal hvideo_on   : std_logic;
    signal vvideo_on   : std_logic;
    
    signal end_of_line : std_logic;
    
    signal pixel_addr  : std_logic_vector( 9 downto 0);
    signal line_addr   : std_logic_vector( 9 downto 0);
begin

    hsync_gen: horizontal_sync
        generic map ( FRONTP_COUNT => 16, PULSE_COUNT => 96, BACKP_COUNT => 48, FRAME_COUNT => 640, CLOCKS_PER_PIXEL => 4)
        port    map( clk  => clk, reset =>reset, video_on => hvideo_on, hsync => hsync, end_of_line => end_of_line, pixel_addr => pixel_addr);
   
    dut_vsync: vertical_sync
        generic map( FRONTP_COUNT => 10, PULSE_COUNT => 2, BACKP_COUNT => 29, FRAME_COUNT => 480)
        port    map(
            clk  => clk, 
            reset =>reset, 
            end_of_line => end_of_line,
            video_on => vvideo_on,
            vsync => vsync, 
            line_addr => line_addr
        );
    
    vgaRed   <= "0001" when (hvideo_on = '0' and vvideo_on = '0' and pixel_addr <= "0010011111") else
                "0010" when (hvideo_on = '0' and vvideo_on = '0' and pixel_addr > "0010011111" and pixel_addr <= "0100111111") else
                "0011" when (hvideo_on = '0' and vvideo_on = '0' and pixel_addr > "0100111111" and pixel_addr <= "0111011111") else
                "0100" when (hvideo_on = '0' and vvideo_on = '0' and pixel_addr > "0111011111") else
                "0000";
    vgaBlue  <= "0101" when (hvideo_on = '0' and vvideo_on = '0' and pixel_addr <= "0010011111") else
                "0110" when (hvideo_on = '0' and vvideo_on = '0' and pixel_addr > "0010011111" and pixel_addr <= "0100111111") else
                "0111" when (hvideo_on = '0' and vvideo_on = '0' and pixel_addr > "0100111111" and pixel_addr <= "0111011111") else
                "1000" when (hvideo_on = '0' and vvideo_on = '0' and pixel_addr > "0111011111") else
                "0000";
    vgaGreen <= "1001" when (hvideo_on = '0' and vvideo_on = '0' and pixel_addr <= "0010011111") else
                "1010" when (hvideo_on = '0' and vvideo_on = '0' and pixel_addr > "0010011111" and pixel_addr <= "0100111111") else
                "1011" when (hvideo_on = '0' and vvideo_on = '0' and pixel_addr > "0100111111" and pixel_addr <= "0111011111") else
                "1100" when (hvideo_on = '0' and vvideo_on = '0' and pixel_addr > "0111011111") else
                "0000";
end Behavioral;
