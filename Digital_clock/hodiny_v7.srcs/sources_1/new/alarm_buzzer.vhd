library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alarm_buzzer is
    Port (
        alarm    : in  STD_LOGIC;   -- Vstupní signál alarmu (1 = aktivní)
        clk      : in  STD_LOGIC;   -- Hodinový signál 20 Hz
        buzzer   : out STD_LOGIC    -- Výstup pro bzučák
    );
end alarm_buzzer;

architecture Behavioral of alarm_buzzer is
begin
    -- Bzučák je aktivován pouze při alarmu a kmitá na 20 Hz
    buzzer <= alarm and clk;
end Behavioral;