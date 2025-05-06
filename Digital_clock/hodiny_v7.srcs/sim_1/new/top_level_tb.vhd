library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level_tb is
end top_level_tb;

architecture Behavioral of top_level_tb is

    component top_level
        Port (
            clk_100MHz   : in  STD_LOGIC;
            res          : in  STD_LOGIC;
            SW_set       : in  std_logic;
            SW_alarm     : in  std_logic;
            SW_alarm_on  : in  std_logic;
            SW_stopwatch : in  std_logic;
            BTN_U        : in  std_logic;
            BTN_D        : in  std_logic;
            BTN_R        : in  std_logic;
            BTN_C        : in  std_logic;
            CA           : out std_logic;
            CB           : out std_logic;
            CC           : out std_logic;
            CD           : out std_logic;
            CE           : out std_logic;
            CF           : out std_logic;
            CG           : out std_logic;
            AN           : out std_logic_vector(7 downto 0);
            alarm_out    : out std_logic
        );
    end component;

    signal clk_100MHz : STD_LOGIC := '0';
    signal res        : STD_LOGIC := '0';
    signal SW_set     : STD_LOGIC := '0';
    signal SW_alarm   : STD_LOGIC := '0';
    signal SW_alarm_on: STD_LOGIC := '0';
    signal SW_stopwatch:STD_LOGIC := '0';
    signal BTN_U      : STD_LOGIC := '0';
    signal BTN_D      : STD_LOGIC := '0';
    signal BTN_R      : STD_LOGIC := '0';
    signal BTN_C      : STD_LOGIC := '0';
    
    signal CA, CB, CC, CD, CE, CF, CG : STD_LOGIC;
    signal AN         : STD_LOGIC_VECTOR(7 downto 0);
    signal alarm_out  : STD_LOGIC;

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: top_level 
    port map (
        clk_100MHz   => clk_100MHz,
        res          => res,
        SW_set       => SW_set,
        SW_alarm     => SW_alarm,
        SW_alarm_on  => SW_alarm_on,
        SW_stopwatch => SW_stopwatch,
        BTN_U        => BTN_U,
        BTN_D        => BTN_D,
        BTN_R        => BTN_R,
        BTN_C        => BTN_C,
        CA           => CA,
        CB           => CB,
        CC           => CC,
        CD           => CD,
        CE           => CE,
        CF           => CF,
        CG           => CG,
        AN           => AN,
        alarm_out    => alarm_out
    );

    clk_process: process
    begin
        clk_100MHz <= '0';
        wait for CLK_PERIOD/2;
        clk_100MHz <= '1';
        wait for CLK_PERIOD/2;
    end process;

    stim_proc: process
    begin
        -- Reset
        res <= '1';
        wait for 100 ns;
        res <= '0';
        wait for 100 ns;

        -- Aktivace manuálního režimu
        SW_set <= '1';
        wait for 1 ms;

        -- Výběr sekund
        BTN_R <= '1'; wait for 50 ms; BTN_R <= '0'; wait for 50 ms;

        -- 6x increment sekund
        BTN_U <= '1'; wait for 50 ms; BTN_U <= '0'; wait for 50 ms;
        BTN_U <= '1'; wait for 50 ms; BTN_U <= '0'; wait for 50 ms;
        BTN_U <= '1'; wait for 50 ms; BTN_U <= '0'; wait for 50 ms;
        BTN_U <= '1'; wait for 50 ms; BTN_U <= '0'; wait for 50 ms;
        BTN_U <= '1'; wait for 50 ms; BTN_U <= '0'; wait for 50 ms;
        BTN_U <= '1'; wait for 50 ms; BTN_U <= '0'; wait for 50 ms;

        -- 3x decrement sekund
        BTN_D <= '1'; wait for 50 ms; BTN_D <= '0'; wait for 50 ms;
        BTN_D <= '1'; wait for 50 ms; BTN_D <= '0'; wait for 50 ms;
        BTN_D <= '1'; wait for 50 ms; BTN_D <= '0'; wait for 50 ms;

        -- Přepnutí na minuty
        BTN_R <= '1'; wait for 50 ms; BTN_R <= '0'; wait for 50 ms;

        -- 6x increment minut
        BTN_U <= '1'; wait for 50 ms; BTN_U <= '0'; wait for 50 ms;
        BTN_U <= '1'; wait for 50 ms; BTN_U <= '0'; wait for 50 ms;
        BTN_U <= '1'; wait for 50 ms; BTN_U <= '0'; wait for 50 ms;
        BTN_U <= '1'; wait for 50 ms; BTN_U <= '0'; wait for 50 ms;
        BTN_U <= '1'; wait for 50 ms; BTN_U <= '0'; wait for 50 ms;
        BTN_U <= '1'; wait for 50 ms; BTN_U <= '0'; wait for 50 ms;

        -- 3x decrement minut
        BTN_D <= '1'; wait for 50 ms; BTN_D <= '0'; wait for 50 ms;
        BTN_D <= '1'; wait for 50 ms; BTN_D <= '0'; wait for 50 ms;
        BTN_D <= '1'; wait for 50 ms; BTN_D <= '0'; wait for 50 ms;

        -- Přepnutí na hodiny
        BTN_R <= '1'; wait for 50 ms; BTN_R <= '0'; wait for 50 ms;

        -- 6x increment hodin
        BTN_U <= '1'; wait for 50 ms; BTN_U <= '0'; wait for 50 ms;
        BTN_U <= '1'; wait for 50 ms; BTN_U <= '0'; wait for 50 ms;
        BTN_U <= '1'; wait for 50 ms; BTN_U <= '0'; wait for 50 ms;
        BTN_U <= '1'; wait for 50 ms; BTN_U <= '0'; wait for 50 ms;
        BTN_U <= '1'; wait for 50 ms; BTN_U <= '0'; wait for 50 ms;
        BTN_U <= '1'; wait for 50 ms; BTN_U <= '0'; wait for 50 ms;

        -- 3x decrement hodin
        BTN_D <= '1'; wait for 50 ms; BTN_D <= '0'; wait for 50 ms;
        BTN_D <= '1'; wait for 50 ms; BTN_D <= '0'; wait for 50 ms;
        BTN_D <= '1'; wait for 50 ms; BTN_D <= '0'; wait for 50 ms;

        -- Návrat do auto režimu
        SW_set <= '0';
        wait for 10 sec;

        wait;
    end process;

end Behavioral;