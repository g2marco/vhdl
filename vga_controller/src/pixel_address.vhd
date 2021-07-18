library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;

entity pixel_address is
    generic( FRONTP_COUNT: natural; PULSE_COUNT: natural; BACKP_COUNT: natural; FRAME_COUNT: natural); 
    
    port (
        clk       : in  std_logic;
        reset     : in  std_logic;
        enable    : in  std_logic;        
        row_enable: out std_logic;
        hsync     : out std_logic
    );

end pixel_address;

architecture Behavioral of pixel_address is
    
    signal line_addr: std_logic_vector(10 downto 0) := ADDR_ZERO;
begin
    estates: process ( clk) is
        begin
            if rising_edge(clk) then
                if reset = '1'  or enable = '1' then
                    estado    <= front_p;
                    contador  <= FRONTP_COUNT - 1;
                    line_addr <= ADDR_ZERO; 
                else
                    case estado is 
                        when front_p =>
                            if contador = 0 then
                                estado   <= pulse;
                                contador <= PULSE_COUNT - 1;
                            else 
                                contador <= contador - 1; 
                            end if;
                        when pulse =>
                            if contador = 0 then
                                estado <= back_p;
                                contador <= BACKP_COUNT - 1;
                            else 
                                contador <= contador - 1; 
                            end if;
                        when back_p =>
                            if contador = 0 then
                                estado <= frame;
                                contador <= FRAME_COUNT - 1;
                                line_addr <= line_addr + 1;
                            else 
                                contador <= contador - 1; 
                            end if;
                        when frame =>
                            if contador = 0 then
                                estado <= front_p;
                                contador <= FRONTP_COUNT - 1;
                            else 
                                contador <= contador - 1; 
                            end if;
                        when others =>
                            if contador = 0 then
                                estado <= front_p;
                                contador <= FRONTP_COUNT - 1;
                            else 
                                contador <= contador - 1; 
                            end if;
                    end case;
                end if;
            end if;
        end process; 
    
    address: process( clk) is 
        begin
            if rising_edge( clk) then 
                row_addr <= line_addr;
            end if;
        end process;
        
end Behavioral;
