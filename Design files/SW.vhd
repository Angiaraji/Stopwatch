----------------------------------------------------------------------------------
-- Company: TU-Chemnitz
-- Engineer: Rajarajeswari Angia Krishnan
-- Module Name: SW - top
-- Project Name: Stopwatch
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SW is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           key1 : in  STD_LOGIC;
           key2 : in  STD_LOGIC;
           sseg_sel : out  STD_LOGIC_VECTOR (3 downto 0);
           sseg : out  STD_LOGIC_VECTOR (7 downto 0));
end SW;

architecture struct of SW is

component Stopwatchmodule is
    Port ( clk  : in  STD_LOGIC;
           reset: in  STD_LOGIC;
           key1 : in  STD_LOGIC;
           key2 : in  STD_LOGIC;
           hex1 : out  STD_LOGIC_VECTOR (3 downto 0);
           hex2 : out  STD_LOGIC_VECTOR (3 downto 0);
           hex3 : out  STD_LOGIC_VECTOR (3 downto 0);
           hex4 : out  STD_LOGIC_VECTOR (3 downto 0));
end component Stopwatchmodule;

component Decoder is
    Port ( clk     : in  STD_LOGIC;
           reset   : in  STD_LOGIC;
           data1   : in  STD_LOGIC_VECTOR (3 downto 0);
           data2   : in  STD_LOGIC_VECTOR (3 downto 0);
           data3   : in  STD_LOGIC_VECTOR (3 downto 0);
           data4   : in  STD_LOGIC_VECTOR (3 downto 0);
           anode   : out STD_LOGIC_VECTOR (3 downto 0);
           cathode : out STD_LOGIC_VECTOR (7 downto 0));
end component Decoder;

component Debounce is
    Port ( clk : in  STD_LOGIC;
			  button_in : in  STD_LOGIC;
           debounce_out : out  STD_LOGIC);
end component Debounce;

signal hex1_s, hex2_s, hex3_s, hex4_s : std_logic_vector(3 downto 0);
signal key1_s, key2_s                 : std_logic;

begin

timer : Stopwatchmodule
			port map ( clk   => clk,
						  reset => reset,
                    key1  => key1_s,
						  key2  => key2_s,
						  hex1  => hex1_s,
						  hex2  => hex2_s,
						  hex3  => hex3_s,
						  hex4  => hex4_s);
							  
key1_debounce : Debounce
			 port map( clk          => clk,
            		  button_in    => key1,
						  debounce_out => key1_s);
							
key2_debounce : Debounce
			 port map( clk          => clk,
						  button_in    => key2,
						  debounce_out => key2_s);
							
seven_segment : Decoder							
			 port map ( clk     => clk,  
							reset   => reset,
							data1   => hex1_s,
							data2   => hex2_s,
							data3   => hex3_s,
							data4   => hex4_s,
							anode   => sseg_sel,
							cathode => sseg); 
end struct;

