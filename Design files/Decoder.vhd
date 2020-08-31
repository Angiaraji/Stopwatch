----------------------------------------------------------------------------------
-- Company: TU-Chemnitz
-- Engineer: Rajarajeswari Angia Krishnan
-- Module Name:  Decoder (Seven Segment display selector)
-- Project Name: Stopwatch
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Decoder is
    Port ( clk     : in  STD_LOGIC;
           reset   : in  STD_LOGIC;
           data1   : in  STD_LOGIC_VECTOR (3 downto 0);
           data2   : in  STD_LOGIC_VECTOR (3 downto 0);
           data3   : in  STD_LOGIC_VECTOR (3 downto 0);
           data4   : in  STD_LOGIC_VECTOR (3 downto 0);
           anode   : out STD_LOGIC_VECTOR (3 downto 0);
           cathode : out STD_LOGIC_VECTOR (7 downto 0));
end Decoder;

architecture Behavioral of Decoder is

signal refresh_counter        : integer range 0 to 10000:= 0;
signal LED_activating_counter : integer range 0 to 3 := 0;
signal cathode_activate       : std_logic_vector(3 downto 0);

begin

clock_process: process(clk,reset)

begin

	if(reset = '0') then
		refresh_counter <= 0;
	elsif(rising_edge(clk)) then
		--if(refresh_counter = 4) then  -- for testbench
		if(refresh_counter = 10000) then -- for hardware
			refresh_counter <= 0;
				if(LED_activating_counter = 3) then
					LED_activating_counter <= 0;
				else
					LED_activating_counter <= LED_activating_counter + 1;
				end if;
		 else
			refresh_counter <= refresh_counter + 1;
		 end if;
	end if;

end process clock_process;


anode_process : process(LED_activating_counter)

begin

 case(LED_activating_counter) is

	when 0 		=> anode  <= "1110";
						
	when 1 		=> anode  <= "1101";
						
   when 2 		=> anode  <= "1011";
						
   when 3 		=> anode  <= "0111";
						
	when others => anode  <= "1111";
						
 end case;
 
end process anode_process;

cathode_process : process(LED_activating_counter, data1, data2, data3, data4)

begin

 case(LED_activating_counter) is

	when 0 		=> cathode_activate  <= data1;
				
	when 1 		=> cathode_activate  <= data2;
	
   when 2 		=> cathode_activate  <= data3;
				
   when 3 		=> cathode_activate  <= data4;
				
	when others => cathode_activate  <= "1111";

 end case;
 
end process cathode_process;

cathode_activate_process : process(cathode_activate)

begin

	case(cathode_activate) is
		
		when "0000" => cathode <= "10000001";
		when "0001" => cathode <= "11001111";
		when "0010" => cathode <= "10010010";
		when "0011" => cathode <= "10000110";
		when "0100" => cathode <= "11001100";
		when "0101" => cathode <= "10100100";
		when "0110" => cathode <= "10100000";
		when "0111" => cathode <= "10001111";
		when "1000" => cathode <= "10000000";
		when "1001" => cathode <= "10000100";
		when others => cathode <= "11111111";
		
	end case;

end process cathode_activate_process;								
									
end Behavioral;

