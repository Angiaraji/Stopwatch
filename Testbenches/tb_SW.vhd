----------------------------------------------------------------------------------
-- Company: TU-Chemnitz
-- Engineer: Rajarajeswari Angia Krishnan
-- Module Name: SW-testbench
-- Project Name: Stopwatch
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_SW is
end tb_SW;

architecture tb of tb_SW is

    component SW
        port (clk      : in std_logic;
              reset    : in std_logic;
              key1     : in std_logic;
              key2     : in std_logic;
              sseg_sel : out std_logic_vector (3 downto 0);
              sseg     : out std_logic_vector (7 downto 0));
    end component;

    signal clk_s      : std_logic:='0';
    signal reset_s    : std_logic:='0';
    signal key1_s     : std_logic:='0';
    signal key2_s     : std_logic:='0';
    signal sseg_sel : std_logic_vector (3 downto 0);
    signal sseg     : std_logic_vector (7 downto 0);

begin

    dut : SW
    port map (clk      => clk_s,
              reset    => reset_s,
              key1     => key1_s,
              key2     => key2_s,
              sseg_sel => sseg_sel,
              sseg     => sseg);

    -- Clock generation
process
  begin
	clk_s <= not clk_s;
	wait for 50 ns;
end process;

process
 begin
	 
	reset_s <= '0';
	wait for 2000 ms;	
	reset_s <= '1';
	wait for 2000 ms;

	key1_s <= '1';
	wait for 20 ms;
	key1_s <= '0';

	wait for 5000 ms;

	key1_s <= '1';
	wait for 20 ms;
	key1_s <= '0';

	wait for 2000 ms;

	key1_s <= '1';
	wait for 20 ms;
	key1_s <= '0';

	wait for 6000 ms;

	key2_s <= '1';
	wait for 20 ms;
	key2_s <= '0';

	wait for 2000 ms;

	key1_s <= '1';
	wait for 20 ms;
	key1_s <= '0';

	wait for 6000 ms;

	key2_s <= '1';
	wait for 20 ms;
	key2_s <= '0';

	wait for 6000 ms;

	key1_s <= '1';
	wait for 20 ms;
	key1_s <= '0';

	wait;
end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_SW of tb_SW is
    for tb
    end for;
end cfg_tb_SW;

