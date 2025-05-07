# Digital-clock

## Team members
* Mezera Vojtěch
* Moravec David
* Pavlíček Michal
* Mostecký Filip

## Abstract
Main objective of this project was to implement functional digital clock with stop watch and alarm clock on development board Nexys A7-50T in VHDL. Upon startup, the system defaults to digital clock mode, and the 7-segment display begins counting from zero.

If user wishes to manually change time, he can flick the switch "SW_set" to on position and with BTN_R button choose if he wants to change hours/mins/secs. Then with buttons BTN_U or BTN_D he may increase or decrease the time unit showed on 7-segment display. To save the set time, simply flick the switch "SW_set" to off position. To reset the time to default, simply flick the "res" switch to on and off postion.

If user wants to turn on stopwatch, simply put "SW_stopwatch" switch to on position. The stopwatch control is as follows: Button BTN_C is for starting and resuming the timer, to reset the timer completly, flick the "res" switch on and off.

To set the time on the alarm clock, user has to set the "SW_alarm" switch to on position. Then setting time, when the alarm will go off, is the same as manually changing time in digital clock, as described above. To turn on the alarm clock, user has to enable "SW_alarm_on" switch.

## Assignment of functions to components 
![Nexys_board](images/Nexys.drawio.png)

### Example of the seconds counter overflow
![Dig_clock_overflow](images/Dig_clock_overflow.gif)

### Example of the reset functionality
![Dig_clock_overflow](images/Dig_clock_reset_functionality.gif)

### Example of stopwatch functionality
![Stopwatch](images/Stopwatch_functionality.gif)

### Hodiny_top schematic
![Hodiny_top](images/hodiny_top_schematic.png)
The component combines the functionality of individual counters and serves to simplify the design, as it is used three times and helps make the entire circuit more organized. The individual blocks are described in detail below.

#### KO schematic
![KO](images/KO_schematic.png)
This module **combines both manual and automatic counter control**. When **SW_set** is **inactive**, the system **operates in automatic mode**. In this mode, the add_set vector (input to the counters' VEC_set ports) is set to **"00"**, allowing the clock to run **automatically and increment every second**.

When **SW_set** is **activated**, the system switches to **manual mode**: the 1 Hz clock signal is disabled, and the internal counting logic inside the KO block is enabled. Pressing the BTNR button then increments the value of the add_set vector, which determines which counter is currently being adjusted using the BTNU (up) and BTND (down) buttons. If **add_set** is set to **"01" is it for the second counter**, if is set to **"10" is it for the minute counter** and **"11" is for the hour counter** activation.

#### Seconds_counter schematic
![Seconds_counter](images/seconds_counter.png)
The block functions as a **seconds counter**, with its output being a 6-bit vector **SEC_out** representing the counted number of seconds. When an overflow occurs, the output signal carry changes state, this signal serves as an input for the minute counter. This process is automatic, that means each second the output vector increases by 1, which can be observed in the top-level simulation in automatic mode.

This mode is defined by the value of the 2-bit input vector **VEC_set**. When **VEC_set is "00"**, the counter operates in **automatic mode**, incrementing every second. If **VEC_set is "01"**, **manual mode** is activated, which can be observed in the top-level simulation in manual mode. In this mode, the counter responds to the **BTNU** button, pressing it **increments** the counter regardless of the 1 Hz clock signal, while pressing **BTND decrements** the counter. Overflow can also occur in manual mode. 

The minute and hour counters operate on the same principle, with the only difference being the value of **VEC_set** it is set to **"10" for the minute counter** and **"11" for the hour counter**. The hour counter must also count up to 23.

**Button debounce** is handled by a **process triggered by a 20 Hz clock signal**. This frequency is slow enough to allow button bounce effects to settle before the next evaluation, effectively filtering them out.

### BIN2SEG schematic
![bin2seg](images/bin2seg_schematic.png)
This block is used for visual output of the clock. There are four key features:
* Converting the time from binary to binary-coded decimal
* Displaying the time on the 7-segment display
* Displaying the current mode
* Blinking feature for indication of setting the time

First, the corresponding number displayed is assigned to each number in BCD format as well as the mode indication CAS. Then there is enabling the blinking while setting function using clock signal. Then the conversion from binary to BCD takes place. Dividing the numbers to tens and units. The multiplexing overwrites the displays using clock signal, it is done fast enough to be unnoticeable by human eye. Lastly the numbers are displayed on corresponding displays.

### Alarm_comp_schematic
![Alarm_comp](images/ala_comp_schematic.png)
The block operates on the principle of comparing the time set on the alarm counter with the current time counted by the real-time counter instance. If the two times match and the alarm activation condition is met, the alarm is triggered. At this moment, an internal signal is activated, indicating that the alarm condition has been reached. This signal remains active until the user presses the 'UP' button, which deactivates the alarm and resets the signal

### Top_Level schematic
![TopLevel](images/top_level_schematic.png)
Here is the wiring of the entire system.

### Top_level simulation - Automatic mode
![Automatic_mode](images/Automatic_mode.png)
Here we can see that when SW_set is set to 0, SEC_out is incremented on every rising edge of clk_1Hz

### Top_level simulation - Manual mode
![Manual_mode](images/Manual_mode.png)
Here we can see that when SW_set is set to 1, with every impulse from BTN_U or BTN_D, the selected time unit is incremented or decremented. Time unit selected for change is set by VEC_out, where:
* 001 - seconds
* 010 - minutes
* 100 - hours

and can be changed with BTN_R
## References 
* https://github.com/tomas-fryza/vhdl-labs
* https://chatgpt.com/
* https://vhdl.lapinoo.net/
