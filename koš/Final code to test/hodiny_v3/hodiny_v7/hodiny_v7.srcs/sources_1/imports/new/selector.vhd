library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity selector is
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
end selector;

architecture Behavioral of selector is
begin

    process(clk_20Hz)
    begin
        if rising_edge(clk_20Hz) then
        

            if res = '1' and SW_set = '1' and SW_alarm = '1' and SW_stopwatch = '1'  then
                set_alarm     <= '0';
                set_clock     <= '0';
                res_clock     <= '0';
                res_alarm     <= '0';
                res_stopwatch <= '0';
                alarm_on      <= '0';
                vec_dis_set   <= "00";

            elsif res = '1' and SW_set = '1' and SW_alarm = '1' and SW_stopwatch = '0'  then
                set_alarm     <= '0';
                set_clock     <= '0';
                res_clock     <= '0';
                res_alarm     <= '0';
                res_stopwatch <= '0';
                alarm_on      <= '0';
                vec_dis_set   <= "00";
 
             elsif res = '1' and SW_set = '1' and SW_alarm = '0' and SW_stopwatch = '1'  then
                set_alarm     <= '0';
                set_clock     <= '0';
                res_clock     <= '0';
                res_alarm     <= '0';
                res_stopwatch <= '0';
                alarm_on      <= '0';
                vec_dis_set   <= "00";
 
             elsif res = '1' and SW_set = '1' and SW_alarm = '0' and SW_stopwatch = '0'  then
                set_alarm     <= '0';
                set_clock     <= '0';
                res_clock     <= '0';
                res_alarm     <= '0';
                res_stopwatch <= '0';
                alarm_on      <= '0';
                vec_dis_set   <= "00";
 
             elsif res = '1' and SW_set = '0' and SW_alarm = '1' and SW_stopwatch = '1'  then
                set_alarm     <= '0';
                set_clock     <= '0';
                res_clock     <= '0';
                res_alarm     <= '1';
                res_stopwatch <= '1';
                alarm_on      <= '0';
                vec_dis_set   <= "01";
 
             elsif res = '1' and SW_set = '0' and SW_alarm = '1' and SW_stopwatch = '0'  then
                set_alarm     <= '0';
                set_clock     <= '0';
                res_clock     <= '0';
                res_alarm     <= '1';
                res_stopwatch <= '0';
                alarm_on      <= '0';
                vec_dis_set   <= "01";
 
             elsif res = '1' and SW_set = '0' and SW_alarm = '0' and SW_stopwatch = '1'  then
                set_alarm     <= '0';
                set_clock     <= '0';
                res_clock     <= '0';
                res_alarm     <= '0';
                res_stopwatch <= '1';
                alarm_on      <= '0';
                vec_dis_set   <= "10";
                
              elsif res = '1' and SW_set = '0' and SW_alarm = '0' and SW_stopwatch = '0'  then
                set_alarm     <= '0';
                set_clock     <= '0';
                res_clock     <= '1';
                res_alarm     <= '0';
                res_stopwatch <= '0';
                alarm_on      <= '0';
                vec_dis_set   <= "00";
 
             elsif res = '0' and SW_set = '1' and SW_alarm = '1' and SW_stopwatch = '1'  then
                set_alarm     <= '0';
                set_clock     <= '0';
                res_clock     <= '0';
                res_alarm     <= '0';
                res_stopwatch <= '0';
                alarm_on      <= '0';
                vec_dis_set   <= "00";
 
             elsif res = '0' and SW_set = '1' and SW_alarm = '1' and SW_stopwatch = '0'  then
                set_alarm     <= '1';
                set_clock     <= '0';
                res_clock     <= '0';
                res_alarm     <= '0';
                res_stopwatch <= '0';
                alarm_on      <= '0';
                vec_dis_set   <= "01";
 
             elsif res = '0' and SW_set = '1' and SW_alarm = '0' and SW_stopwatch = '1'  then
                set_alarm     <= '0';
                set_clock     <= '0';
                res_clock     <= '0';
                res_alarm     <= '0';
                res_stopwatch <= '0';
                alarm_on      <= '0';
                vec_dis_set   <= "10";

            elsif res = '0' and SW_set = '1' and SW_alarm = '0' and SW_stopwatch = '0'  then
                set_alarm     <= '0';
                set_clock     <= '1';
                res_clock     <= '0';
                res_alarm     <= '0';
                res_stopwatch <= '0';
                alarm_on      <= '0';
                vec_dis_set   <= "00";

            elsif res = '0' and SW_set = '0' and SW_alarm = '1' and SW_stopwatch = '1'  then
                set_alarm     <= '0';
                set_clock     <= '0';
                res_clock     <= '0';
                res_alarm     <= '0';
                res_stopwatch <= '0';
                alarm_on      <= '0';
                vec_dis_set   <= "00";

            elsif res = '0' and SW_set = '0' and SW_alarm = '1' and SW_stopwatch = '0'  then
                set_alarm     <= '0';
                set_clock     <= '0';
                res_clock     <= '0';
                res_alarm     <= '0';
                res_stopwatch <= '0';
                alarm_on      <= '0';
                vec_dis_set   <= "01";

            elsif res = '0' and SW_set = '0' and SW_alarm = '0' and SW_stopwatch = '1'  then
                set_alarm     <= '0';
                set_clock     <= '0';
                res_clock     <= '0';
                res_alarm     <= '0';
                res_stopwatch <= '0';
                alarm_on      <= '0';
                vec_dis_set   <= "10";
                
            elsif res = '0' and SW_set = '0' and SW_alarm = '0' and SW_stopwatch = '0'  then
                set_alarm     <= '0';
                set_clock     <= '0';
                res_clock     <= '0';
                res_alarm     <= '0';
                res_stopwatch <= '0';
                alarm_on      <= '0';
                vec_dis_set   <= "00";

             elsif SW_alarm_on = '1' then
                alarm_on      <= '1';
                                             
            else
                set_alarm     <= '0';
                set_clock     <= '0';
                res_clock     <= '0';
                res_alarm     <= '0';
                res_stopwatch <= '0';
                alarm_on      <= '0';
                vec_dis_set   <= "00";
            end if;
        end if;
    end process;

end Behavioral;
