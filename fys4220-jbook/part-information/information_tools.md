# Tools

As you set upon the task of learning about FPGA and embedded system design, you will quickly notice the plethora of tools required to get the job done. You will need:
* A text editor with relevant syntax highlighting. 
* FPGA specific design tools to analyse and synthesis your HDL design, and that also can download the synthesised design to your FPGA.
* A simulation tool to test and verify your HDL design.
* A toolchain to develop and compile software to run on the processor embedded in the FPGA design (or as a hardcore processor on the FPGA chip). 
* A version control tool to keep track of your source.
* And finally, the hardware it self and the necessary laboratory equipment to test and verify you design when running on the FPGA. 

The sections below will briefly outline the tools you will encounter in this course. While some of these tools are specific for the specific type of FPGA vendor we will use in this course, the skills you learn by using these tools are transferable to tools from other FPGA. Their interfaces, integrated toolsets, and development flows may vary, but the general concepts still apply. 
 Working with the Quartus design tools from Intel (Intel aquired Altera in 2015) in this course will therefore lower your initial threshold for getting up to speed with e.g., the Vivado design tools from AMD Xilinx (ADM completed the acquisition of Xilinx in early 2022).
 

## Hardware 

We start with the hardware. In this course you will use one FPGA development board from Intel as well as two cables to power and program the FPGA and to communicate data between the FPGA and our PC. 

### FPGA board
You will be using the [DE10-Lite](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&No=1021) development board from Terasic. This board is equipped with an [*MAX 10 FPGA*](https://www.intel.com/content/www/us/en/products/details/fpga/max/10.html) from Intel. The specific part number is: 10M50DAF484C7G.

Depending on the number of students, you may be able to borrow a board from the course instructor. In this case, the board including all cables and the box will have to be returned at the end of the semester.

```{figure} ../images/de10-lite_layout_top.jpg
---
width: 90%
align: center
name: fig:information_de10liteboard
---
The DE10-Lite FPGA board
```

### Cables

The FPGA development board includes a USB cable that can be used to power the board and to both program and communicate with the FPGA a JTAG-interface. JTAG is short for Joint Test Action Group and is an industry standard for verifying designs and testing printed circuit boards after manufacture. It is widely used to provide access to processor debug functions and to program FPGAs. Learn more about JTAG [here](https://www.xjtag.com/about-jtag/what-is-jtag/).

In addition we will use a UART to USB converter cable {cite}`uart-usb-cable` from FTDI chip to communicate data between the PC and the design running on the FPGA. Depending on the number of students signing up for the course, this cable may also be borrowed from the course instructor.


## FPGA design & simulation tools

**Quartus Prime Lite:**
As we are using an FPGA from Intel we will naturally also be using development tools provided by Intel, and in particular the Quartus Prime Lite Edition design software. This tool enables analysis and synthes of designs written in hardware description languages like e.g., VHDL or Verilog, as well as the ability to download these designs to an Intel FPGA. It also includes the Nios II embedded design suite which is used to develop and download software to a Nios II microcontroller system included in the FPGA design running on the FPGA. 

The Quartus Prime Lite version can be downloaded for free and no license file is required:
* [Link to download page for Quartus Prime Lite](https://www.intel.com/content/www/us/en/collections/products/fpga/software/downloads.html?edition=lite&platform=windows&s=Newest&f:guidetmD240C377263B4C70A4EA0E452D0182CA=%5BIntel®%20Quartus®%20Prime%20Design%20Software%3BIntel®%20Quartus®%20Prime%20Lite%20Edition%5D)

Installation of Quartus Prime Lite will require that you have around 15 GB of free disk space on you computer.


**ModelSim:**
To simulate our FPGA design we will use a simulation tool called ModelSim/QuestaSim, which also can be downloaded from the link above. From version 21.1 of Quartus Prime Lite, QuestaSim is included, while for earlier versions ModelSim is included. ModelSim is a slightly "lighter" version, but for FYS4220 this makes now difference. However, one difference that may be important for you is that QuestaSim requires you to register and download a free license file. If you do not want to register you should instead use ModelSim provided with the version 18.1 of Quartus Prime Lite. These tools can be used independent of each other, e.g., you can use version 18.1 of ModelSim and version 21.1 of Quartus Prime Lite. 


```{Admonition} For Mac users!
:class: note

If you are using Mac, note that that FPGA development tools in general support Windows and Linux and not Mac. On Macsusing an Intel processor, the alternative would be to use a virtualization tool like Parallels or Virtual Box where you can install Windows or Linux. Note that this is not possible on the later ARM processor M1 and M2, since Quartus cannot be compiled on ARM versions of Windows or Linux. 
```
### Open source tools

There are some initatives to provide open source tool chains for FPGA development. However, these are still very limited. For simulation, there are on the other hand a few relatively good alternatives (also running on Mac): GHDL for simulation of VHDL, Verilator for simlation of Verilog, and GTKWave for visulations of wave diagrams. 

 - [GHDL](http://ghdl.free.fr)
 - [Verilator](https://www.veripool.org/verilator/)
 - [GTKWave](http://gtkwave.sourceforge.net)

If you prefer to use both GHDL and GTKWave in FYS4220 that is OK. However, most instructions on this site is still only provided for ModelSim. 


## Git and Github
You will be using [Git](https://git-scm.com) and Github.uio.no to manage your code. Git is a version control system that lets you manage and keep track of you source code history. Git uses so called repositories to store a collection of files of various different versions (file history) of a project). Github is a cloud-based hosting service that lets you manage Git repositories. UiO runs an enterprise version of the Github service hosted on UiO controlled servers.

A Github organisation will be created for FYS4220 and each of you will create your own personal Git repository within this organisation. A Github organization is simply an area where multiple repositories are collected and more easily managed. You will need to log in to Github.uio.no to activate your user before you can be added to the FYS4220 organisation.

More information on how to use Git will be provided when you start to work on your first exercise.
## Text editor

For some text editors are religion, e.g., [the Emacs vs vi war](https://en.wikipedia.org/wiki/Editor_war) My take on text editors is to use the one that gets the job done. Today [Visual Studio Code](https://code.visualstudio.com) has become a popular choice, but stick with the one you prefer. 

## Student laboratory

The student laboratory is in room 329 on the 3. floor, west wing, of the Physics building. There are 16 working stations equipped with a Windows PC and an oscilloscope. Version 18.1 of the Quartus Prime Lite and Modelsim Altera starter edition are installed on the PCs. 

The room is reserved for FYS4220 on:

* Mondays from 12:15 to 16:00 ( 14:00 to 18:00 in the period 19/9–3/10)
* Wednesday from 10:15 to 14:00.

```{figure} ../images/student_lab.jpg
---
width: 80%
align: center
name: fig:information_lab
---
```
