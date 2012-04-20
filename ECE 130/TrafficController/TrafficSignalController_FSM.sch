VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan3"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL gReset
        SIGNAL iStartSystem
        SIGNAL iTimerDone
        SIGNAL oUS40Red
        SIGNAL oUS40Yellow
        SIGNAL oUS40Green
        SIGNAL oRHRed
        SIGNAL oRHYellow
        SIGNAL oRHGreen
        SIGNAL oStartTimer
        SIGNAL oState(3:0)
        SIGNAL iClockEnable
        SIGNAL XLXN_1(3:0)
        SIGNAL XLXN_2
        SIGNAL XLXN_3
        SIGNAL XLXN_4(3:0)
        SIGNAL XLXN_8(3:0)
        SIGNAL iAutoSensed
        SIGNAL i(2:0)
        SIGNAL i(2)
        SIGNAL i(1)
        SIGNAL i(0)
        SIGNAL XLXN_15
        SIGNAL XLXN_17
        SIGNAL XLXN_18
        SIGNAL XLXN_19
        SIGNAL XLXN_20
        SIGNAL XLXN_21
        SIGNAL o(6)
        SIGNAL o(5)
        SIGNAL o(4)
        SIGNAL o(3)
        SIGNAL o(2)
        SIGNAL o(1)
        SIGNAL o(0)
        SIGNAL gClock
        SIGNAL o(6:0)
        PORT Input gReset
        PORT Input iStartSystem
        PORT Input iTimerDone
        PORT Output oUS40Red
        PORT Output oUS40Yellow
        PORT Output oUS40Green
        PORT Output oRHRed
        PORT Output oRHYellow
        PORT Output oRHGreen
        PORT Output oStartTimer
        PORT Output oState(3:0)
        PORT Input iClockEnable
        PORT Input iAutoSensed
        PORT Input gClock
        BEGIN BLOCKDEF Op2_NSD
            TIMESTAMP 2008 2 1 4 18 0
            BEGIN CIRCLE W 32 -64 160 64 
            END CIRCLE
            LINE N 0 0 32 0 
            RECTANGLE N 0 -8 32 8 
            LINE N 96 -96 96 -64 
            RECTANGLE N 88 -96 104 -64 
            LINE N 160 0 192 0 
            RECTANGLE N 160 -8 192 8 
        END BLOCKDEF
        BEGIN BLOCKDEF Reg_w4_iv0
            TIMESTAMP 2008 2 1 4 17 18
            BEGIN RECTANGLE W 32 -80 304 80 
            END RECTANGLE
            BEGIN RECTANGLE N 32 80 160 112 
                LINESTYLE Dot
            END RECTANGLE
            BEGIN LINE N 96 112 96 80 
                LINESTYLE Dot
            END LINE
            LINE N 0 0 32 0 
            RECTANGLE N 0 -8 32 8 
            LINE N 304 0 336 0 
            RECTANGLE N 304 -8 336 8 
            LINE N 0 -64 32 -64 
        END BLOCKDEF
        BEGIN BLOCKDEF Op3_OD
            TIMESTAMP 2008 2 1 4 18 47
            BEGIN CIRCLE W 32 -64 160 64 
            END CIRCLE
            LINE N 0 0 32 0 
            RECTANGLE N 0 -8 32 8 
            LINE N 96 -96 96 -64 
            RECTANGLE N 88 -96 104 -64 
            LINE N 96 96 96 64 
            RECTANGLE N 88 64 104 96 
            LINE N 160 0 192 0 
            RECTANGLE N 160 -8 192 8 
        END BLOCKDEF
        BEGIN BLOCKDEF Op1_a
            TIMESTAMP 2008 2 1 4 23 49
            BEGIN CIRCLE W 32 -64 160 64 
            END CIRCLE
            LINE N 0 0 32 0 
            LINE N 160 0 192 0 
        END BLOCKDEF
        BEGIN BLOCK XLXI_5 Reg_w4_iv0
            PIN clk gClock
            PIN res gReset
            PIN i(3:0) XLXN_1(3:0)
            PIN o(3:0) oState(3:0)
            PIN ce iClockEnable
        END BLOCK
        BEGIN BLOCK XLXI_6 Op2_NSD
            PIN a(2:0) i(2:0)
            PIN b(3:0) oState(3:0)
            PIN o(3:0) XLXN_1(3:0)
        END BLOCK
        BEGIN BLOCK XLXI_7 Op3_OD
            PIN a(3:0) oState(3:0)
            PIN b(3:0)
            PIN c(3:0)
            PIN o(6:0) o(6:0)
        END BLOCK
        BEGIN BLOCK XLXI_8 Op1_a
            PIN a iAutoSensed
            PIN o i(2)
        END BLOCK
        BEGIN BLOCK XLXI_10 Op1_a
            PIN a iTimerDone
            PIN o i(0)
        END BLOCK
        BEGIN BLOCK XLXI_9 Op1_a
            PIN a iStartSystem
            PIN o i(1)
        END BLOCK
        BEGIN BLOCK XLXI_14 Op1_a
            PIN a o(6)
            PIN o oUS40Red
        END BLOCK
        BEGIN BLOCK XLXI_15 Op1_a
            PIN a o(5)
            PIN o oUS40Yellow
        END BLOCK
        BEGIN BLOCK XLXI_16 Op1_a
            PIN a o(4)
            PIN o oUS40Green
        END BLOCK
        BEGIN BLOCK XLXI_17 Op1_a
            PIN a o(3)
            PIN o oRHRed
        END BLOCK
        BEGIN BLOCK XLXI_18 Op1_a
            PIN a o(2)
            PIN o oRHYellow
        END BLOCK
        BEGIN BLOCK XLXI_19 Op1_a
            PIN a o(1)
            PIN o oRHGreen
        END BLOCK
        BEGIN BLOCK XLXI_20 Op1_a
            PIN a o(0)
            PIN o oStartTimer
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        ATTR LengthUnitName "Inch"
        ATTR GridsPerUnit "10"
        IOMARKER 320 2080 gClock R180 28
        IOMARKER 320 2160 gReset R180 28
        BEGIN BRANCH iStartSystem
            WIRE 320 960 336 960
            WIRE 336 960 336 976
            WIRE 336 976 512 976
        END BRANCH
        BEGIN BRANCH iTimerDone
            WIRE 320 1120 336 1120
            WIRE 336 1120 336 1152
            WIRE 336 1152 512 1152
        END BRANCH
        IOMARKER 320 800 iAutoSensed R180 28
        IOMARKER 320 960 iStartSystem R180 28
        IOMARKER 320 1120 iTimerDone R180 28
        BEGIN BRANCH oUS40Red
            WIRE 2880 800 3040 800
            WIRE 3040 800 3216 800
        END BRANCH
        BEGIN BRANCH oUS40Yellow
            WIRE 2880 960 3040 960
            WIRE 3040 960 3216 960
        END BRANCH
        BEGIN BRANCH oUS40Green
            WIRE 2880 1120 3040 1120
            WIRE 3040 1120 3200 1120
        END BRANCH
        BEGIN BRANCH oRHRed
            WIRE 2880 1280 3040 1280
            WIRE 3040 1280 3200 1280
        END BRANCH
        BEGIN BRANCH oRHYellow
            WIRE 2880 1440 3040 1440
            WIRE 3040 1440 3200 1440
        END BRANCH
        BEGIN BRANCH oRHGreen
            WIRE 2880 1600 3040 1600
            WIRE 3040 1600 3200 1600
        END BRANCH
        BEGIN BRANCH oStartTimer
            WIRE 2880 1760 3040 1760
            WIRE 3040 1760 3200 1760
        END BRANCH
        IOMARKER 3216 800 oUS40Red R0 28
        IOMARKER 3216 960 oUS40Yellow R0 28
        IOMARKER 3200 1120 oUS40Green R0 28
        IOMARKER 3200 1280 oRHRed R0 28
        IOMARKER 3200 1440 oRHYellow R0 28
        IOMARKER 3200 1600 oRHGreen R0 28
        IOMARKER 3200 1760 oStartTimer R0 28
        IOMARKER 320 1920 iClockEnable R180 28
        IOMARKER 3216 2080 oState(3:0) R0 28
        BEGIN BRANCH oState(3:0)
            WIRE 1168 816 1168 896
            WIRE 1168 816 2128 816
            WIRE 2128 816 2128 1296
            WIRE 2128 1296 2192 1296
            WIRE 2032 1296 2080 1296
            WIRE 2080 1296 2128 1296
            WIRE 2080 1296 2080 2080
            WIRE 2080 2080 3024 2080
            WIRE 3024 2080 3216 2080
        END BRANCH
        BEGIN BRANCH iClockEnable
            WIRE 320 1920 1328 1920
            WIRE 1328 1232 1328 1920
            WIRE 1328 1232 1696 1232
        END BRANCH
        BEGIN BRANCH gReset
            WIRE 320 2160 1824 2160
            WIRE 1824 1408 1824 2160
        END BRANCH
        BEGIN INSTANCE XLXI_5 1696 1296 R0
        END INSTANCE
        BEGIN BRANCH XLXN_1(3:0)
            WIRE 1264 992 1680 992
            WIRE 1680 992 1680 1296
            WIRE 1680 1296 1696 1296
        END BRANCH
        BEGIN INSTANCE XLXI_6 1072 992 R0
        END INSTANCE
        BEGIN BRANCH iAutoSensed
            WIRE 320 800 336 800
            WIRE 336 784 512 784
            WIRE 336 784 336 800
        END BRANCH
        BEGIN BRANCH i(2:0)
            WIRE 976 672 976 784
            WIRE 976 784 976 992
            WIRE 976 992 976 1184
            WIRE 976 1184 976 1232
            WIRE 976 992 1024 992
            WIRE 1024 992 1072 992
            BEGIN DISPLAY 1024 992 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 976 1184 880 1184
        BUSTAP 976 992 880 992
        BUSTAP 976 784 880 784
        BEGIN BRANCH i(1)
            WIRE 704 976 832 976
            WIRE 832 976 832 992
            WIRE 832 992 880 992
            BEGIN DISPLAY 832 992 ATTR Name
                ALIGNMENT SOFT-TCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH i(0)
            WIRE 704 1152 832 1152
            WIRE 832 1152 832 1184
            WIRE 832 1184 880 1184
            BEGIN DISPLAY 832 1184 ATTR Name
                ALIGNMENT SOFT-TCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH i(2)
            WIRE 704 784 832 784
            WIRE 832 784 880 784
            BEGIN DISPLAY 832 784 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_8 512 784 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_10 512 1152 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_9 512 976 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_14 2688 800 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_15 2688 960 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_16 2688 1120 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_17 2688 1280 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_18 2688 1440 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_19 2688 1600 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_20 2688 1760 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_7 2192 1296 R0
        END INSTANCE
        BEGIN BRANCH o(6:0)
            WIRE 2384 1296 2416 1296
            WIRE 2416 1296 2496 1296
            WIRE 2496 1296 2496 1440
            WIRE 2496 1440 2496 1600
            WIRE 2496 1600 2496 1760
            WIRE 2496 1760 2496 1776
            WIRE 2496 800 2496 816
            WIRE 2496 816 2496 960
            WIRE 2496 960 2496 1120
            WIRE 2496 1120 2496 1280
            WIRE 2496 1280 2496 1296
            BEGIN DISPLAY 2416 1296 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 2496 1760 2592 1760
        BUSTAP 2496 1600 2592 1600
        BUSTAP 2496 1440 2592 1440
        BUSTAP 2496 1280 2592 1280
        BUSTAP 2496 1120 2592 1120
        BUSTAP 2496 960 2592 960
        BUSTAP 2496 816 2592 816
        BEGIN BRANCH o(6)
            WIRE 2592 816 2608 816
            WIRE 2608 816 2640 816
            WIRE 2640 800 2640 816
            WIRE 2640 800 2688 800
            BEGIN DISPLAY 2608 816 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH o(5)
            WIRE 2592 960 2608 960
            WIRE 2608 960 2688 960
            BEGIN DISPLAY 2608 960 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH o(4)
            WIRE 2592 1120 2608 1120
            WIRE 2608 1120 2688 1120
            BEGIN DISPLAY 2608 1120 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH o(3)
            WIRE 2592 1280 2608 1280
            WIRE 2608 1280 2688 1280
            BEGIN DISPLAY 2608 1280 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH o(2)
            WIRE 2592 1440 2608 1440
            WIRE 2608 1440 2624 1440
            WIRE 2624 1440 2688 1440
            BEGIN DISPLAY 2624 1440 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH o(1)
            WIRE 2592 1600 2608 1600
            WIRE 2608 1600 2688 1600
            BEGIN DISPLAY 2608 1600 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH o(0)
            WIRE 2592 1760 2624 1760
            WIRE 2624 1760 2688 1760
            BEGIN DISPLAY 2624 1760 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH gClock
            WIRE 320 2080 1760 2080
            WIRE 1760 1408 1760 2080
        END BRANCH
    END SHEET
END SCHEMATIC
