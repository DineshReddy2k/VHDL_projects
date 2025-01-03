library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity circular_buffer_tb is
end circular_buffer_tb;

architecture Behavioral of circular_buffer_tb is
    constant CLK_PERIOD : time := 10 ns;
    constant DATA_WIDTH : integer := 24;
    constant BUFFER_DEPTH : integer := 16;

    signal clk         : std_logic := '0';
    signal rst         : std_logic := '0';
    signal write_en    : std_logic := '0';
    signal read_en     : std_logic := '0';
    signal data_in     : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
    signal data_out    : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal buffer_full : std_logic;
    signal buffer_empty: std_logic;
    signal data_valid  : std_logic;

    component circular_buffer is
        generic (
            DATA_WIDTH : integer := 24;
            BUFFER_DEPTH : integer := 16
        );
        port (
            clk         : in std_logic;
            rst         : in std_logic;
            write_en    : in std_logic;
            read_en     : in std_logic;
            data_in     : in std_logic_vector(DATA_WIDTH-1 downto 0);
            data_out    : out std_logic_vector(DATA_WIDTH-1 downto 0);
            buffer_full : out std_logic;
            buffer_empty: out std_logic;
            data_valid  : out std_logic
        );
    end component;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: circular_buffer
        generic map (
            DATA_WIDTH => DATA_WIDTH,
            BUFFER_DEPTH => BUFFER_DEPTH
        )
        port map (
            clk => clk,
            rst => rst,
            write_en => write_en,
            read_en => read_en,
            data_in => data_in,
            data_out => data_out,
            buffer_full => buffer_full,
            buffer_empty => buffer_empty,
            data_valid => data_valid
        );

    -- Clock process
    clk_process: process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process;


    rst_process: process
    begin
        wait for CLK_PERIOD;
        rst <= '1';
        wait for CLK_PERIOD/2;
        rst <= '0';
        wait for CLK_PERIOD/2;
        wait for 10 ms;
        
    end process;
    
    
    -- Stimulus process
    write_stim_proc: process
    begin

        -- First write
        write_en <= '1';
        data_in <= x"123456";
        wait for CLK_PERIOD;
        write_en <= '0';
        
        wait for 300 us;

        -- Second write
        write_en <= '1';
        data_in <= x"ABCDEF";
        wait for CLK_PERIOD;
        write_en <= '0';
        wait for 300 us;
        
    end process;


    
    -- Stimulus process
    read_stim_proc: process
    begin

        -- Five reads
        for i in 1 to 5 loop
            read_en <= '1';
            wait for CLK_PERIOD;
            read_en <= '0';
            wait for CLK_PERIOD;
            
            wait for 1800 us;
            
        end loop;
        
    end process;



end Behavioral;

