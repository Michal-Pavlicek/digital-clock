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


### Top_Level schematic
![TopLevel](images/top_level_schematic.png)
fmdbfdkfd

### Hodiny_top schematic
![Hodiny_top](images/hodiny_top_schematic.png)
gdgdgf

#### Seconds_counter schematic
![Seconds_counter](images/seconds_counter.png)
gdgdgf

#### KO schematic
![KO](images/KO_schematic.png)
gdgdgf

### BIN2SEG schematic
![bin2seg](images/bin2seg_schematic.png)
This block is used for visual output of the clock. There are four key features. Converting the time from binary to binary-coded decimal, displaying the time on the 7-segment display, displaying the current mode and blinking feature for indication of setting the time.
First, the corresponding number displayed is assigned to each number in BCD format as well as the mode indication CAS. Then there is enabling the blinking while setting function using clock signal. Then the conversion from binary to BCD takes place. Dividing the numbers to tens and units. The multiplexing overwrites the displays using clock signal, it is done fast enough to be unnoticeable by human eye. Lastly the numbers are displayed on corresponding displays.

### Alarm_comp_schematic
![Alarm_comp](images/ala_comp_schematic.png)
gdgdgf

### Top_level simulation - Automatic mode
![Automatic_mode](images/Automatic_mode.png)
sgd

### Top_level simulation - Manual mode
![Manual_mode](images/Manual_mode.png)
