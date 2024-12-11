
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.seven_segment.all;

entity using_pkg is
port (
    clk : in std_logic;
    rst : in std_logic;
    
    led_out : out std_logic_vector(6 downto 0)
);

end using_pkg;

architecture Behavioral of using_pkg is

signal counter : integer range 0 to 9 := 0;
signal seven_seg_i : std_logic_vector(6 downto 0);

begin
  
led_out <= seven_seg_i;  
  
    
    process(clk)
    begin
    if rising_edge (clk) then
        if rst = '1' then
            seven_seg_i <= (others => '0');
            counter <= 0;
            else
            if counter = counter'high then
                counter <= 0;
            else
               counter <= counter + 1; 
            end if;  
        end if;
     end if;
    end process;
    
    process(counter)    
    begin
        seven_seg_i <= seven_seg_from_integer(counter);  
    end process;
end Behavioral;
