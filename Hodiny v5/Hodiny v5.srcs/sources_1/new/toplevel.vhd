library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_level is
    Port (
        clk_100MHz   : in  STD_LOGIC;
        res          : in  STD_LOGIC;
        SW_set         : in  std_logic;
        SW_alarm       : in  std_logic;
        SW_alarm_on       : in  std_logic;
        SW_stopwatch   : in  std_logic;
        BTN_U      : in  std_logic;
        BTN_D      : in  std_logic;
        BTN_R      : in  std_logic;
        seg        : out STD_LOGIC_VECTOR(6 downto 0);
        an         : out STD_LOGIC_VECTOR(7 downto 0);
        piezo      : out  std_logic
    );
end top_level;

architecture Behavioral of top_level is
    component delicka_1Hz is
        Port ( clk_100MHz : in  STD_LOGIC;
               reset      : in  STD_LOGIC;
               clk_1Hz    : out STD_LOGIC);
    end component;

    component delicka_1000Hz is
    Port (
        clk_100MHz : in  STD_LOGIC;
        reset      : in  STD_LOGIC;
        clk_1000Hz    : out STD_LOGIC
    );
    end component;
    
    component delicka_20Hz is
        Port (
        clk_100MHz : in  STD_LOGIC;
        reset      : in  STD_LOGIC;
        clk_20Hz    : out STD_LOGIC
    );
    end component;
    
    component hodiny_top is
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
end component;
    component stopwatch_controller is
    port (
        clk_1Hz   : in  std_logic; -- Vstupní hodinový signál 1 Hz
        on_stop   : in  std_logic; -- Aktivní signál pro hodinový režim
        BTNC      : in  std_logic; -- Tlačítko pro přepínání hodin
        sec_clk   : out std_logic  -- Výstupní hodinový signál
    );
end component;
component selector is
    Port (
        SW_stopwatch  : in  STD_LOGIC;
        SW_alarm      : in  STD_LOGIC;
        SW_alarm_on   : in  STD_LOGIC;
        SW_set        : in  STD_LOGIC;
        res           : in  STD_LOGIC;
        clk_20Hz      : in  STD_LOGIC;
        vec_dis_set   : out STD_LOGIC_VECTOR(1 downto 0);
        set_alarm     : out STD_LOGIC;
        set_clock     : out STD_LOGIC;
        res_alarm     : out STD_LOGIC;
        res_stopwatch : out STD_LOGIC;
        res_clock     : out STD_LOGIC;
        alarm_on      : out STD_LOGIC
    );
end component;

component signal_control is
    port (
    control              : in  std_logic_vector(1 downto 0); -- Dvoubitový vstupní vektor pro řízení
    clk_20hz             : in  std_logic; -- Hodiny 20 Hz
    sec_clk, min_clk     : in std_logic_vector(5 downto 0); -- Hodiny - sekundy a minuty (6 bitů)
    hour_clk            : in std_logic_vector(4 downto 0); -- Hodiny - hodiny (5 bitů)
    vector_clk           : in std_logic_vector(2 downto 0); -- Hodiny - vectot (3 bitů)
    sec_alarm, min_alarm : in std_logic_vector(5 downto 0); -- Alarm - sekundy a minuty (6 bitů)
    hour_alarm           : in std_logic_vector(4 downto 0); -- Alarm - hodiny (5 bitů)
    vector_alarm           : in std_logic_vector(2 downto 0); -- Hodiny - vectot (3 bitů)
    sec_stop, min_stop   : in std_logic_vector(5 downto 0); -- Stopwatch - sekundy a minuty (6 bitů)
    hour_stop            : in std_logic_vector(4 downto 0); -- Stopwatch - hodiny (5 bitů)
    vector_stop           : in std_logic_vector(2 downto 0); -- Hodiny - vectot (3 bitů)
    sec_out, min_out     : out std_logic_vector(5 downto 0); -- Výstupy - sekundy a minuty (6 bitů)
    hour_out             : out std_logic_vector(4 downto 0);  -- Výstupy - hodiny (5 bitů)
    vector_out           : out std_logic_vector(2 downto 0) -- Hodiny - vectot (3 bitů)
  );
end component;

