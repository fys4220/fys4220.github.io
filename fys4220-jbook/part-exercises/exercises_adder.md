(exercises-adder)=
# EX2: Adder

The goal of this exercise is to design and simulate a 4-bit full adder. The adder will add two 4-bit values defined by the slide swithces and show the result on the LEDs. 
```{admonition} The learning outcome of this exercise is to:
* Be able to describe basic combinational logic with VHDL.
* Be able to simulate your design using a basic VHDL test bench and Modelsim
* Be able to partition your design in sub-units and combine then using a structural design.
```

Before you start to write code it is always recommended to first spend some time to think about and plan how you want to solve the problem. It can e.g., be helpful to draw a basic block diagram or schematic to outline your design. 

The exercise is divided into 3 parts:
- EX2.A: 1-bit half adder
- EX2.B: 1-bit full adder
- EX2.C: 4-bit full adder

(exercises-adder-a)=
## EX2.A: 1-bit half adder

In the previous exercise you were introduced to the Quartus Prime Lite design tool and you learnt how to build your first FPGA project and program the FPGA. The design was very simple, connecting an input directly to an output. In this exercise you will now see you can use VHDL to write combinational logic. We will use the example of a half-adder. Create a new Quartus Prime Lite project and write the necessary VHDL code to implement a half adder. Test the adder in hardware. 

(exercises-adder-b)=
## EX2.B: 1-bit full adder

Expand on your half adder design to also include a carry in signal, making it a full adder.

In the previous exercises you have tested and verified your design directly in hardware. This is not the recommended method of working. It is instead good practice to always verify your design through simulations before testing in hardware. This is achieved using testbenches written in VHDL. Make sure to study the section {ref}`vhdl-testbenches` before you continue. Use the knowlegde gained from that section to build a testbench for your full adder design. 


(exercises-adder-c)=
## EX2.C 4-bit full adder


%Test in hardware but do not simulate

%## 1-bit full adderom this point we start to simulate.

%## 4-bit full adder
