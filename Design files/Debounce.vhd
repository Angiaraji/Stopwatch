----------------------------------------------------------------------------------
-- Company: TU-Chemnitz
-- Engineer: Rajarajeswari Angia Krishnan
-- Module Name:  Pushbutton Debounce
-- Project Name: Stopwatch
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Debounce is
    Port ( clk : in  STD_LOGIC;
			  button_in : in  STD_LOGIC;
           debounce_out : out  STD_LOGIC);
end Debounce;

architecture Behavioral of Debounce is

signal flipflop    : std_logic_vector(1 downto 0);
signal set_counter : std_logic;
signal counter_out : integer range 0 to 1000000 := 0;

begin

	set_counter <= flipflop(0) xor flipflop(1);
	
debounce_process: process(clk)

begin
	
   if(rising_edge(clk)) then
		flipflop(0) <= button_in;
		flipflop(1) <= flipflop(0);
			if(set_counter = '1') then
				counter_out <= 0;
	   -- elsif(counter_out = 4) then -- for testbench
		 elsif(counter_out = 1000000) then -- for hardware
				counter_out <= 0;
				debounce_out <= flipflop(1);
			else
				counter_out <= counter_out + 1;
			end if;
	end if;
 
end process debounce_process;

end Behavioral;