component alarm_comp is
    port (
        SW_ON         : in  std_logic;  -- Vstupní spínač
        clk           : in  std_logic;  -- hlavní hodinový signál
        A1, A2    : in  std_logic_vector(5 downto 0);
        A3        : in  std_logic_vector(4 downto 0);
        B1, B2    : in  std_logic_vector(5 downto 0);
        B3        : in  std_logic_vector(4 downto 0);
        global_disable: in  std_logic;  -- vstupní signál pro vypnutí alarmu (např. tlačítko)
        alarm         : out std_logic   -- výsledný alarm - '1' pokud je aktivní, jinak '0'
  );
end component;

    component bin2seg_digclk is
    port (
        sec_in     : in  STD_LOGIC_VECTOR(5 downto 0);
        min_in     : in  STD_LOGIC_VECTOR(5 downto 0);
        hour_in    : in  STD_LOGIC_VECTOR(4 downto 0);
        switch     : in  STD_LOGIC;
        CAS        : in  STD_LOGIC_VECTOR(1 downto 0);
        clk_480Hz  : in  STD_LOGIC;
        sel_smh    : in  STD_LOGIC_VECTOR(2 downto 0);
        seg        : out STD_LOGIC_VECTOR(6 downto 0);
        an         : out STD_LOGIC_VECTOR(7 downto 0)
    );
    end component;

    -- Clock signals
    signal sig_clk_1Hz      : STD_LOGIC;
    signal sig_clk_1000Hz    : STD_LOGIC;
    signal sig_clk_20Hz    : STD_LOGIC;
    signal sig_VEC_out    : STD_LOGIC_VECTOR(2 downto 0);
    signal sig_clk_1Hz_stopwatch : STD_LOGIC;
                    
    -- Time values
    signal sig_sec_clock  : STD_LOGIC_VECTOR(5 downto 0);
    signal sig_min_clock  : STD_LOGIC_VECTOR(5 downto 0);
    signal sig_hour_clock : STD_LOGIC_VECTOR(4 downto 0);

    -- Time values for alarm
    signal sig_sec_alarm  : STD_LOGIC_VECTOR(5 downto 0);
    signal sig_min_alarm  : STD_LOGIC_VECTOR(5 downto 0);
    signal sig_hour_alarm : STD_LOGIC_VECTOR(4 downto 0);
    
    -- Time values for stopwatch
    signal sig_sec_stopwatch  : STD_LOGIC_VECTOR(5 downto 0);
    signal sig_min_stopwatch  : STD_LOGIC_VECTOR(5 downto 0);
    signal sig_hour_stopwatch : STD_LOGIC_VECTOR(4 downto 0);
    
        -- Time values for output
    signal sig_sec_out  : STD_LOGIC_VECTOR(5 downto 0);
    signal sig_min_out  : STD_LOGIC_VECTOR(5 downto 0);
    signal sig_hour_out : STD_LOGIC_VECTOR(4 downto 0);
    
     -- Logical signals
     signal sig_SW_alarm_on   :STD_LOGIC;
     signal sig_vec_dis_set   :STD_LOGIC_VECTOR(1 downto 0);
     signal sig_set_alarm   :STD_LOGIC;
     signal sig_set_clock   :STD_LOGIC;
     signal sig_res_alarm   :STD_LOGIC;    
     signal sig_res_stopwatch   :STD_LOGIC;   
     signal sig_res_clock   :STD_LOGIC;
     signal sig_alarm_on   :STD_LOGIC;
     
     -- vector for settings segments
     signal sig_vector_clock  : std_logic_vector(2 downto 0);
     signal sig_vector_alarm  : std_logic_vector(2 downto 0);
     signal sig_vector_stopwatch  : std_logic_vector(2 downto 0);
     signal sig_vector_out  : std_logic_vector(2 downto 0);
     
begin
-- Clock dividers
delicka_1Hz_inst: delicka_1Hz
port map(
    clk_100MHz => clk_100MHz,
    reset => '0',
    clk_1Hz => sig_clk_1Hz
);

delicka_1000Hz_inst: delicka_1000Hz
port map(
    clk_100MHz => clk_100MHz,
    reset => '0',
    clk_1000Hz => sig_clk_1000Hz
);
delicka_20Hz_inst: delicka_20Hz
port map(
    clk_100MHz => clk_100MHz,
    reset => '0',
    clk_20Hz => sig_clk_20Hz
);

