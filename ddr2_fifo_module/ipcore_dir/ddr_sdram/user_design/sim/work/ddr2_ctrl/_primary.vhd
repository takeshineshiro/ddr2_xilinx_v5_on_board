library verilog;
use verilog.vl_types.all;
entity ddr2_ctrl is
    generic(
        BANK_WIDTH      : integer := 2;
        COL_WIDTH       : integer := 10;
        CS_BITS         : integer := 0;
        CS_NUM          : integer := 1;
        ROW_WIDTH       : integer := 14;
        ADDITIVE_LAT    : integer := 0;
        BURST_LEN       : integer := 4;
        CAS_LAT         : integer := 5;
        ECC_ENABLE      : integer := 0;
        REG_ENABLE      : integer := 1;
        TREFI_NS        : integer := 7800;
        TRAS            : integer := 40000;
        TRCD            : integer := 15000;
        TRRD            : integer := 10000;
        TRFC            : integer := 105000;
        TRP             : integer := 15000;
        TRTP            : integer := 7500;
        TWR             : integer := 15000;
        TWTR            : integer := 10000;
        CLK_PERIOD      : integer := 3000;
        MULTI_BANK_EN   : integer := 1;
        TWO_T_TIME_EN   : integer := 0;
        DDR_TYPE        : integer := 1
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        af_cmd          : in     vl_logic_vector(2 downto 0);
        af_addr         : in     vl_logic_vector(30 downto 0);
        af_empty        : in     vl_logic;
        phy_init_done   : in     vl_logic;
        ctrl_ref_flag   : out    vl_logic;
        ctrl_af_rden    : out    vl_logic;
        ctrl_wren       : out    vl_logic;
        ctrl_rden       : out    vl_logic;
        ctrl_addr       : out    vl_logic_vector;
        ctrl_ba         : out    vl_logic_vector;
        ctrl_ras_n      : out    vl_logic;
        ctrl_cas_n      : out    vl_logic;
        ctrl_we_n       : out    vl_logic;
        ctrl_cs_n       : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BANK_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of COL_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of CS_BITS : constant is 1;
    attribute mti_svvh_generic_type of CS_NUM : constant is 1;
    attribute mti_svvh_generic_type of ROW_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ADDITIVE_LAT : constant is 1;
    attribute mti_svvh_generic_type of BURST_LEN : constant is 1;
    attribute mti_svvh_generic_type of CAS_LAT : constant is 1;
    attribute mti_svvh_generic_type of ECC_ENABLE : constant is 1;
    attribute mti_svvh_generic_type of REG_ENABLE : constant is 1;
    attribute mti_svvh_generic_type of TREFI_NS : constant is 1;
    attribute mti_svvh_generic_type of TRAS : constant is 1;
    attribute mti_svvh_generic_type of TRCD : constant is 1;
    attribute mti_svvh_generic_type of TRRD : constant is 1;
    attribute mti_svvh_generic_type of TRFC : constant is 1;
    attribute mti_svvh_generic_type of TRP : constant is 1;
    attribute mti_svvh_generic_type of TRTP : constant is 1;
    attribute mti_svvh_generic_type of TWR : constant is 1;
    attribute mti_svvh_generic_type of TWTR : constant is 1;
    attribute mti_svvh_generic_type of CLK_PERIOD : constant is 1;
    attribute mti_svvh_generic_type of MULTI_BANK_EN : constant is 1;
    attribute mti_svvh_generic_type of TWO_T_TIME_EN : constant is 1;
    attribute mti_svvh_generic_type of DDR_TYPE : constant is 1;
end ddr2_ctrl;
