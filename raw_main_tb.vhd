-- Vhdl test bench created from schematic /home/przem/Documents/Semestr6/UCiSW 2/Projekt/Organy/raw_main.sch - Thu Apr 29 10:29:58 2021
--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Xilinx recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "Source->Add"
-- menu in Project Navigator to import the testbench. Then
-- edit the user defined section below, adding code to generate the 
-- stimulus for your design.
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
ENTITY raw_main_raw_main_sch_tb IS
END raw_main_raw_main_sch_tb;
ARCHITECTURE behavioral OF raw_main_raw_main_sch_tb IS 

   COMPONENT raw_main
   PORT( CLK	:	IN	STD_LOGIC; 
          DO_Rdy	:	IN	STD_LOGIC; 
          F0	:	IN	STD_LOGIC; 
          DO	:	IN	STD_LOGIC_VECTOR (7 DOWNTO 0); 
          Start	:	OUT	STD_LOGIC; 
          Command	:	OUT	STD_LOGIC_VECTOR (3 DOWNTO 0); 
          Address	:	OUT	STD_LOGIC_VECTOR (3 DOWNTO 0); 
          Data	:	OUT	STD_LOGIC_VECTOR (11 DOWNTO 0));
   END COMPONENT;

   SIGNAL CLK	:	STD_LOGIC;
   SIGNAL DO_Rdy	:	STD_LOGIC;
   SIGNAL F0	:	STD_LOGIC;
   SIGNAL DO	:	STD_LOGIC_VECTOR (7 DOWNTO 0);
   SIGNAL Start	:	STD_LOGIC;
   SIGNAL Command	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
   SIGNAL Address	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
   SIGNAL Data	:	STD_LOGIC_VECTOR (11 DOWNTO 0);

   -- Clock period definitions
   constant Clk_period : time := 20 ns;	-- 50 Mhz
	
BEGIN

   UUT: raw_main PORT MAP(
		CLK => CLK, 
		DO_Rdy => DO_Rdy, 
		F0 => F0, 
		DO => DO, 
		Start => Start, 
		Command => Command, 
		Address => Address, 
		Data => Data
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
   tb: process
		type typeByteArray is array ( NATURAL range <> ) of STD_LOGIC_VECTOR( 7 downto 0 );
		variable arrBytes : typeByteArray( 0 to 12 ):= ( X"1C", X"1B", X"23", X"2B", X"34", X"33", X"3B", X"1D", X"24", X"2C", X"34", X"3C", X"3A");
	begin		
		for i in arrBytes'RANGE loop
			DO <= arrBytes(i);
			DO_Rdy <= '1';
			F0 <= '0';
			wait for Clk_period;
			DO_Rdy <= '0';
			wait for 2 ms - Clk_period;
			DO_Rdy <= '1';
			F0 <= '1';
			wait for Clk_period;
			DO_Rdy <= '0';
			wait for 1 ms - Clk_period;
		end loop;
	wait;
   end process;

END;
