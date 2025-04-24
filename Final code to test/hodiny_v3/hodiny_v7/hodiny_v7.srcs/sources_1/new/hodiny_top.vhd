library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hodiny_top is
    Port (
        clk_1Hz    : in  STD_LOGIC;
        clk_20Hz   : in  STD_LOGIC;
        clk_1000Hz : in  STD_LOGIC;
        res        : in  STD_LOGIC;
        BTN_U      : in  std_logic;
        BTN_D      : in  std_logic;    
        BTN_R      : in  std_logic;
        SW_set     : in  std_logic;   
        VEC_out    : out  std_logic_vector(2 downto 0);
        SEC_out    : out std_logic_vector(5 downto 0);
        MIN_out    : out std_logic_vector(5 downto 0);
        HOUR_out   : out std_logic_vector(4 downto 0)
    );
end hodiny_top;

architecture Behavioral of hodiny_top is

    component KO is
    Port (
        clk1Hz     : in  std_logic;
        clk20Hz   : in  std_logic;
        SW         : in  std_logic;
        BTN_U      : in  std_logic;
        BTN_D      : in  std_logic;
        BTN_R      : in  std_logic;
        add_clk    : out std_logic;
        add_BTN_U  : out std_logic;
        add_BTN_D  : out std_logic;
        add_set    : out std_logic_vector(1 downto 0)
    );
end component;
   component SecondsCounter is
    Port (
        clk_1000Hz : in  std_logic;
        add_clk    : in  std_logic;
        add_BTN_U  : in  std_logic;
        add_BTN_D  : in  std_logic;
        VEC_set    : in  std_logic_vector(1 downto 0);
        res        : in  std_logic;
        SEC_out    : out std_logic_vector(5 downto 0);
        carry      : out std_logic
    );
    end component;

    component MinutesCounter is
    Port (
        clk_1000Hz : in  std_logic;
        add_clk    : in  std_logic;
        add_BTN_U  : in  std_logic;
        add_BTN_D  : in  std_logic;
        VEC_set    : in  std_logic_vector(1 downto 0);
        res        : in  std_logic;
        SEC_out    : out std_logic_vector(5 downto 0);
        carry      : out std_logic
    );
    end component;

    component HoursCounter is
    Port (
        clk_1000Hz : in  std_logic;
        add_clk    : in  std_logic;
        add_BTN_U  : in  std_logic;
        add_BTN_D  : in  std_logic;
        VEC_set    : in  std_logic_vector(1 downto 0);
        res        : in  std_logic;
        SEC_out    : out STD_LOGIC_VECTOR(4 downto 0);
        carry      : out std_logic
    );
    end component;
    signal sig_clk_1Hz      : STD_LOGIC;
    signal sig_add_clk : STD_LOGIC;
    signal sig_carry_sec : STD_LOGIC;
    signal sig_carry_min : STD_LOGIC;
    
    -- Control signals
    signal sig_VEC_set : STD_LOGIC_VECTOR(1 downto 0);
    signal sig_add_BTN_U : STD_LOGIC;
    signal sig_add_BTN_D : STD_LOGIC;
begin

process(sig_VEC_set)
begin
    case sig_VEC_set is
        when "01" => VEC_out <= "001";
        when "10" => VEC_out <= "010";
        when "11" => VEC_out <= "100";
        when others => VEC_out <= "000";
    end case;
end process;


KO_inst: KO
port map(
    clk1Hz => clk_1Hz,
    clk20Hz => clk_20Hz,
    add_set => sig_VEC_set,
    BTN_U => BTN_U,
    BTN_D => BTN_D,
    BTN_R => BTN_R,
    add_clk => sig_add_clk,
    add_BTN_U => sig_add_BTN_U,
    SW => SW_set,
    add_BTN_D => sig_add_BTN_D
);

second_counter_inst: SecondsCounter
port map(
    clk_1000Hz => clk_1000Hz,
    add_clk => sig_add_clk,
    res => res,
    add_BTN_U => sig_add_BTN_U,
    add_BTN_D => sig_add_BTN_D,
    VEC_set => sig_VEC_set,
    carry => sig_carry_sec,
    SEC_out => SEC_out
);

minutes_counter_inst: MinutesCounter
port map(
    clk_1000Hz => clk_1000Hz,
    add_clk => sig_carry_sec,
    res => res,
    add_BTN_U => sig_add_BTN_U,
    add_BTN_D => sig_add_BTN_D,
    VEC_set => sig_VEC_set,
    carry => sig_carry_min,
    SEC_out => MIN_out
);

hours_counter_inst: HoursCounter
port map(
    clk_1000Hz => clk_1000Hz,
    add_clk => sig_carry_min,
    res => res,
    add_BTN_U => sig_add_BTN_U,
    add_BTN_D => sig_add_BTN_D,
    VEC_set => sig_VEC_set,
    SEC_out => HOUR_out
);
end Behavioral;