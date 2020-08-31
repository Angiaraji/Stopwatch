----------------------------------------------------------------------------------
-- Company: TU-Chemnitz
-- Engineer: Rajarajeswari Angia Krishnan
-- Module Name:  Debounce testbench
-- Project Name: Stopwatch
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_debounce is
end tb_debounce;

architecture tb of tb_debounce is

component Debounce
Port ( clk : in  STD_LOGIC;
		 button_in : in  STD_LOGIC;
       debounce_out : out  STD_LOGIC);		 
end component Debounce;

signal clk : std_logic := '0';
signal button_in : std_logic := '0';

signal debounce_out : std_logic;

constant clk_period : time := 50 ns;

begin

DUT : Debounce

port map(clk => clk,
			button_in => button_in,
         debounce_out => debounce_out);
			
clk_process :process

   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
		
end process clk_process;

stimulus_proc: process
   begin  
		button_in <= '0';
     
		wait for clk_period*10;
		 
        button_in <= '1';   wait for clk_period*2;
        button_in <= '0';   wait for clk_period*1;
        button_in <= '1';   wait for clk_period*1;
        button_in <= '0';   wait for clk_period*20;
       
        button_in <= '1';   wait for clk_period*1;
        button_in <= '0';   wait for clk_period*1;
        button_in <= '1';   wait for clk_period*1;
        button_in <= '0';   wait for clk_period*2;
        button_in <= '1';   wait for clk_period*20;
        button_in <= '0'; 
		  wait;
		
end process stimulus_proc;


end tb;

