(information-download-quartus)=
# Quartus and ModelSim

To download and install Quartus and ModelSim follow the instructions below.

```{Admonition} Note!
:class: note

Starting from version 19.1 of Quartus Prime Lite, [Cyqwin](https://www.cygwin.com) has been replaced by [Windows subsystem for Linux (WSL)](https://ubuntu.com/wsl) as the backend for the Nios II command shell and Nios II system build tools for eclipse. This complicates the installation procedure (instructions can be found on the download page). We therefore recommend to use version 18.1. When downloading this version, all relevant tools are included and easily installed.
 
Version 18.1 is also the version which is installed on the computers in the student laboratory. Using version 18.1 instead of later versions makes no difference for the use in FYS4220.
```
* Open a browser and navigate to the Quartus Prime Lite [download page](https://www.intel.com/content/www/us/en/collections/products/fpga/software/downloads.html?edition=lite&platform=windows&s=Newest&f:guidetmD240C377263B4C70A4EA0E452D0182CA=%5BIntel®%20Quartus®%20Prime%20Design%20Software%3BIntel®%20Quartus®%20Prime%20Lite%20Edition%5D)
* Select the either the Windows or Linux version depending on your operating system:
  * [Intel® Quartus® Prime Lite Edition Design Software Version 21.1.1 for Windows](https://www.intel.com/content/www/us/en/software-kit/736572/intel-quartus-prime-lite-edition-design-software-version-21-1-1-for-windows.html)
  * [Intel® Quartus® Prime Lite Edition Design Software Version 21.1.1 for Linux](https://www.intel.com/content/www/us/en/software-kit/736571/intel-quartus-prime-lite-edition-design-software-version-21-1-1-for-linux.html) 
* Select version: 18.1 as shown in {numref}`fig:information_choose_quartus_version`

```{figure} ../images/information_choose_quartus_version.png
---
width: 80%
align: center
name: fig:information_choose_quartus_version
---
Choose version 18.1.
```

* To reduce the size of the download it is recommended to download only the needed installation files marked in figure {numref}`fig:information_individual_files`. These are:
  * Intel Quartus Prime (includes Nios II EDS)
  * ModelSim-Intel FPGA Edition (Includes Starter Edition)
  * Intel MAX 10 FPGA device support

```{figure} ../images/information_individual_files.png
---
width: 80%
align: center
name: fig:information_individual_files
---
Choose only the required files.
```

* Save all the files in the same directory.
* Start the installation by opening the Quartus Lite Setup file. This will install Quartus Prime Lite, the Nios II embedded development system, and the device support files for the MAX10 FPGA that we will be using.
* Install Modelsim by opening the Modelsim setup file.

```{admonition} Note!
:class: note

USB-Blaster driver installation on Windows:

* If you have connected DE10-Lite board to you computer, and the USB-blaster does not show up in the Quartus programmer tool, you might need to [install the driver](http://www.terasic.com.tw/wiki/Altera_USB_Blaster_Driver_Installation_Instructions).

```


