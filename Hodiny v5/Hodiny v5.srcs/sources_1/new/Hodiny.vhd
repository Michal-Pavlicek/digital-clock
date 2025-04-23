library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity HoursCounter is
    Port (
        clk_1000Hz : in  std_logic;
        add_clk    : in  std_logic;
        add_BTN_U  : in  std_logic;
        add_BTN_D  : in  std_logic;
        VEC_set    : in  std_logic_vector(1 downto 0);
        res        : in  std_logic;
        SEC_out    : out std_logic_vector(4 downto 0);
        carry      : out std_logic
    );
end HoursCounter;

architecture Behavioral of HoursCounter is
    signal seconds   : integer range 0 to 23 := 0;
    signal carry_reg : std_logic := '0';
    signal btn_u_prev, btn_d_prev : std_logic := '0';
begin

-- Proces pro přičítání hodin (add_clk)
process(add_clk, res)
begin
    if res = '1' then
        seconds <= 0;
        carry_reg <= '0';

    elsif rising_edge(add_clk) then
        if VEC_set = "00" then
            if seconds = 23 then
                seconds <= 0;
                carry_reg <= '1';
            else
                seconds <= seconds + 1;
                carry_reg <= '0';
            end if;
        end if;
    end if;
end process;

-- Proces pro reakci na tlačítka (clk_1000Hz)
process(clk_1000Hz, res)
begin
    if res = '1' then
        btn_u_prev <= '0';
        btn_d_prev <= '0';

    elsif rising_edge(clk_1000Hz) then
        if VEC_set = "11" then
            -- BTN_U
            if add_BTN_U = '1' and btn_u_prev = '0' then
                btn_u_prev <= '1';
                if seconds = 23 then
                    seconds <= 0;
                else
                    seconds <= seconds + 1;
                end if;
            elsif add_BTN_U = '0' and btn_u_prev = '1' then
                btn_u_prev <= '0';
            end if;

            -- BTN_D
            if add_BTN_D = '1' and btn_d_prev = '0' then
                btn_d_prev <= '1';
                if seconds = 0 then
                    seconds <= 23;
                else
                    seconds <= seconds - 1;
                end if;
            elsif add_BTN_D = '0' and btn_d_prev = '1' then
                btn_d_prev <= '0';
            end if;
        end if;
    end if;
end process;

    SEC_out <= std_logic_vector(to_unsigned(seconds, 5));
    carry   <= carry_reg;

end Behavioral;
