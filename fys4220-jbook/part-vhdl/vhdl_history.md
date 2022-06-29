(vhdl-history)=
# The brief history

Before we explain the basic structure of a VHDL[^vhdl] file and introduce some of the basic elements of the VHDL language, it may be interesting to understand the birth of VHDL. Its development was motivated by a lack of adequate documentation for the behaviour and functionality of Application Specific Integrated Circuits (ASICs). In 1983 the US Department of Defence (DoD) initiated the process to develop a standardize documentation language for ASICs. Together with Intermetrics, IBM, and Texas Instrument, the first version of VHDL was finalized in 1985. VHDL was implemented in a format similar to a programming language and was in its first version a specification and modelling languague that could be seen as an alternative to complex manuals. As a natural development, this tool was soon extended to include simulation capabilities, and logic simulators where developed in the late 1980s. Finally, the logical next step was to implement the possibility to read VHDL and output a description of the physical implementation of the circuit. This process is referred to as logic synthesis.

VHDL is today a formal notation inteded for use in all phases of the creation of electronic systems. It is both machine readable and human readable, and supports
* development,
* verification,
* synthesis,
* and testing of hardware designs.

## IEEE standard 

To gain wide spread use, the maintenance of VHDL was handed over to *Institute of Electrical and Electronic Engineers* (IEEE). VHDL became an industry standard for specifying, verifying, and designing digital electronics.  The first IEEE standard was released in 1987 [IEEE 1076-1987](https://doi.org/10.1109/IEEESTD.1988.122645). The number 1076 identifies VHDL. Verilog which is the other common hardware description language also has its own IEEE standard, and is identified by the number 1364. It is an ongoing process and the latest revision is currently:  [1076-2019](https://doi.org/10.1109/IEEESTD.2019.8938196). However, the 2019 version has just been released and there is always a lag before the various development and simulation tools supports an updated standard. E.g., the VHDL standard 1076-1993 is still the default setting in Quartus Prime Lite, while for Modelsim it is 1076-2002. On both tools this can be changed, but for the moment only to 1076-2008:
* Quartus: (Assignments --> Settings --> Compiler Settings --> VHDL input).
* Modelsim: Right click on the file to be compiled (Properties --> VHDL).

%For the VHDL descriptions we will write in FYS4220 are compatible with VHDL 1993.
% Other revisions are VHDL "1076-1993":"https://doi.org/10.1109/IEEESTD.1994.121433", "1076-2000":"https://doi.org/10.1109/IEEESTD.2000.92297", "1076-2002":"https://doi.org/10.1109/IEEESTD.2002.93614", "1076-2007":"".

When writing VHDL descriptions, the standard can and must be invoked by adding the following statements to your all of your VHDL files, typically at the top of your file.

```vhdl
library IEEE;
IEEE.std_logic_1164.all;
```

The IEEE library contains a number of packages and the *std_logic_1164* is the standard that describes the definitions of logic values and basic logic operations. It is needed in order to understand e.g. the basic syntax shown below that describes an *OR* operation.

```vhdl
Y <=  A OR B;
```

Here we have two values *A* and *B*, and the result of the *OR* operation is assigned to *Y*. Without including the *std_logic_1164*, this operation would not be understood.

%In this course we will use VHDL to describe the functionality of our designs, the tool Modelsim to simulate the behaviour of our design, and finally the Quartus Prime Lite development tool to synthesis the design and program the FPGA.



[^vhdl]: VHDL: _VHISC_ Hardware Description Language, _VHISC_: Very High Speed Integrated Circuits