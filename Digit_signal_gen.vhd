----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:29:06 04/10/2021 
-- Design Name: 
-- Module Name:    Dec_sign_generator - Behavioral 
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

entity Dec_sign_generator is
    Port ( Rdy : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
			  Key : in STD_LOGIC_VECTOR (3 downto 0);
           Command : out  STD_LOGIC_VECTOR (3 downto 0);
           Address : out  STD_LOGIC_VECTOR (3 downto 0);
           Data : out  STD_LOGIC_VECTOR (11 downto 0);
           Start : out  STD_LOGIC);
end Dec_sign_generator;

architecture Behavioral of Dec_sign_generator is

	signal clks_delay : integer := 999;
	signal clk_counter : integer := 0;
	signal var : unsigned (11 downto 0) := X"000";
begin

	with Key select clks_delay <=
		1275 when "0000",	-- 784  g2		[ HZ ]
		1203 when "0001", -- 830,6 gis2
		1135 when "0010", -- 880,0 a2
		1072 when "0011", -- 932,3 b2
		1011 when "0100", -- 987,8 h2
		955 when "0101", 	-- 1046,5 c3
		901 when "0110", 	-- 1108,7 cis3
		850 when "0111", 	-- 1174,7 d3
		803 when "1000",  -- 1244,5 dis3
		757 when "1001",	-- 1318,5 e3
		715 when "1010",	-- 1396,9 f3
		675 when "1011",	-- 1480,0 fis3
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
