 # VHDL

For the embedded systems project it is required to send sensor data to the PC. Your team members have suggested that this can be achieved by using a standard serial protocol such as the UART. You therefore need to implement a UART module in your embedded systems. Since this is a frequently used protocol,
a number of UART modules implemented in VHDL or Verilog already exists. A block of logic that already exist and can be reused is often referred to as an IP[^ip] block (or IP core). However, these are often commercial and available only at a cost. It is therefore vaulable to know how to write your own VHDL module, which can be packaged as an IP and easily reused in a microcontroller system. 

In this course you will learn how to use an already available IP core and  how to write your own. For the sensor to FPGA interface you will use an I2C or SPI IP core available from the IP core library in Quartus. We will look at how this is done when we come to the embedded systems part of the coures. For know we will concentrate on VHDL. 

, and your final responsibility will be to write the VHDL description for the UART module used to communicate with the PC will be included in the system as shown in figure {numref}`fig:vhdl-embedded-system`. 


```{figure} ../images/project_embedded_system.png
---
width: 80%
align: center
name: fig:vhdl-embedded-system
---
You will write the VHDL description for the UART module in the microcontroller system.
```

However, before you can do this you need to learn the basics of writing VHDL and howto verify correct functionality of your design through simulation. This chapter will guide you through this. 

```{admonition} VHDL
:class: note

VHDL is a language for describing digital electronic systems {cite}`ashenden`. It is short for  _VHISC_ Hardware Description Language, 
_VHISC_: Very High Speed Integrated Circuits. 
```

[^ip]: Intellectual Property: For an FPGA this refers to a block of logic that is already available and can easily be reused.



