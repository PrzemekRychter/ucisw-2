----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 13:01:19 05/12/2021
-- Design Name:
-- Module Name: VGAController - Behavioral
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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY VGAController IS
	PORT (
		Clk : IN STD_LOGIC;
		key : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		char_DI : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
		char_WE : OUT STD_LOGIC := '1');
END VGAController;

ARCHITECTURE Behavioral OF VGAController IS
	TYPE state_type IS (Start, C, Cis ,I,S, D, Dis, E, F, Fis, G, Gis, A, B, H, Space, SecondsS, Dot, FractionsOfSecond, Space2);
	SIGNAL state, next_state : state_type;
	SIGNAL lastKey : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL counter, tensOfASecond, seconds : integer := 0;
	SIGNAL tensOfASecondToDisplay, secondsToDisplay : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
	
	nextStateProcess : PROCESS (Clk)
	BEGIN
		IF rising_edge(Clk) THEN
				state <= next_state;
				lastKey <= key;
		END IF;
	END PROCESS;

	logicProcess : PROCESS (state, key)
		BEGIN
		next_state <= state; --default
		CASE state IS
			WHEN Start => 
					IF key = "0000"  	  THEN next_state <= C;
					ELSIF key = "0001"  THEN next_state <= Cis;
					ELSIF key = "0010"  THEN next_state <= D;
					ELSIF key = "0011"  THEN next_state <= Dis;
					ELSIF key = "0100"  THEN next_state <= E;
					ELSIF key = "0101"  THEN next_state <= F;
					ELSIF key = "0110"  THEN next_state <= Fis;
					ELSIF key = "0111"  THEN next_state <= G;
					ELSIF key = "1000"  THEN next_state <= Gis;
					ELSIF key = "1001"  THEN next_state <= A;
					ELSIF key = "1010"  THEN next_state <= B;
					ELSIF key = "1011"  THEN next_state <= H;
					ELSE next_state <= Start; END IF;

			WHEN C | D | E | F | G | A | B | H => next_state <= Space;
			WHEN Space => 								  next_state <= SecondsS;
			WHEN SecondsS => 							  next_state <= Dot;
			WHEN Dot => 					           next_state <= FractionsOfSecond;
			WHEN FractionsOfSecond => 	           next_state <= Space2;
			WHEN Space2 => 				           next_state <= Start;
			
			--is
			WHEN Cis | Dis | Fis | Gis 			=> next_state <= I;
			WHEN I										=> next_state <= S;
			WHEN S										=> next_state <= Space;
			
			
			when others => next_state <= Start;
		END CASE;
	END PROCESS;

	outputProcess : PROCESS (state)
	BEGIN
		CASE state IS
			WHEN Start => 
				char_DI <= "00000000"; -- null
			WHEN C | Cis=> 
				char_DI <= x"43"; -- C
			WHEN D | Dis => 
				char_DI <= X"44"; -- D
			WHEN E => 
				char_DI <= X"45"; -- E
			WHEN F | Fis=> 
				char_DI <= X"46"; -- F
			WHEN G => 
				char_DI <= X"47"; -- G
			WHEN A => 
				char_DI <= X"41"; -- A
			WHEN H => 
				char_DI <= X"48"; -- H
			WHEN I => 
				char_DI <= X"69"; -- i
			WHEN S => 
				char_DI <= X"73"; -- s
			WHEN Space | Space2 => 
				char_DI <= "00100000"; -- Space
			WHEN SecondsS => 
				char_DI <= std_logic_vector(X"3" & secondsToDisplay(3 DOWNTO 0));
			WHEN Dot => 
				char_DI <= "00101110"; -- Dot
			WHEN FractionsOfSecond => 
				char_DI <= std_logic_vector(X"3" & tensOfASecondToDisplay(3 DOWNTO 0));
			WHEN OTHERS => char_DI <= "00000000"; -- null 
		END CASE;
	END PROCESS;

	--CLK freq = 50 Mhz T = 1/(50*10^6) s
	-- 1/10s = T * 5 * 10^6
	countToTenthOfASecond : PROCESS (Clk)
	BEGIN
		IF (rising_edge(Clk)) THEN
			IF counter = 5000000 THEN
				counter <= 0;
			ELSE
				counter <= counter + 1;
			END IF;
			
			IF key /= lastKey THEN
				counter <= 0;
			END IF;
		END IF;
	END PROCESS ;
	
	countTensOfASecond : PROCESS (Clk)
	BEGIN
		IF (rising_edge(Clk)) THEN
			IF counter = 5000000 THEN -- jeśli policzyłes 1/10 s
				IF tensOfASecond = 9 THEN
					tensOfASecond <= 0;
				ELSE
					tensOfASecond <= tensOfASecond + 1;
				END IF;
			END IF;
			
			IF key /= lastKey THEN
				tensOfASecondToDisplay <= std_logic_vector(to_unsigned(tensOfASecond, tensOfASecondToDisplay'length));
				tensOfASecond <= 0;
			END IF;
		END IF;
	END PROCESS;

	countSecondsS : PROCESS (Clk)
	BEGIN
		IF (rising_edge(Clk)) THEN
			IF tensOfASecond = 9 THEN
				IF seconds = 9 THEN
					seconds <= 0 ;
				ELSE
					seconds <= seconds + 1; 
				END IF;
				
				IF key /= lastKey THEN
					secondsToDisplay  <= std_logic_vector(to_unsigned(seconds, secondsToDisplay'length));
					seconds <= 0;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
END Behavioral;