hodiny_top_inst: hodiny_top
port map(
    clk_1000Hz => sig_clk_1000Hz,
    clk_20Hz => sig_clk_20Hz,
    clk_1Hz => sig_clk_1Hz,
    SW_set => sig_set_clock,
    res => sig_res_clock,
    BTN_U => BTN_U,
    BTN_D => BTN_D,
    BTN_R => BTN_R,
    VEC_out => sig_vector_clock,
    SEC_out => sig_sec_clock,
    MIN_out => sig_min_clock,
    HOUR_out => sig_hour_clock
);

alarm_top_inst: hodiny_top
port map(
    clk_1000Hz => sig_clk_1000Hz,
    clk_20Hz => sig_clk_20Hz,
    clk_1Hz => '0',
    SW_set => sig_set_alarm,
    res => sig_res_alarm,
    BTN_U => BTN_U,
    BTN_D => BTN_D,
    BTN_R => BTN_R,
    VEC_out => sig_vector_alarm,
    SEC_out => sig_sec_alarm,
    MIN_out => sig_min_alarm,
    HOUR_out => sig_hour_alarm
);

stopwatch_cont_inst: stopwatch_controller
port map(
    clk_1Hz => sig_clk_1Hz,
    on_stop => SW_stopwatch,
    BTNC => SW_stopwatch,
    sec_clk => sig_clk_1Hz_stopwatch
);

stopwatch_top_inst: hodiny_top
port map(
    clk_1000Hz => sig_clk_1000Hz,
    clk_20Hz => sig_clk_20Hz,
    clk_1Hz => sig_clk_1Hz_stopwatch,
    SW_set => '0',
    res => sig_res_stopwatch,
    BTN_U => BTN_U,
    BTN_D => BTN_D,
    BTN_R => BTN_R,
    VEC_out => sig_vector_stopwatch,
    SEC_out => sig_sec_stopwatch,
    MIN_out => sig_min_stopwatch,
    HOUR_out => sig_hour_stopwatch
);

selector_inst: selector
port map(
    clk_20Hz => sig_clk_20Hz,
    SW_set => SW_set,
    res => res,
    SW_stopwatch => SW_stopwatch,
    SW_alarm  => SW_alarm,
    SW_alarm_on => SW_alarm_on,
    vec_dis_set => sig_vec_dis_set,
    set_alarm => sig_set_alarm,
    set_clock => sig_set_clock,
    res_alarm => sig_res_alarm,
    res_stopwatch => sig_res_stopwatch,
    res_clock => sig_res_clock,
    alarm_on => sig_alarm_on
    
);

signal_control_inst: signal_control
    port map(
        control => sig_vec_dis_set,
        clk_20hz => sig_clk_20Hz,
        sec_clk => sig_sec_clock,
        min_clk => sig_min_clock,
        hour_clk => sig_hour_clock, 
        vector_clk => sig_vector_clock,
        sec_alarm => sig_sec_alarm,
        min_alarm => sig_min_alarm,
        hour_alarm => sig_hour_alarm,
        vector_alarm => sig_vector_alarm,
        sec_stop => sig_sec_stopwatch,
        min_stop => sig_min_stopwatch,
        hour_stop => sig_hour_stopwatch,
        vector_stop => sig_vector_stopwatch,
        sec_out => sig_sec_out,
        min_out => sig_min_out,
        hour_out => sig_hour_out,
        vector_out => sig_vector_out
);

ala_comp_inst: alarm_comp
port map(
    SW_ON => sig_alarm_on,
    clk => sig_clk_20Hz,
    A1 => sig_sec_alarm,
    A2 => sig_min_alarm,
    A3 => sig_hour_alarm,
    B1 => sig_sec_clock,
    B2 => sig_min_clock,
    B3 => sig_hour_clock,
    alarm => piezo,
    global_disable => BTN_U
);
-- Display driver
bin2seg_digclk_inst: bin2seg_digclk
port map(
    sec_in => sig_sec_out,
    min_in => sig_min_out,
    hour_in => sig_hour_out,
    switch => SW_set,
    CAS => sig_vec_dis_set,
    clk_480Hz => sig_clk_1000Hz,
    sel_smh => sig_vector_out,
    seg => seg,
    an => an
);

end Behavioral;