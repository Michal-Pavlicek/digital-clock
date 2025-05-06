library IEEE;
use IEEE.std_logic_1164.all;

entity stopwatch_controller is
  port (
    clk_1Hz   : in  std_logic; -- Vstupní hodinový signál 1 Hz
    clk_20Hz  : in  std_logic; -- Vstupní hodinový signál 20 Hz
    on_stop   : in  std_logic; -- Aktivní signál pro hodinový režim
    BTNC      : in  std_logic; -- Tla�?ítko pro přepínání hodin
    sec_clk   : out std_logic  -- Výstupní hodinový signál
  );
end stopwatch_controller;

architecture Behavioral of stopwatch_controller is
  signal toggle_state : std_logic := '0'; -- Interní signál pro udržování stavu (toggle)
  signal prev_btnc    : std_logic := '0'; -- Interní signál pro sledování předchozího stavu tla�?ítka
begin
  process(clk_1Hz, clk_20Hz)
  begin
    if rising_edge(clk_20Hz) then
      -- Detekce stisknutí tla�?ítka (přechod z '0' na '1')
      if BTNC = '1' and prev_btnc = '0' then
        -- Přepnutí stavu pouze pokud je on_stop aktivní
        if on_stop = '1' then
          toggle_state <= not toggle_state; -- Přepnutí stavu
        end if;
      end if;

      -- Aktualizace předchozího stavu tla�?ítka
      prev_btnc <= BTNC;

      -- Propouštění hodinového signálu, pokud je toggle_state na úrovni 1
      if toggle_state = '1' then
        sec_clk <= clk_1Hz; -- Propouští se vstupní hodinový signál
      else
        sec_clk <= '0'; -- Výstupní signál neaktivní
      end if;
    end if;
  end process;
end Behavioral;