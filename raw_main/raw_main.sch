<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_1(3:0)" />
        <signal name="CLK" />
        <signal name="XLXN_3(3:0)" />
        <signal name="XLXN_4(3:0)" />
        <signal name="XLXN_5(3:0)" />
        <signal name="XLXN_6" />
        <signal name="DO_Rdy" />
        <signal name="F0" />
        <signal name="DO(7:0)" />
        <signal name="Start" />
        <signal name="Command(3:0)" />
        <signal name="Address(3:0)" />
        <signal name="Data(11:0)" />
        <port polarity="Input" name="CLK" />
        <port polarity="Input" name="DO_Rdy" />
        <port polarity="Input" name="F0" />
        <port polarity="Input" name="DO(7:0)" />
        <port polarity="Output" name="Start" />
        <port polarity="Output" name="Command(3:0)" />
        <port polarity="Output" name="Address(3:0)" />
        <port polarity="Output" name="Data(11:0)" />
        <blockdef name="dac_signal_generator">
            <timestamp>2021-4-29T7:11:7</timestamp>
            <rect width="256" x="64" y="-256" height="256" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <rect width="64" x="320" y="-108" height="24" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="keyboard_to_key">
            <timestamp>2021-4-29T8:12:39</timestamp>
            <line x2="0" y1="32" y2="32" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <rect width="256" x="64" y="-192" height="256" />
        </blockdef>
        <blockdef name="vcc">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-64" x1="64" />
            <line x2="64" y1="0" y2="-32" x1="64" />
            <line x2="32" y1="-64" y2="-64" x1="96" />
        </blockdef>
        <block symbolname="dac_signal_generator" name="XLXI_1">
            <blockpin signalname="XLXN_6" name="Rdy" />
            <blockpin signalname="CLK" name="Clk" />
            <blockpin signalname="XLXN_1(3:0)" name="Key(3:0)" />
            <blockpin signalname="Start" name="Start" />
            <blockpin signalname="Command(3:0)" name="Command(3:0)" />
            <blockpin signalname="Address(3:0)" name="Address(3:0)" />
            <blockpin signalname="Data(11:0)" name="Data(11:0)" />
        </block>
        <block symbolname="keyboard_to_key" name="XLXI_2">
            <blockpin signalname="DO_Rdy" name="DO_Rdy" />
            <blockpin signalname="F0" name="F0" />
            <blockpin signalname="DO(7:0)" name="DO(7:0)" />
            <blockpin signalname="XLXN_1(3:0)" name="key(3:0)" />
            <blockpin signalname="CLK" name="CLK" />
        </block>
        <block symbolname="vcc" name="XLXI_4">
            <blockpin signalname="XLXN_6" name="P" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="752" y="1632" name="XLXI_2" orien="R0">
        </instance>
        <branch name="XLXN_1(3:0)">
            <wire x2="1488" y1="1472" y2="1472" x1="1136" />
        </branch>
        <branch name="CLK">
            <wire x2="736" y1="1808" y2="1808" x1="720" />
            <wire x2="1168" y1="1808" y2="1808" x1="736" />
            <wire x2="752" y1="1664" y2="1664" x1="736" />
            <wire x2="736" y1="1664" y2="1808" x1="736" />
            <wire x2="1168" y1="1376" y2="1808" x1="1168" />
            <wire x2="1488" y1="1376" y2="1376" x1="1168" />
        </branch>
        <iomarker fontsize="28" x="720" y="1808" name="CLK" orien="R180" />
        <instance x="1488" y="1504" name="XLXI_1" orien="R0">
        </instance>
        <instance x="1296" y="1200" name="XLXI_4" orien="R0" />
        <branch name="XLXN_6">
            <wire x2="1360" y1="1200" y2="1280" x1="1360" />
            <wire x2="1488" y1="1280" y2="1280" x1="1360" />
        </branch>
        <branch name="DO_Rdy">
            <wire x2="752" y1="1472" y2="1472" x1="720" />
        </branch>
        <iomarker fontsize="28" x="720" y="1472" name="DO_Rdy" orien="R180" />
        <branch name="F0">
            <wire x2="752" y1="1536" y2="1536" x1="720" />
        </branch>
        <iomarker fontsize="28" x="720" y="1536" name="F0" orien="R180" />
        <branch name="DO(7:0)">
            <wire x2="752" y1="1600" y2="1600" x1="720" />
        </branch>
        <iomarker fontsize="28" x="720" y="1600" name="DO(7:0)" orien="R180" />
        <branch name="Start">
            <wire x2="1904" y1="1280" y2="1280" x1="1872" />
        </branch>
        <iomarker fontsize="28" x="1904" y="1280" name="Start" orien="R0" />
        <branch name="Command(3:0)">
            <wire x2="1904" y1="1344" y2="1344" x1="1872" />
        </branch>
        <iomarker fontsize="28" x="1904" y="1344" name="Command(3:0)" orien="R0" />
        <branch name="Address(3:0)">
            <wire x2="1904" y1="1408" y2="1408" x1="1872" />
        </branch>
        <iomarker fontsize="28" x="1904" y="1408" name="Address(3:0)" orien="R0" />
        <branch name="Data(11:0)">
            <wire x2="1904" y1="1472" y2="1472" x1="1872" />
        </branch>
        <iomarker fontsize="28" x="1904" y="1472" name="Data(11:0)" orien="R0" />
    </sheet>
</drawing>