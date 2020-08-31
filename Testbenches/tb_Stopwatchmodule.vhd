----------------------------------------------------------------------------------
-- Company: TU-Chemnitz
-- Engineer: Rajarajeswari Angia Krishnan
-- Module Name: Stopwatch module - testbench
-- Project Name: Stopwatch
---------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Stopwatchmodule is
end tb_Stopwatchmodule;

architecture tb of tb_Stopwatchmodule is

    component Stopwatchmodule
        port (clk   : in std_logic;
              reset : in std_logic;
              key1  : in std_logic;
              key2  : in std_logic;
              hex1  : out std_logic_vector (3 downto 0);
              hex2  : out std_logic_vector (3 downto 0);
              hex3  : out std_logic_vector (3 downto 0);
              hex4  : out std_logic_vector (3 downto 0));
    end component;

    signal clk_s   : std_logic:= '0';
    signal reset : std_logic:= '0';
    signal key1  : std_logic:= '0';
    signal key2  : std_logic:= '0';
    signal hex1_s  : std_logic_vector (3 downto 0);
    signal hex2_s  : std_logic_vector (3 downto 0);
    signal hex3_s  : std_logic_vector (3 downto 0);
    signal hex4_s  : std_logic_vector (3 downto 0);

     
begin

    dut : Stopwatchmodule
    port map (clk   => clk_s,
              reset => reset,
              key1  => key1,
              key2  => key2,
              hex1  => hex1_s,
              hex2  => hex2_s,
              hex3  => hex3_s,
              hex4  => hex4_s);

    -- Clock generation
	 
process
begin
	clk_s <= not clk_s;
	wait for 50 ns;
end process;

    

process

begin
				
   -- Reset generation
   reset <= '0';
	wait for 2000 ms;	
	reset <= '1';
	wait for 2000 ms;

	key1 <= '1';
	wait for 20 ms;
	key1 <= '0';

	wait for 5000 ms;

	key1 <= '1';
	wait for 20 ms;
	key1 <= '0';

	wait for 2000 ms;

	key1 <= '1';
	wait for 20 ms;
	key1 <= '0';

	wait for 6000 ms;

	key2 <= '1';
	wait for 20 ms;
	key2 <= '0';

	wait for 2000 ms;

	key1 <= '1';
	wait for 20 ms;
	key1 <= '0';

	wait for 6000 ms;

	key2 <= '1';
	wait for 20 ms;
	key2 <= '0';

	wait for 6000 ms;

	key1 <= '1';
	wait for 20 ms;
	key1 <= '0';

	wait;

end process;

end tb;


configuration cfg_tb_Stopwatchmodule of tb_Stopwatchmodule is
    for tb
    end for;
end cfg_tb_Stopwatchmodule;

