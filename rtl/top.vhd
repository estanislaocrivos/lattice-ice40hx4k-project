library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port (
        clk        : in  std_logic;
        led_green  : out std_logic;
        led_red    : out std_logic;
        led_yellow : out std_logic;
        led_blue   : out std_logic
    );
end entity top;

architecture rtl of top is
    signal counter : unsigned(23 downto 0) := (others => '0');
begin
    process (clk)
    begin
        if rising_edge(clk) then
            counter <= counter + 1;
        end if;
    end process;

    led_green  <= counter(23); -- ~0.7 Hz
    led_red    <= counter(22); -- ~1.4 Hz
    led_yellow <= counter(21); -- ~2.8 Hz
    led_blue   <= counter(20); -- ~5.7 Hz

end architecture rtl;
