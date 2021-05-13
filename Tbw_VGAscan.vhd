LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY Tbw_VGAscan IS
END Tbw_VGAscan;
ARCHITECTURE behavioral OF Tbw_VGAscan IS 

   COMPONENT Top_HelloOnVGA
   PORT( Clk_50MHz	:	IN	STD_LOGIC; 
          Reset	:	IN	STD_LOGIC; 
          NewLine	:	IN	STD_LOGIC; 
          VGA_HS	:	OUT	STD_LOGIC; 
          VGA_VS	:	OUT	STD_LOGIC; 
          VGA_RGB	:	OUT	STD_LOGIC);
   END COMPONENT;

   SIGNAL Clk_50MHz	:	STD_LOGIC := '0';
   SIGNAL Reset	:	STD_LOGIC := '0';
   SIGNAL NewLine	:	STD_LOGIC := '0';
   SIGNAL VGA_HS	:	STD_LOGIC;
   SIGNAL VGA_VS	:	STD_LOGIC;
   SIGNAL VGA_RGB	:	STD_LOGIC;
   
   CONSTANT Clk_Period : DELAY_LENGTH := 20 ns;
   
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

BEGIN
   
   ------------------------------------------------------------------
   -- Unit Under Test (the schematic)
   ------------------------------------------------------------------
   UUT: Top_HelloOnVGA PORT MAP(
		Clk_50MHz => Clk_50MHz, 
		Reset => Reset, 
		NewLine => NewLine, 
		VGA_HS => VGA_HS, 
		VGA_VS => VGA_VS, 
		VGA_RGB => VGA_RGB
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

   -- Clock wave
   Clk_50MHz <= not Clk_50MHz after Clk_Period / 2;

   -- Inputs
   process
   begin
      -- Simulated behavior: print a new line every VGA frame
      loop
         wait until rising_edge(VGA_VS);
         Reset   <= '1', '0' after Clk_Period;  -- re-send the string
         NewLine <= '1', '0' after Clk_Period;  -- go to new line pulse
      end loop;
   end process;
   
END;
