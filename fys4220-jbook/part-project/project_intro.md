# Project overview

The main objective of the project assignment is to gain knowledge and experience in building a small embedded microcontroller system on an FPGA. The application of the system is to readout data from a digital sensor (accelerometer), and to present and visualize this data on a PC. 

The system will be based around a soft core CPU with the added peripherals required to communicate with the digital sensor and PC over standard serial interaces like UART[^footnote-uart], I2C[^footnote-i2c], and SPI[^footnote-spi]. A simplified overview of the system you will build is shown in {numref}`project-embedded-system`. 
%We will use the [Nios II](https://www.intel.com/content/www/us/en/products/programmable/processor/nios-ii.html) CPU from Intel. 

```{figure} ../images/project_embedded_system.png
---
width: 80%
align: center
name: project-embedded-system
---
Simplified overview of the embedded microcontroller system. The UART interface will be described in VHDL while the rest of the system will be generated using the Quartus Platform designer tool. 
```


%The system also needs a JTAG[^footnote-jtag] interface to download the compiled program to the microcontroller system, and a memory to store these program instructions and data that is generated while the program is running. The JTAG interface will be used to both download your synthesized FPGA design to the configuration memory of the FPGA, and to download your compiled program to the internal memory of the microcontroller system.

%```{admonition} JTAG
%:class: info
%JTAG/boundary-scan (IEEE Std 1149.1) is an electronic four port serial JTAG interface that allows access to the special embedded logic on a %great many of today’s ICs (chips) . The JTAG accessible logic interface serves a number of functions that can include any or all of the %following:
%
%- Test logic that enables testing of connections between devices without external probes;
%- Programming logic in Flash memories, CPLD’s and FPGA’s for on-board programming of these devices;
%- Debug logic in microprocessors and microcontrollers used for software debugging, or to test connections with peripheral devices at speed %without embedded software, or to program the embedded flash in a microcontroller.
%
%Source: JTAG Technologies, www.jtag.com
%```

The CPU is connected to the respective system modules through a memory mapped bus. A memory mapped bus extend the processor's memory address space to include the modules that are conneded to the bus. This means that the modules are mapped into the CPU address space and can be accessed like memory using processor load/read and store/write cycles commands. The modules therefore need to have an internal set of registers that can be addressed to read and write data to the module.


The project will be divided into 3 main parts:

1. [Writing the UART controller](project-uart-controller)
2. [Building the microcontroller system](project-nios2)
3. [Bringing it all together with RTOS](project-rtos)

A suggested timeline for the progress of the project:

- Part 1:  20. Sept. -- 8. Oct. 
- Part 2:  11. Oct. -- 29. Oct.
- Part 3: 1. Nov. -- 19. Nov.

%```{admonition} Notice!


%```

%- Writing a VHDL UART controller with a memory mapped interface to the CPU.
%- Verify the UART controller through simulation using a VHDL test bench
%- Building and generating a soft core CPU (Nios II) using the Quartus Prime Lite Platform Designer. This includes adding a relevant IP %peripheral to communicate with the I2C or SPI interface of the digital sensor, as well as the UART controller to communicate with the PC.
%- Writing software that will run on the CPU to control and read out data from the accelerometer, and send the data to a PC over a UART %interface.
%- make use of an RTOS kernel to organize the various software functionality into dedicated tasks.
%
%
%```{admonition} The learning outcomes of this project
%- know how to describe a finite state machine in VHDL
%- memory mapped interface
%- configuration and implementation of a soft core CPU system on an FPGA
%- serial communication how to communicate with external devices and PC over 
%- configuring and 
%- reading datasheets
%- 
%```




[^footnote-uart]: Universal Asyncronous Receiver-Transmitter
[^footnote-i2c]: Inter-Integrated Circuit
[^footnote-spi]: Serial Peripheral Interface
[^footnote-jtag]: Joint Test Action Group.