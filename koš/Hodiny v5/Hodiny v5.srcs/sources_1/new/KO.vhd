library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity KO is
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
end KO;

architecture Behavioral of KO is
    signal cnt : integer range 0 to 4 := 0;
    signal BTN_R_prev : std_logic := '0';
begin
    process(clk20Hz,clk1Hz)
    begin
    	if SW = '0' then
                add_clk    <= clk1Hz;
                add_set    <= (others => '0');
                add_BTN_U  <= '0';
                add_BTN_D  <= '0';
            else
                add_clk    <= '0';
                add_BTN_U  <= BTN_U;
                add_BTN_D  <= BTN_D;
                
                -- Detekce n�b?�n� hrany BTN_R
            
 				if BTN_R = '1' and BTN_R_prev = '0' then
                    if cnt = 4 then
                        cnt <= 0;
                    else
                        cnt <= cnt + 1;
                    end if;
                end if;
            add_set <= std_logic_vector(to_unsigned(cnt, 2));
            -- Ulo�en� p?edchoz� hodnoty BTN_R pro detekci n�b?�n� hrany
            BTN_R_prev <= BTN_R;
               
        end if;
    end process;
    
end Behavioral;