library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity counter is
generic(
        bit_width : integer := 3
        );

port(
clk : in std_logic;
rst : in std_logic;

start : in std_logic;
count: out std_logic_vector(bit_width-1 downto 0)
);
end counter;

architecture Behavioral of counter is

constant max_cnt : integer := (2**bit_width)-1;
signal cnt_reg : std_logic_vector(bit_width-1 downto 0);

begin

count <= cnt_reg;

process(clk)

begin
    if rising_edge(clk) then
        if rst = '1' then
            cnt_reg <= (others => '0');    
            else
                if start = '1' then
                    if cnt_reg = max_cnt then
                        cnt_reg <= (others => '0');
                        else
                        cnt_reg <= cnt_reg + 1;
                    end if;
                    
                else
                    cnt_reg <= (others => '0');
                end if;
        end if;
    end if;
end process;


end Behavioral;
