----------------------------------------------------------------------------------
-- Company: TU-Chemnitz
-- Engineer: Rajarajeswari Angia Krishnan
-- Module Name: Stopwatch module
-- Project Name: Stopwatch
---------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Stopwatchmodule is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           key1 : in  STD_LOGIC;
           key2 : in  STD_LOGIC;
           hex1 : out  STD_LOGIC_VECTOR (3 downto 0);
           hex2 : out  STD_LOGIC_VECTOR (3 downto 0);
           hex3 : out  STD_LOGIC_VECTOR (3 downto 0);
           hex4 : out  STD_LOGIC_VECTOR (3 downto 0));
end Stopwatchmodule;

architecture Behavioral of Stopwatchmodule is

type state is (start,run,stop);

signal current_state : state := start;
signal next_state    : state;

signal onesec_clk		: std_logic := '0';
signal clk_count     : integer range 0 to 10000000 := 0;

signal key1_pressed  : integer range 0 to 2;
signal init_zero		: std_logic;
signal start_count   : std_logic;

signal sec0          : integer range 0 to 9;
signal sec1          : integer range 0 to 5;
signal min0          : integer range 0 to 9;
signal min1          : integer range 0 to 5;

begin

clock_process : process(reset, init_zero, clk)

begin

 if(reset = '0' or init_zero = '1') then
		onesec_clk <= '0';
		clk_count  <= 0;
	elsif(rising_edge(clk)) then
		if(start_count = '1') then
			if(clk_count = 10000000) then -- for hardware
			--if(clk_count = 20) then -- for testbench
				onesec_clk <= not onesec_clk;
				clk_count  <= 0;
			else
				clk_count  <= clk_count + 1;
			end if;
		end if;
 end if;

end process clock_process;


key1press_process : process(reset, key1)

begin

	if(reset = '0') then
		key1_pressed <= 0;
	 elsif(rising_edge(key1)) then
		if(key1_pressed = 2) then
			key1_pressed <= 1;
		else
			key1_pressed <= key1_pressed + 1;
		end if;
	end if;
	
end process key1press_process;


timecount_process : process(reset, onesec_clk, init_zero)

begin
	
	if(reset = '0' or init_zero = '1') then
		sec0 <= 0;
		sec1 <= 0;
		min0 <= 0;
		min1 <= 0;
	elsif(rising_edge(onesec_clk)) then
		sec0 <= sec0 + 1;
		if (sec0 = 9) then
		  sec0 <= 0;
		  sec1 <= sec1 + 1;
			if (sec1 = 5) then
			  sec1 <= 0;
			  min0 <= min0 + 1;
			    if (min0 = 9) then
				   min0 <= 0;
				   min1 <= min1 + 1;
				     if (min1 = 5) then
					    min1 <= 0;
				     end if;
			    end if;
		   end if;
	    end if;
	end if;

end process timecount_process;


register_process : process(reset, clk) 

begin

	if(reset = '0') then
		current_state <= start;
	elsif(rising_edge(clk)) then
		current_state <= next_state;
	end if;

end process register_process;


transition_process : process(current_state, key1_pressed, key2)

begin

	case current_state is
	
		when start => if(key1_pressed = 1) then
								next_state <= run;
						  else
								next_state <= start;
						  end if;
						  
		when run   => if(key1_pressed = 2) then
								next_state <= stop;
						  else
								next_state <= run;
						  end if;
						  
		when stop  => if(key1_pressed = 1) then
								next_state <= run;
						  else
								next_state <= stop;
						  end if;
						  
		when others => next_state <= start;
		
	end case;
	
end process transition_process;

output_process : process(reset,clk)

begin
	
		if(reset = '0') then
			start_count <= '0';
			init_zero   <= '1';
		elsif(rising_edge(clk)) then
			case current_state is
				
				when start => start_count <= '0';
								  init_zero   <= '1';

				when run   => if(key2 = '1') then
										start_count <= '1';
										init_zero   <= '1';
								  else
										start_count <= '1';
										init_zero   <= '0';
								  end if;
								  
				when stop  => if(key2 = '1') then
										start_count <= '0';
										init_zero   <= '1';
								  else
										start_count <= '0';
										init_zero   <= '0';
								  end if;
								  
				when others => start_count <= '0';
									init_zero   <= '1';
									
		  end case;
		end if;
		
end process output_process;

hex1 <= std_logic_vector(to_unsigned(sec0, 4));
hex2 <= std_logic_vector(to_unsigned(sec1, 4));
hex3 <= std_logic_vector(to_unsigned(min0, 4));
hex4 <= std_logic_vector(to_unsigned(min1, 4));

end Behavioral;

