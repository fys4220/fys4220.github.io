# Tools

## Hardware 

### FPGA board
We will be using the [DE10-Lite](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&No=1021) development board from Terasic. This board is equipped with an [*MAX 10 FPGA*](https://www.intel.com/content/www/us/en/products/details/fpga/max/10.html) from Intel. The specific part number is: 10M50DAF484C7G.

Depending on the number of students, you may be able to borrow a board from the course instructor. In this case, the board including all cables and the box will have to be returned at the end of the semester.

```{figure} ../images/de10-lite_layout_top.jpg
---
width: 60%
align: center
name: fig:information_de10liteboard
---
The DE10-Lite FPGA board
```

### Cables

The FPGA board comes with a USB cable that can be used to power the board and to communicate with the FPGA over a JTAG-interface.

In addition we will use a UART to USB converter cable {cite}`uart-usb-cable` from FTDI chip to communicate data between the PC and the design running on the FPGA. Depending on the number of students signing up for the course, this cable may also be borrowed from the course instructor.


## Development & simulation tools

**Quartus Prime Lite:**
As we are using an FPGA from Intel we will naturally also be using development tools provided by Altera, and in particular the Quartus Prime Lite Edition design software. This tool enables analysis and synthes of designs written in hardware description languages like e.g., VHDL or Verilog, as well as the ability to download these designs to an Intel FPGA. It also includes the Nios II embedded design suite which is used to develop and download software to a Nios II microcontroller system included in the FPGA design running on the FPGA. 

The Quartus Prime Lite version can be downloaded for free and no license file is required:
* [Link to download page for Quartus Prime Lite](https://www.intel.com/content/www/us/en/collections/products/fpga/software/downloads.html?edition=lite&platform=windows&s=Newest&f:guidetmD240C377263B4C70A4EA0E452D0182CA=%5BIntel®%20Quartus®%20Prime%20Design%20Software%3BIntel®%20Quartus®%20Prime%20Lite%20Edition%5D)

**ModelSim:**
To simulate our FPGA design we will use a simulation tool called ModelSim/QuestaSim, which also can be downloaded from the link above. From version 21.1 of Quartus Prime Lite, QuestaSim is included, while for earlier versions ModelSim is included. ModelSim is a slightly "lighter" version, but for FYS4220 this makes now difference. However, one difference that may be important for you is that QuestaSim requires you to register and download a free license file. If you do not want to register you should instead use ModelSim provided with the version 18.1 of Quartus Prime Lite. These tools can be used independent of each other, e.g., you can use version 18.1 of ModelSim and version 21.1 of Quartus Prime Lite. 

```{Admonition} Note!
:class: note

From version 19.1 of Quartus Prime Lite, Cyqwin has been replaced by Ubuntu WSL as the back end for the Nios II command shell and Nios II system build tools for eclipse. This complicates the installation procedure. I therefore recommend to use version 18.1. When downloading this version, all relevant tools are included and easily installed.
 
Version 18.1 is also the version which is installed on the computers in the student laboratory. Using version 18.1 instead of later versions makes no difference for the use in FYS4220.
```

```{Admonition} For Mac users!
:class: note

If you are using Mac, note that that FPGA development tools in general support Windows and Linux and not Mac. On Macsusing an Intel processor, the alternative would be to use a virtualization tool like Parallels or Virtual Box where you can install Windows or Linux. Note that this is not possible on the later ARM processor M1 and M2, since Quartus cannot be compiled on ARM versions of Windows or Linux. 
```

### Download instructions

* Open a browser and navigate to the Quartus Prime Lite download page (Links to an external site.).
* If you do not have an Intel user account you will need to create one (Links to an external site.).
* Select edition Lite and release 18.1.
* Select the preferred operation system: Windows or Linux.
* To reduce the size of the download it is recommended to download only the needed installation files marked in figure {numref}`fig:information_quartus_download`. These are:
  * Quartus Prime (includes Nios II EDS)
  * Modelsim-Intel FPGA Edition (Includes Starter Edition)
  * MAX 10 FPGA device support
* Save all the files in the same directory.
* Start the installation by opening the Quartus Lite Setup file. This will install Quartus Prime Lite, the Nios II embedded development system, and the device support files for the MAX10 FPGA that we will be useing.
* Install Modelsim by opening the Modelsim setup file.

For more information see the [Intel FPGA software installation and licensing manual](https://www.intel.com/content/www/us/en/docs/programmable/683472/22-2/introduction-to-fpga-software-installation.html)

```{figure} ../images/quartus_download.png
---
width: 60%
align: center
name: fig:information_quartus_download
---
Make sure to double check the correct version you want to download. The files circled in read are the relevant files to download.
```

```{admonition} Note!
:class: note

USB-Blaster driver installation on Windows:

* If you have connected DE10-Lite board to you computer, and the USB-blaster does not show up in the Quartus programmer tool, you might need to [install the driver](http://www.terasic.com.tw/wiki/Altera_USB_Blaster_Driver_Installation_Instructions).

```


### Open source tools

There are some initatives to provide open source tools chains for FPGA development. However, these are still very limited. For simulation, there are on the other hand a few relatively good alternatives (also running on Mac): GHDL for simulation of VHDL, Verilator for simlation of Verilog, and GTKWave for visulations of wave diagrams. 

 - [GHDL](http://ghdl.free.fr)
 - [Verilator](https://www.veripool.org/verilator/)
 - [GTKWave](http://gtkwave.sourceforge.net)

If you prefer to use both GHDL and GTKWave in FYS4220 that is OK. However, most instructions on this site is still only provided for ModelSim. 



## Git and Github
 You will be using Git and Github.uio.no to manage your code. A Github organisation will be created for FYS4220 and each student will create their own personal Git repository within this organisation. You need to log in to Github.uio.no to activate your user before you can be added to the FYS4220 organisation.

## Student laboratory

The student laboratory is in room 329 on the 3. floor, west wing, of the Physics building. There are 16 working stations equipped with a Windows PC and an oscilloscope. Version 18.1 of the Quartus Prime Lite and Modelsim Altera starter edition are installed on the PCs. 

The room is reserved for FYS4220 on:

* Mondays from 12:15 to 16:00 ( 14:00 to 18:00 in the period 19/9–3/10)
* Wednesday from 10:15 to 14:00.

```{figure} ../images/student_lab.jpg
---
width: 60%
align: center
name: fig:information_lab
---
```
