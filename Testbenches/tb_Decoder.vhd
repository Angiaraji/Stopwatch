----------------------------------------------------------------------------------
-- Company: TU-Chemnitz
-- Engineer: Rajarajeswari Angia Krishnan
-- Module Name:  Decoder - testbench
-- Project Name: Stopwatch
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity decoder_tb is
end decoder_tb;

architecture test of decoder_tb is

component decoder 
     Port (clk     : in  STD_LOGIC;
           reset   : in  STD_LOGIC;
           data1   : in  STD_LOGIC_VECTOR (3 downto 0);
           data2   : in  STD_LOGIC_VECTOR (3 downto 0);
           data3   : in  STD_LOGIC_VECTOR (3 downto 0);
           data4   : in  STD_LOGIC_VECTOR (3 downto 0);
           anode   : out STD_LOGIC_VECTOR (3 downto 0);
           cathode : out STD_LOGIC_VECTOR (7 downto 0));
end component;


    signal clk     : std_logic:= '0';
    signal reset   : std_logic:= '0';
    signal data1   : std_logic_vector (3 downto 0):=(others => '0');
    signal data2   : std_logic_vector (3 downto 0):=(others => '0');
    signal data3   : std_logic_vector (3 downto 0):=(others => '0');
    signal data4   : std_logic_vector (3 downto 0):=(others => '0');
    signal anode   : std_logic_vector (3 downto 0);
    signal cathode : std_logic_vector (7 downto 0);
	 
	 constant clk_period : time := 50 ns;
	 
begin

DUT : decoder
    port map (clk     => clk,
              reset   => reset,
              data1   => data1,
              data2   => data2,
              data3   => data3,
              data4   => data4,
              anode   => anode,
              cathode => cathode);
				  

clk <= not clk after clk_period/2;
--
--reset_process : process
--
--	begin
--		  reset <= '1';
--        wait for 100 ns;
--        reset <= '0';
--        wait;
--end process reset_process;

wavegen_proc: process      
begin

wait for 100 ns;	
wait for clk_period*10;
	
	reset <= '0';
	wait for 200 ns;	
	reset <= '1';
	wait for 200 ns;

for i in 0 to 15 loop

data1 <= std_logic_vector(to_unsigned(i,4));
data2 <= std_logic_vector(to_unsigned(i,4));
data3 <= std_logic_vector(to_unsigned(i,4));
data4 <= std_logic_vector(to_unsigned(i,4));

wait for 20ns;

end loop;

wait;
end process wavegen_proc;

end test;


configuration decoder_tb_test_cfg of decoder_tb is
for test
end for;
end decoder_tb_test_cfg;

