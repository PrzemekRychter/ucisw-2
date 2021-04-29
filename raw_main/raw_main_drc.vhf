--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : raw_main_drc.vhf
-- /___/   /\     Timestamp : 04/29/2021 10:29:29
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/unwrapped/sch2hdl -intstyle ise -family spartan3e -flat -suppress -vhdl raw_main_drc.vhf -w "/home/przem/Documents/Semestr6/UCiSW 2/Projekt/Organy/raw_main.sch"
--Design Name: raw_main
--Device: spartan3e
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity raw_main is
   port ( CLK     : in    std_logic; 
          DO      : in    std_logic_vector (7 downto 0); 
          DO_Rdy  : in    std_logic; 
          F0      : in    std_logic; 
          Address : out   std_logic_vector (3 downto 0); 
          Command : out   std_logic_vector (3 downto 0); 
          Data    : out   std_logic_vector (11 downto 0); 
          Start   : out   std_logic);
end raw_main;

architecture BEHAVIORAL of raw_main is
   attribute BOX_TYPE   : string ;
   signal XLXN_1  : std_logic_vector (3 downto 0);
   signal XLXN_6  : std_logic;
   component dac_signal_generator
      port ( Rdy     : in    std_logic; 
             Clk     : in    std_logic; 
             Key     : in    std_logic_vector (3 downto 0); 
             Start   : out   std_logic; 
             Command : out   std_logic_vector (3 downto 0); 
             Address : out   std_logic_vector (3 downto 0); 
             Data    : out   std_logic_vector (11 downto 0));
   end component;
   
   component keyboard_to_key
      port ( DO_Rdy : in    std_logic; 
             F0     : in    std_logic; 
             DO     : in    std_logic_vector (7 downto 0); 
             key    : out   std_logic_vector (3 downto 0); 
             CLK    : in    std_logic);
   end component;
   
   component VCC
      port ( P : out   std_logic);
   end component;
   attribute BOX_TYPE of VCC : component is "BLACK_BOX";
   
begin
   XLXI_1 : dac_signal_generator
      port map (Clk=>CLK,
                Key(3 downto 0)=>XLXN_1(3 downto 0),
                Rdy=>XLXN_6,
                Address(3 downto 0)=>Address(3 downto 0),
                Command(3 downto 0)=>Command(3 downto 0),
                Data(11 downto 0)=>Data(11 downto 0),
                Start=>Start);
   
   XLXI_2 : keyboard_to_key
      port map (CLK=>CLK,
                DO(7 downto 0)=>DO(7 downto 0),
                DO_Rdy=>DO_Rdy,
                F0=>F0,
                key(3 downto 0)=>XLXN_1(3 downto 0));
   
   XLXI_4 : VCC
      port map (P=>XLXN_6);
   
end BEHAVIORAL;


