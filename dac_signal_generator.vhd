----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:04:39 04/29/2021 
-- Design Name: 
-- Module Name:    dac_signal_generator - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dac_signal_generator is
    Port ( Rdy : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
			  Key : in STD_LOGIC_VECTOR (3 downto 0);
           Command : out  STD_LOGIC_VECTOR (3 downto 0);
           Address : out  STD_LOGIC_VECTOR (3 downto 0);
           Data : out  STD_LOGIC_VECTOR (11 downto 0);
           Start : out  STD_LOGIC);
end dac_signal_generator;

architecture Behavioral of dac_signal_generator is

	signal clks_delay : integer := 999;
	signal clk_counter : integer := 0;
	signal var : unsigned (11 downto 0) := X"000";
begin

	with Key select clks_delay <=
		955 when "0000",	-- 1046.50 c		[ HZ ]
		901 when "0001", -- 1108.73 cis
		850 when "0010", -- 1174.66 d
		802 when "0011", -- 1244.51 dis
		758 when "0100", -- 1318.51 e
		715 when "0101", 	-- 1396.91 f
		675 when "0110", 	-- 1479.98 fis
		637 when "0111", 	-- 1567.98 g
		601 when "1000",  -- 1661.22 gis
		567 when "1001",	-- 1760.00 a
		535 when "1010",	-- 1864.66 b
		505 when "1011",	-- 1975.53 h
		0 	 when others;
	
	Command <= "0011";
	Address <= "0000";
	
	process(Clk)
	begin
			
		if rising_edge(Clk) and Rdy = '1' then
			if clks_delay /= 0 then --
				if clk_counter < clks_delay then
					clk_counter <= clk_counter + 1;
					Start <= '0';
				else
					Start <= '1';
					if var < X"FAD" then
						var <=  var + 82;
					else 
						var <= X"000";
					end if;
					clk_counter <= 0;
				end if;
			else
				var <= X"000";
				clk_counter <= 0;
			end if;
		end if;
		
	end process;
	
	Data <= STD_LOGIC_VECTOR(var);
	
end Behavioral;