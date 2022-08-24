(vhdl-history)=
# History

<div class="video-container">
<iframe width="1058" height="595" src="https://www.youtube.com/embed/2xXKKpA9o4w" title="A brief historical view on VHDL" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[[Slides]](https://www.uio.no/studier/emner/matnat/fys/FYS4220/h22/lecture-slides/vhdl_history.pdf)

Before we explain the basic structure of a VHDL file and introduce some of the basic elements of the VHDL language, it may be interesting to understand the birth of VHDL. 


Its development was motivated by a lack of adequate documentation for the behaviour and functionality of Application Specific Integrated Circuits (ASICs). In 1983 the US Department of Defence (DoD) initiated the process to develop a standardize documentation language for ASICs. Together with Intermetrics, IBM, and Texas Instrument, the first version of VHDL was finalized in 1985. VHDL was implemented in a format similar to a programming language and was in its first version a specification and modelling language that could be seen as an alternative to complex manuals. 

As a natural development, this tool was soon extended to include simulation capabilities, and logic simulators where developed in the late 1980s. Finally, the logical next step was to implement the possibility to read VHDL and output a description of the physical implementation of the circuit. This process is referred to as logic synthesis.



VHDL is today a formal notation intended for use in all phases of the creation of electronic systems. It is both machine readable and human readable, and supports different needs in the design process:

* **Development:** It can be used to describe the *structure* of a system, that is, how it is decomposed into subsystems and how these subsystems are interconnected; and it can be used to describe the *function* of these subsystems using familiar programming syntax.

* **Verification:** It can be used to *simulate* the system. This allows the designer to test the correctness of the system before it is implemented in hardware. 

* **Synthesis:** It allows the detailed structure and function of a system to be converted into a physical implementation of the circuit.


%of a design to be synthesized from a more abstract specification, allowing designers to concentrate on more strategic design decisions and reducing the time to market. 

% and testing of hardware designs.
%It supports different needs in the design process:
%This chapter will 

## IEEE standard 

To gain wide spread use, the maintenance of VHDL was handed over to *Institute of Electrical and Electronic Engineers* (IEEE). VHDL became an industry standard for specifying, verifying, and designing digital electronics.  The first IEEE standard was released in 1987: [IEEE 1076-1987](https://doi.org/10.1109/IEEESTD.1988.122645). The number 1076 identifies VHDL. Verilog, which is the other common hardware description language, also has its own IEEE standard and is identified by the number 1364. 

VHDL is in active development and the latest revision is currently:  [1076-2019](https://doi.org/10.1109/IEEESTD.2019.8938196). However, the 2019 version has just been released and there is always a lag before the various development and simulation tools supports an updated standard. E.g., the VHDL standard 1076-1993 is still the default setting in Quartus Prime Lite, while for Modelsim it is 1076-2002. On both tools this can be changed, but for the moment only to 1076-2008:
* Quartus: (Assignments --> Settings --> Compiler Settings --> VHDL input).
* Modelsim: Right click on the file to be compiled (Properties --> VHDL).

The VHDL version are typically referred to as *VHDL-year*, e.g., VHDL-87, VHDL-93, VHDL-2008. 

%For the VHDL descriptions we will write in FYS4220 are compatible with VHDL 1993.
% Other revisions are VHDL "1076-1993":"https://doi.org/10.1109/IEEESTD.1994.121433", "1076-2000":"https://doi.org/10.1109/IEEESTD.2000.92297", "1076-2002":"https://doi.org/10.1109/IEEESTD.2002.93614", "1076-2007":"".

When writing VHDL descriptions, the IEEE standard can be invoked by adding the following statements to the top of your VHDL file. 

```{code-block} vhdl
---
#caption: Including the IEEE std_logic_1164 library
#linenos: 
name: listing:vhdl_history_library 
---
library IEEE;
IEEE.std_logic_1164.all;
```

The IEEE library contains a number of packages, and the *std_logic_1164* is the standard that describes the definitions of logic values and basic logic operations. It is needed in order for the development tool to interpret e.g. the basic syntax shown below that describes an *OR* operation.

```{code-block} vhdl
Y <=  A OR B;
```

Here we have two values *A* and *B*, and the result of the *OR* operation is assigned to *Y*. Without including the *std_logic_1164*, this operation would not be understood.

This is similar to how you e.g., need to include a header file in C/C++ or import a module in Python in order to reuse code defined in other files.

%In this course we will use VHDL to describe the functionality of our designs, the tool Modelsim to simulate the behaviour of our design, and finally the Quartus Prime Lite development tool to synthesis the design and program the FPGA.

<!-- https://www.youtube.com/watch?v=4ntXSyOhlBY-->


```{admonition} Supplementary suggested reading:

Chapter 5, section 5.1 in LaMeres {cite}`lameres`.
* [Direct link html-version](https://link-springer-com.ezproxy.uio.no/chapter/10.1007/978-3-030-12489-2_5#Sec1)
* [Direct link pdf-version](https://link.springer.com/content/pdf/10.1007%2F978-3-030-12489-2_5)
```


