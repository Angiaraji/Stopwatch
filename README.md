# Stopwatch
Design and implementation of digital Stopwatch in Spartan 3 FPGA


Stopwatch design has two input buttons. Button 1 is to switch between Start, Stop and Run states and button 2 is to reset.
It has four 8-bit output for 7-segment LED display control which shows the tens and ones of minutes and seconds. 
The design of the stopwatch controller is implemented by the design of Finite State Machine as below.

![](StopwatchFSM.jpg)

The overall design files includes:

1. Design of seven segment decoder and test bench
2. Design of stopwatch controller and test bench
3. Push button debounce logic for stopwatch and test bench
3. Overall top level for the stopwatch design and test bench
4. Constraint file, bit file and reports.

Below is the schematic representation of the overall design.

![](implemented-design.jpg)

