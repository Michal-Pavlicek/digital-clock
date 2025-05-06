library IEEE;
use IEEE.std_logic_1164.all;

entity control_stopwatch is
  port (
    clk_1Hz   : in  std_logic; -- Vstupn� hodinov� sign�l 1 Hz
    on_stop   : in  std_logic; -- Aktivn� sign�l pro hodinov� re�im
    BTNC      : in  std_logic; -- Tla?�tko pro p?ep�n�n� hodin
    sec_clk   : out std_logic  -- V�stupn� hodinov� sign�l
  );
end control_stopwatch;

architecture Behavioral of control_stopwatch is
  signal toggle_state : std_logic := '0'; -- Intern� sign�l pro udr�ov�n� stavu (toggle)
  signal prev_btnc    : std_logic := '0'; -- Intern� sign�l pro sledov�n� p?edchoz�ho stavu tla?�tka
begin
  process(clk_1Hz)
  begin
    if rising_edge(clk_1Hz) then
      -- Detekce stisknut� tla?�tka (p?echod z '0' na '1')
      if BTNC = '1' and prev_btnc = '0' then
        -- P?epnut� stavu pouze pokud je on_stop aktivn�
        if on_stop = '1' then
          toggle_state <= not toggle_state; -- P?epnut� stavu
        end if;
      end if;

      -- Aktualizace p?edchoz�ho stavu tla?�tka
      prev_btnc <= BTNC;

      -- Propou�t?n� hodinov�ho sign�lu, pokud je toggle_state na �rovni 1
      if toggle_state = '1' then
        sec_clk <= clk_1Hz; -- Propou�t� se vstupn� hodinov� sign�l
      else
        sec_clk <= '0'; -- V�stupn� sign�l neaktivn�
      end if;
    end if;
  end process;
end Behavioral;