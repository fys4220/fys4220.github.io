(vhdl)=
 # VHDL

```{admonition} VHDL
:class: note

VHDL is a language for describing digital electronic systems {cite}`ashenden`. It is short for  _VHISC_ Hardware Description Language, 
_VHISC_: Very High Speed Integrated Circuits. 
```
## Motivation
For the embedded systems project it is required to send sensor data to the PC. Your team members have suggested that this can be achieved by using a standard serial protocol such as the UART. You therefore need to implement a UART module in your embedded systems. Since this is a frequently used protocol, a number of UART IPs implemented in VHDL or Verilog already exists. 

```{admonition} IP
:class: note

IP is short for *Intellectual Property*. For an FPGA an IP refers to a block of logic that is already available and can easily be reused. May also be referred to as IP core.

More in IPs on the [Wikipedia page on IP cores](https://en.wikipedia.org/wiki/Semiconductor_intellectual_property_core).

OpenCores.org is a website where you can find a lot of open source hardware IPs. However, keep in mind that like for open source software, the quality of open source IP cores can also vary.

```

However, since high quality IP cores are often commercial and available only at a cost. It is therefore vaulable to know how to write your own VHDL module, which then can be packaged as an IP and easily reused in a microcontroller system. 

Through the the embedded systems project seen in figure {numref}`fig:vhdl-embedded-system` you will learn how to include and use an already available IP core, and how to write your own:
* For the sensor to FPGA interface you will use an I2C or SPI IP core available from the IP core library in Quartus.
%In this part we will concentrate on VHDL. 
* While the UART to PC interface will be used as an opportunity to learn VHDL. 


```{figure} ../images/project_embedded_system.png
---
width: 80%
align: center
name: fig:vhdl-embedded-system
---
You will write the VHDL description for the UART module in the microcontroller system.
```

However, first you need to learn the basics of writing VHDL, as well as how to simulate your design to verify its correct behaviour.  This chapter will guide you through this process, and will be completed by writing the VHDL description for the UART module.




