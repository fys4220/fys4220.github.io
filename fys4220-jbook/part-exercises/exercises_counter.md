(exercises-counter)=
# EX3: 4-bit up-counter

In this problem you will first implement a 4-bit up-counter based on the 4-bit adder from the previous exercise.

```{admonition} The learning outcome of this exercise is to:
- Be able to implement a basic counter in VHDL using two different approaches: a low level and high level approach. This will help you to better understand the power of the high level VHDL language for designing complex logic circuits.
- Be able to use the process statement in VHDL to describe synchronous logic.
- Be able to use the unsigned signal type and the IEEE numeric standard library to implement the counter. 
- Be able to detect the edge of a signal and use it as a counter enable signal
```

The main functional requirements of the counter are:
- The counter shall increment its output by 1 when one of the FPGA board's push buttons (KEY1) is pressed. That is, the button will act as a count enable.
- The count enable signal shall be active low. 
- The counter design shall run on a clock frequency of 50 MHz (frequency provided by the external clocking circuit on the DE10-Lite board).
- The counter shall count from 0 to 15. When the counter reaches 15, the next output value shall be 0. 
- The counter shall be reset (output shall be 0) when one of the FPGA board´s buttons (KEY0) is pressed. The reset shall be an active low and asynchronous. 


The main test requirements are:
- The counter shall be verified using a testbench. 
- Verify that all valid values of the counter are reached in the correct order. 
- The duration of the count enable signal shall be longer than 10 system clock cycles.
- Verify correct transition from 15 to 0 on the output
- Verify that the counter can be reset. This does not have to be done for all values, but verify at least for one other value than 0. 
- The reset signal shall be longer than 10 system clock cycles.

## EX3.A: Combinational adder based design

In this part you will implement the counter using the 4-bit adder design from the previous exercise. Verify the counter in simulation according to the test requirements above. Ask a fellow student to review your testbench and verify your simulation results. This can be done either by asking her/him to inspect your code and results on Github, or by discussing your code and results in person in the lab or on Zoom. 

Test your code in hardware. Connect the output of the counter to 4 of the LEDs.

## EX3.B: High level implementation

Designing a simple 4-bit up-counter using the combinational 4-bit adder design is not a very effective approach. It is better to make use of the high level features in the VHDL language. 

using a VHDL process statment. The up-counter shall be incremented using one of the onboard push buttons ( KEY1 ) as a count enable. A second push button ( KEY0 ) will be used to reset the up-counter asynchronously. You will then use a pre-made template to write a test bench that can be used to verify correct behaviour of the up-counter before finally programming the FPGA.


