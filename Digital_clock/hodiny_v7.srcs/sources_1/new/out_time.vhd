library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity signal_control is
  port (
    control              : in  std_logic_vector(1 downto 0); -- Dvoubitový vstupní vektor pro řízení
    clk_20hz             : in  std_logic; -- Hodiny 20 Hz
    sec_clk, min_clk     : in std_logic_vector(5 downto 0); -- Hodiny - sekundy a minuty (6 bitů)
    hour_clk             : in std_logic_vector(4 downto 0); -- Hodiny - hodiny (5 bitů)
    vector_clk           : in std_logic_vector(2 downto 0); -- Hodiny - vectot (3 bitů)
    sec_alarm, min_alarm : in std_logic_vector(5 downto 0); -- Alarm - sekundy a minuty (6 bitů)
    hour_alarm           : in std_logic_vector(4 downto 0); -- Alarm - hodiny (5 bitů)
    vector_alarm           : in std_logic_vector(2 downto 0); -- Alarm - vectot (3 bitů)
    sec_stop, min_stop   : in std_logic_vector(5 downto 0); -- Stopwatch - sekundy a minuty (6 bitů)
    hour_stop            : in std_logic_vector(4 downto 0); -- Stopwatch - hodiny (5 bitů)
    vector_stop           : in std_logic_vector(2 downto 0); -- Stopwatch - vectot (3 bitů)
    sec_out, min_out     : out std_logic_vector(5 downto 0); -- Výstupy - sekundy a minuty (6 bitů)
    hour_out             : out std_logic_vector(4 downto 0);  -- Výstupy - hodiny (5 bitů)
    vector_out           : out std_logic_vector(2 downto 0) -- Výstup - vectot (3 bitů)
  );
end signal_control;

architecture Behavioral of signal_control is
begin
  process(clk_20hz)
  begin
    if rising_edge(clk_20hz) then
      -- Propouštění signálů na základě aktuálního režimu
      case control is
        when "00" =>
          sec_out <= sec_clk;
          min_out <= min_clk;
          hour_out <= hour_clk;
          vector_out <= vector_clk;
        when "01" =>
          sec_out <= sec_alarm;
          min_out <= min_alarm;
          hour_out <= hour_alarm;
          vector_out <= vector_alarm;
        when "10" =>
          sec_out <= sec_stop;
          min_out <= min_stop;
          hour_out <= hour_stop;
          vector_out <= vector_stop;
        when others =>
          sec_out <= sec_clk;
          min_out <= min_clk;
          hour_out <= hour_clk;
          vector_out <= vector_clk;
      end case;
    end if;
  end process;
end Behavioral;
