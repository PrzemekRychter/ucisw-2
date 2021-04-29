----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:06:17 04/29/2021 
-- Design Name: 
-- Module Name:    keyboard_to_key - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity keyboard_to_key is
port (	
			DO : in STD_LOGIC_VECTOR(7 downto 0);
			DO_Rdy : in STD_LOGIC;
			F0 : in STD_LOGIC;
			CLK : in STD_LOGIC;
			key : out STD_LOGIC_VECTOR(3 downto 0)
		);
end keyboard_to_key;

architecture Behavioral of keyboard_to_key is
-- 7 klawiszy bialych ASDFGHJ - cdefgah
-- 5 klawiszy czarnych WE TYU - cis dis fis gis b
begin
	
  process( CLK, DO_Rdy, F0, DO )
  begin
    if( rising_edge(CLK) ) then
	 
	 case DO_Rdy & F0 & DO is
	
      when "10" & X"1C" => -- A
			key <= "0000";

      when "10" & X"1B" => -- S
			key <= "0010";

      when "10" & X"23" => -- D
			key <= "0100";
			
      when "10" & X"2B" => -- F
			key <= "0101";

		when "10" & X"34" => -- G
			key <= "0111";
		
		when "10" & X"33" => -- H
			key <= "1001";
		
		when "10" & X"3B" => -- J
			key <= "1011";
		
		when "10" & X"1D" => -- W
			key <= "0001";
		
		when "10" & X"24" => -- E
			key <= "0011";
		
		when "10" & X"2C" => -- T
			key <= "0110";
		
		when "10" & X"35" => -- Y
			key <= "1000";
		
		when "10" & X"3C" => -- U
			key <= "1010";
		
		when "00" =>
		when "01" =>
      when others =>
			key <= "1111";

    end case;
	 
	 if DO_Rdy = '1' and F0 = '1' then
		key <= "1111";
	 end if;
	end if;
  
  end process;


end Behavioral;

