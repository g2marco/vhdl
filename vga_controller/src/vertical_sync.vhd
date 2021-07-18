--
--  Generacion de sincronia vertical para señal VGA
--
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

--
entity vertical_sync is
    generic( FRONTP_COUNT: natural; PULSE_COUNT: natural; BACKP_COUNT: natural; FRAME_COUNT: natural); 
    
    port (
        clk        : in  std_logic;
        reset      : in  std_logic;
        end_of_line: in  std_logic;
        video_on   : out std_logic;
        vsync      : out std_logic;
        line_addr : out std_logic_vector( 9 downto 0)
    );
end vertical_sync;

architecture Behavioral of vertical_sync is
    constant CUENTA_FRONTP: natural := FRONTP_COUNT - 1;
    constant CUENTA_PULSE : natural := PULSE_COUNT  - 1;
    constant CUENTA_BACKP : natural := BACKP_COUNT  - 1;
    constant CUENTA_FRAME : natural := FRAME_COUNT  - 1;

    type estados is ( front_p, pulse, back_p, frame);
    
    signal estado: estados := pulse;
    signal cuenta: natural := 0;
    
begin

    with estado select 
    vsync <=  '0' when pulse, '1' when others;
    
    with estado select
    video_on <= '0' when frame, '1' when others;
    
    with estado select 
    line_addr <= std_logic_vector( to_unsigned(cuenta, line_addr'length)) when frame, (others => '1') when others;   
    
    estates: process ( clk) is
        begin
            if rising_edge(clk) then
                if reset = '1' then
                    estado <= pulse;
                    cuenta <= 0;
                elsif end_of_line = '0' then
                    case estado is 
                        when front_p =>
                            if cuenta = CUENTA_FRONTP then
                                estado <= pulse;
                                cuenta <= 0;
                            else 
                                cuenta <= cuenta + 1; 
                            end if;
                        when pulse =>
                            if cuenta = CUENTA_PULSE then
                                estado <= back_p;
                                cuenta <= 0;
                            else 
                                cuenta <= cuenta + 1; 
                            end if;
                        when back_p =>
                            if cuenta = CUENTA_BACKP then
                                estado <= frame;
                                cuenta <= 0;
                            else 
                                cuenta <= cuenta + 1; 
                            end if;
                        when frame =>
                            if cuenta = CUENTA_FRAME then
                                estado <= front_p;
                                cuenta <= 0;
                            else 
                                cuenta <= cuenta + 1; 
                            end if;
                        when others =>
                             estado <= pulse;
                             cuenta <= 0;
                    end case;
                end if;
            end if;
        end process; 

end Behavioral;
