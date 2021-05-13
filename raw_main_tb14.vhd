-- Vhdl test bench created from schematic /home/przem/Documents/Semestr6/UCiSW 2/Projekt/Organy/raw_main.sch - Thu May 13 11:12:00 2021
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
   PORT( DO_Rdy	:	IN	STD_LOGIC; 
          F0	:	IN	STD_LOGIC; 
          DO	:	IN	STD_LOGIC_VECTOR (7 DOWNTO 0); 
          Start	:	OUT	STD_LOGIC; 
          Command	:	OUT	STD_LOGIC_VECTOR (3 DOWNTO 0); 
          Address	:	OUT	STD_LOGIC_VECTOR (3 DOWNTO 0); 
          Data	:	OUT	STD_LOGIC_VECTOR (11 DOWNTO 0); 
          CLK	:	IN	STD_LOGIC; 
          VGA_HS	:	OUT	STD_LOGIC; 
          VGA_VS	:	OUT	STD_LOGIC; 
          VGA_RGB	:	OUT	STD_LOGIC; 
          Busy	:	OUT	STD_LOGIC);
   END COMPONENT;

   SIGNAL DO_Rdy	:	STD_LOGIC;
   SIGNAL F0	:	STD_LOGIC;
   SIGNAL DO	:	STD_LOGIC_VECTOR (7 DOWNTO 0);
   SIGNAL Start	:	STD_LOGIC;
   SIGNAL Command	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
   SIGNAL Address	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
   SIGNAL Data	:	STD_LOGIC_VECTOR (11 DOWNTO 0);
   SIGNAL CLK	:	STD_LOGIC;
   SIGNAL VGA_HS	:	STD_LOGIC;
   SIGNAL VGA_VS	:	STD_LOGIC;
   SIGNAL VGA_RGB	:	STD_LOGIC;
   SIGNAL Busy	:	STD_LOGIC;

	 -- Interface to VGAscaner
   component VGAscan
       Generic ( -- VGA mode params (defaults are for 800x600/72Hz)
                 pxWidth    : integer := 800;         -- visible pixels: width
                 pxHeight   : integer := 600;         -- visible pixels: height
                 pxHSfrontP : integer := 56;          -- HSync front porch
                 lnVSfrontP : integer := 37;          -- VSync front porch
                 pxTotal    : integer := 1040;        -- total horiz. pixels (visible & invisible)
                 lnTotal    : integer := 666;         -- total vert. lines (visible & invisible)
                 mhzPixelClk: real    := 50.000;      -- pixel clock
                 activeHS   : std_logic := '1';       -- HSync polarity
                 activeVS   : std_logic := '1';       -- VSync polarity
                 -- Aux params
                 pxBorder   : integer := 2;           -- bitmap border around the visible area
                 FileName   : string := "/home/przem/Pictures/test/frame"    -- output file name (frame number & ".bmp" will be appended)
               );
       Port ( VS, HS : in  STD_LOGIC;
              R, G, B : in  STD_LOGIC);
   end component;
	
	   -- Clock period definitions
   constant Clk_period : time := 20 ns;	-- 50 Mhz
	
	
BEGIN

   UUT: raw_main PORT MAP(
		DO_Rdy => DO_Rdy, 
		F0 => F0, 
		DO => DO, 
		Start => Start, 
		Command => Command, 
		Address => Address, 
		Data => Data, 
		CLK => CLK, 
		VGA_HS => VGA_HS, 
		VGA_VS => VGA_VS, 
		VGA_RGB => VGA_RGB, 
		Busy => Busy
   );
	
	 ------------------------------------------------------------------
   -- Instance of the VGA scanner
   ------------------------------------------------------------------
   I_VGAscaner: VGAscan
      generic map(
         pxBorder => 3,
         FIleName => "/home/przem/Pictures/test/frame" )    -- VGAtxt48x20 works in 800x600/72Hz mode => VGA generics can be left with defaults
      port map(
         VS => VGA_VS,
         HS => VGA_HS,
         R => VGA_RGB,
         G => VGA_RGB,
         B => VGA_RGB );



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
