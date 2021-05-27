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
		char_WE : OUT STD_LOGIC := '0');
END VGAController;

ARCHITECTURE Behavioral OF VGAController IS
	TYPE state_type IS (Silence, PrintKey, WaitForOther, Space, SecondsS, Dot, FractionsOfSecond, 
								Space2, SecondsSilence, SpaceSilence, DotSilence, FractionsOfSecondSilence,
								Space2Silence, DrawSilence, Space3);
	SIGNAL state : state_type := DrawSilence;
	SIGNAL next_state : state_type;
	SIGNAL lastKey : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL counter, tensOfASecond, seconds : integer := 0;
	SIGNAL tensOfASecondToDisplay, secondsToDisplay : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
	
	nextStateProcess : PROCESS (Clk)
	BEGIN
		IF rising_edge(Clk) THEN
				state <= next_state;
		END IF;
	END PROCESS;
	
	checkLastKeyProcess : PROCESS (Clk)
	BEGIN
		IF rising_edge(Clk) THEN
				lastKey <= key; -- oddzielny proces
		END IF;
	END PROCESS;

	logicProcess : PROCESS (state, key, lastKey)
		BEGIN
		next_state <= state; --default
		CASE state IS
			WHEN Silence 			  => next_state <= Silence; 
					IF key /= "1111"	THEN next_state <= SecondsSilence;			-- PrintKey;
					ELSE next_state <= Silence; 
					END IF;

			WHEN SecondsSilence  			=> next_state <= DotSilence;
			WHEN DotSilence	   			=> next_state <= FractionsOfSecondSilence;
			WHEN FractionsOfSecondSilence => next_state <= Space2Silence;
			WHEN Space2Silence				=> next_state <= PrintKey;
			WHEN PrintKey 		     			=> next_state <= WaitForOther;
			WHEN WaitForOther      			=>
				IF key /= lastKey THEN
					next_state <= Space;
				END IF;
			WHEN Space 			     			=> next_state <= SecondsS;
			WHEN SecondsS 			  			=> next_state <= Dot;
			WHEN Dot					  			=> next_state <= FractionsOfSecond;
			WHEN FractionsOfSecond 			=> next_state <= Space2;
			WHEN Space2 			  			=> next_state <= DrawSilence;
			WHEN DrawSilence		  			=> next_state <= Space3;
			WHEN Space3				  			=> next_state <= Silence;
			WHEN OTHERS 			  			=> next_state <= Silence;
		END CASE;
	END PROCESS;


					
	outputProcess : PROCESS (state, secondsToDisplay, tensOfASecondToDisplay, key)
	BEGIN
		CASE state IS
			WHEN Silence =>
				char_DI <= "00000000"; -- Avoiding latch
				char_WE <= '0';
			WHEN SecondsSilence =>
				char_DI <= std_logic_vector(X"3" & secondsToDisplay(3 DOWNTO 0));
				char_WE <= '1';
			WHEN DotSilence =>
				char_DI <= "00101110"; -- Dot	
				char_WE <= '1';
			WHEN FractionsOfSecondSilence =>
				char_DI <= std_logic_vector(X"3" & tensOfASecondToDisplay(3 DOWNTO 0));
				char_WE <= '1';
			WHEN Space2Silence => 
				char_DI <= "00100000"; -- Space
				char_WE <= '1';
			WHEN PrintKey =>		
																		-- znak na ekranie   Nuta
				IF 	key = "0000" THEN char_DI <= x"63"; -- c      			   - C
				ELSIF key = "0001" THEN char_DI <= X"43"; -- C 					   - C#
				ELSIF key = "0010" THEN char_DI <= X"64"; -- d 						- D
				ELSIF key = "0011" THEN char_DI <= X"44"; -- D 						- D#
				ELSIF key = "0100" THEN char_DI <= X"65"; -- e 						- E
				ELSIF key = "0101" THEN char_DI <= X"66"; -- f 						- F
				ELSIF key = "0110" THEN char_DI <= X"46"; -- F 						- F#
				ELSIF key = "0111" THEN char_DI <= X"67"; -- g 						- G
				ELSIF key = "1000" THEN char_DI <= X"47"; -- G 						- G#
				ELSIF key = "1001" THEN char_DI <= X"61"; -- a 						- A
				ELSIF key = "1010" THEN char_DI <= X"62"; -- b 						- B
				ELSIF key = "1011" THEN char_DI <= X"68"; -- h 						- H
				ELSIF key = "1111" THEN char_DI <= X"23"; -- # 						- CISZA
				ELSE  char_DI <= X"00";
				END IF;
				char_WE <= '1';
			WHEN WaitForOther => 
				char_DI <= "00000000"; -- Avoiding latch
				char_WE <= '0';
			WHEN Space             => 
				char_WE <= '1';
				char_DI <= "00100000"; -- Space
			WHEN SecondsS          => 
				char_DI <= std_logic_vector(X"3" & secondsToDisplay(3 DOWNTO 0));
				char_WE <= '1';
			WHEN Dot 	  			  => 
				char_DI <= "00101110"; -- Dot	
				char_WE <= '1';
			WHEN FractionsOfSecond => 
				char_DI <= std_logic_vector(X"3" & tensOfASecondToDisplay(3 DOWNTO 0));
				char_WE <= '1';
			WHEN Space2				  => 
				char_DI <= "00100000"; -- Space
				char_WE <= '1';
			WHEN Space3				  => 
				char_DI <= "00100000"; -- Space
				char_WE <= '1';
			WHEN DrawSilence		  =>
				char_DI <= X"23";
				char_WE <= '1';
			WHEN OTHERS => 
				char_DI <= "00000000"; -- Avoiding latch
				char_WE <= '0';
		END CASE;
	END PROCESS;

	--CLK freq = 50 Mhz T = 1/(50*10^6) s
	-- 1/10s = T * 5 * 10^6
	
	
	countToTenthOfAMiliSecond : PROCESS (Clk)
	BEGIN
		IF (rising_edge(Clk)) THEN
			IF counter = 5000 THEN -- 5000000 <- 0,1 s
				counter <= 0;
			ELSE
				counter <= counter + 1;
			END IF;
			
			IF key /= lastKey THEN
				counter <= 0;
			END IF;
		END IF;
	END PROCESS ;
	
	countTensOfAMiliSecond : PROCESS (Clk)
	BEGIN
		IF (rising_edge(Clk)) THEN
			IF counter = 5000 THEN -- jeśli policzyłes 1/10 s
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

	countMiliSecondsS : PROCESS (Clk)
	BEGIN
		IF (rising_edge(Clk)) THEN
			IF tensOfASecond = 9 THEN
				IF seconds = 9 THEN
					seconds <= 0 ;
				ELSE
					seconds <= seconds + 1; 
				END IF;
			END IF;
			IF key /= lastKey THEN
				secondsToDisplay  <= std_logic_vector(to_unsigned(seconds, secondsToDisplay'length));
				seconds <= 0;
			END IF;
		END IF;
	END PROCESS;
	
END Behavioral;