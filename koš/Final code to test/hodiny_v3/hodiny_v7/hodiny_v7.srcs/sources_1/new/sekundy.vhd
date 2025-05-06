library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SecondsCounter is
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
end SecondsCounter;

architecture Behavioral of SecondsCounter is
    signal seconds   : integer range 0 to 59 := 0;
    signal carry_reg : std_logic := '0';
    signal btn_u_prev, btn_d_prev : std_logic := '0';
    signal add_clk_prev : std_logic := '0';
    
begin

-- Proces pro přičítání sekund (add_clk)
process(clk_1000Hz, res)
begin
    if res = '1' then
        btn_u_prev <= '0';
        btn_d_prev <= '0';
        add_clk_prev <= '0';
        seconds <= 0;
        carry_reg <= '0';

    elsif rising_edge(clk_1000Hz) then
        carry_reg <= '0';  -- výchozí hodnota každým taktem

        -- Automatické přičítání minut (detekce hrany add_clk)
        if VEC_set = "00" then
            if add_clk = '1' and add_clk_prev = '0' then  -- vzestupná hrana
                if seconds = 59 then
                    seconds <= 0;
                    carry_reg <= '1';
                else
                    seconds <= seconds + 1;
                end if;
            end if;
        end if;

        -- Ruční přičítání pomocí tlačítek
        if VEC_set = "01" then
            -- BTN_U
            if add_BTN_U = '1' and btn_u_prev = '0' then
                btn_u_prev <= '1';
                if seconds = 59 then
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
                    seconds <= 59;
                else
                    seconds <= seconds - 1;
                end if;
            elsif add_BTN_D = '0' and btn_d_prev = '1' then
                btn_d_prev <= '0';
            end if;
        end if;

        -- Uložení předchozí hodnoty add_clk
        add_clk_prev <= add_clk;
    end if;
end process;



    SEC_out <= std_logic_vector(to_unsigned(seconds, 6));
    carry   <= carry_reg;

end Behavioral;
