library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity circular_buffer is
    generic (
        DATA_WIDTH : integer := 24;
        BUFFER_DEPTH : integer := 16
    );
    port (
        clk         : in std_logic;
        rst         : in std_logic;
        write_en   : in std_logic;
        read_en     : in std_logic;
        data_in     : in std_logic_vector(DATA_WIDTH-1 downto 0);
        data_out    : out std_logic_vector(DATA_WIDTH-1 downto 0);
        buffer_full : out std_logic;
        buffer_empty: out std_logic;
        data_valid  : out std_logic
    );
end circular_buffer;

architecture Behavioral of circular_buffer is
    type buffer_array is array (0 to BUFFER_DEPTH-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
    signal buffer_mem : buffer_array;
    
    signal write_ptr : integer range 0 to BUFFER_DEPTH-1 := 0;
    signal read_ptr  : integer range 0 to BUFFER_DEPTH-1 := 0;
    signal count     : integer range 0 to BUFFER_DEPTH := 0;
    signal last_written : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal valid_data : std_logic := '0';
    
begin
    process(clk, rst)
    begin
        if rst = '1' then
            write_ptr <= 0;
            read_ptr <= 0;
            count <= 0;
            valid_data <= '0';
            buffer_full <= '0';
            buffer_empty <= '1';
            data_valid <= '0';
            buffer_mem <= (others => (others => '0'));
             
        elsif rising_edge(clk) then
            if write_en = '1' and count < BUFFER_DEPTH then
                buffer_mem(write_ptr) <= data_in;
                last_written <= data_in;
                write_ptr <= (write_ptr + 1) mod BUFFER_DEPTH;
                read_ptr <= write_ptr;                
                count <= count + 1;
                valid_data <= '1';
            end if;
            
            if read_en = '1' and valid_data = '1' then
                data_out <= buffer_mem(read_ptr);
                data_valid <= '1';
                if count > 0 then
                    read_ptr <= (read_ptr + 1) mod BUFFER_DEPTH;
                    count <= count - 1;
                end if;
            else
                data_valid <= '0';
            end if;
            
            if count = BUFFER_DEPTH then
                buffer_full <= '1';
            else
                buffer_full <= '0';
            end if;
            
            if count = 0 then
                buffer_empty <= '1';
                valid_data <= '0';
            else
                buffer_empty <= '0';
            end if;
        end if;
    end process;

end Behavioral;
