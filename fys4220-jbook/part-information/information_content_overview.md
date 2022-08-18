# Content and learning objectives

```{admonition} Case
:class: note

Imagine that you are part of a team that is working on a project where you need to monitor the amount of vibration a system is exposed to. This could for example be:
* To measure the vibration experienced by a scientific payload or other parts of a rocket during launch. 
* Or to be used as a diagnotic tool where vibration data and machine learning techniques are combined to detect or predict possible failure modes.
* *Can you think of other examples?*

Your team has decided that the best solution to this problem is to design a small embedded system to measure vibration using an accelerometer. Neither you nor any of your team members have any prior experience in embedded systems design. However, since you are the only one with some background in basic electronics and programming, you are trusted with the responsibility to lead this work. To prepare your self, you have therefore decided to follow the course FYS4220, where in fact it is required to build a very similar system as part of the course. 
```

This course gives and introduction to the design of digital and embedded systems using programmable logic (FPGA technology). This includes hardware description language (VHDL), verification and testing of digital designs, implementation of embedded systems in FPGAs, and the basic properties of Real-time operating systems.

## Intended learning outcomes
<!--Supplementary material will be provided either as recorded topical videos or reading material on this webpage or from relevant text books and articles.
-->

After completing this course:
* you will have knowledge of the basic building blocks and functionality of programmable logic devices
* you will have knowledge of application areas for programmable logic devices
* you will be able to design a basic digital system using a hardware description language like VHDL
* you will be able to perform simulation and synthesis of digital systems for FPGAs
* you will have basic knowledge of embedded and Real-Time operating systems, and be able to implement them on an FPGA

<!-- Update learning outcomes accoring to the book Teaching for higher education (describe, explain, analyse ...) 
After completing this course:
* you will be able to explain the basic building blocks and functionality of programmable logic devices such as FPGAs
* you will have knowledge of application areas for programmable logic devices
* you will be able to design a basic digital system using a hardware description language like VHDL
* you will be able to perform simulation and synthesis of digital systems for FPGAs
* you will have basic knowledge of embedded and Real-Time operating systems, and be able to implement them on an FPGA
Link to UiO course page for FYS4220: https://www.uio.no/studier/emner/matnat/fys/FYS4220/index-eng.html
-->

## Learning by doing:

This is a practical course where you will work with the material through a set of exercises and an embedded systems project. The exercises will cover some of the relevant concepts presented in FYS4220 and lay the foundation for solving the measurement problem presented in the case presented above. 

<!--
The most important functional requirements for the first prototype of the system are identified to be:
- RF1: The systems shall measure the acceleration in 3-axis
- RF2: The systems shall deliver the measured data to a PC

Design requirements.

The system will be based around a soft core CPU with the added peripherals required to communicate with the digital sensor and PC over standard serial interaces like UART[^footnote-uart], I2C[^footnote-i2c], and SPI[^footnote-spi]. A simplified overview of the system you will build is shown in {numref}`project-embedded-system`. 
%We will use the [Nios II](https://www.intel.com/content/www/us/en/products/programmable/processor/nios-ii.html) CPU from Intel. 


<!--
The main objective of the project assignment is to gain knowledge and experience in building a small embedded microcontroller system on an FPGA. The application of the system is to readout data from a digital sensor (accelerometer), and to present this data on a PC. 
-->

<!--
```{figure} ../images/project_embedded_system.png
---
width: 80%
align: center
name: project-embedded-system
---
Simplified overview of the embedded microcontroller system. The UART interface will be described in VHDL while the rest of the system will be generated using the Quartus Platform designer tool. 
```
-->

%The system also needs a JTAG[^footnote-jtag] interface to download the compiled program to the microcontroller system, and a memory to store these program instructions and data that is generated while the program is running. The JTAG interface will be used to both download your synthesized FPGA design to the configuration memory of the FPGA, and to download your compiled program to the internal memory of the microcontroller system.


## Content




The material that will be covered is divided into four main parts:


<!--
* An introduction to programmable logic devices and FPGAs
* VHDL
* Embedded systems
* Real-time operating systems
-->
```{figure} ../images/fys4220_overview.png
```        

The course will:
* Briefly recap the basic building blocks of digital logic relevant for FPGAs:
  * logic gates, multiplexer, flip-flops.
* Give an overview of programmable logic devices: 
  * PROM, PLA, PAL, GAL, CPLD, FPGA.
* Give an introduction to FPGA technology:
  * logic blocks, look-up tables (LUT), configuration bits, softcore and hardcore CPU.
* Give an introduction to the hardware description languague VHDL:
  * design units, description models, VHDL objects and assignments, process statements, combination logic, synchronous logic, sequential logic, state machines, tools, design flow, simulation and test benches;
* Cover basic concepts of embedded and real-time systems:
  * constraints and characteristics, 
  * hardware abstraction,
  * task, scheduling, context switch, intertask communication (messages, queues, semaphores),
  * softcore implementation on FPGA (NIOS II) and memory mapped I/O
  * basic programming c.

You will find the relevant material on this site in the format of recorded topical videos and reading material. Supplementary material may be provided as links to other relavant text books, videos, or articles. 



