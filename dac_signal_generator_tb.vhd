--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:08:48 04/29/2021
-- Design Name:   
-- Module Name:   /home/przem/Documents/Semestr6/UCiSW 2/Projekt/Organy/dac_signal_generator_tb.vhd
-- Project Name:  Organy
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: dac_signal_generator
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY dac_signal_generator_tb IS
END dac_signal_generator_tb;
 
ARCHITECTURE behavior OF dac_signal_generator_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT dac_signal_generator
    PORT(
         Rdy : IN  std_logic;
         Clk : IN  std_logic;
			Key : in STD_LOGIC_VECTOR (3 downto 0);
         Command : OUT  std_logic_vector(3 downto 0);
         Address : OUT  std_logic_vector(3 downto 0);
         Data : OUT  std_logic_vector(11 downto 0);
         Start : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Rdy : std_logic := '0';
   signal Clk : std_logic := '0';
	signal Key : STD_LOGIC_VECTOR (3 downto 0) := "0000";
 	--Outputs
   signal Command : std_logic_vector(3 downto 0);
   signal Address : std_logic_vector(3 downto 0);
   signal Data : std_logic_vector(11 downto 0);
   signal Start : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: dac_signal_generator PORT MAP (
          Rdy => Rdy,
          Clk => Clk,
			 Key => Key,
          Command => Command,
          Address => Address,
          Data => Data,
          Start => Start
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      Key <= "0000", "1100" after 3 ms, "0011" after 6 ms;
		wait for 100 ns;	
      Rdy <= '1';
		
		
      wait;
   end process;

END;