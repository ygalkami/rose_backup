VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan3"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        BEGIN BLOCKDEF Reg_w3_iv0
            TIMESTAMP 2008 2 1 3 33 46
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
        BEGIN BLOCKDEF Op1_OD
            TIMESTAMP 2008 2 1 3 44 4
            BEGIN CIRCLE W 32 -64 160 64 
            END CIRCLE
            LINE N 0 0 32 0 
            RECTANGLE N 0 -8 32 8 
            LINE N 160 0 192 0 
            RECTANGLE N 160 -8 192 8 
        END BLOCKDEF
        BEGIN BLOCKDEF Op2_NSD
            TIMESTAMP 2008 2 1 3 42 25
            BEGIN CIRCLE W 32 -64 160 64 
            END CIRCLE
            LINE N 0 0 32 0 
            RECTANGLE N 0 -8 32 8 
            LINE N 96 -96 96 -64 
            RECTANGLE N 88 -96 104 -64 
            LINE N 160 0 192 0 
            RECTANGLE N 160 -8 192 8 
        END BLOCKDEF
        BEGIN BLOCK XLXI_1 Reg_w3_iv0
            PIN clk
            PIN res
            PIN i(2:0)
            PIN o(2:0)
            PIN ce
        END BLOCK
        BEGIN BLOCK XLXI_2 Op1_OD
            PIN a(2:0)
            PIN o(6:0)
        END BLOCK
        BEGIN BLOCK XLXI_3 Op2_NSD
            PIN a(2:0)
            PIN b(2:0)
            PIN o(6:0)
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_1 1504 1280 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_2 2064 1280 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_3 912 1280 R0
        END INSTANCE
    END SHEET
END SCHEMATIC
