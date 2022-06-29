# Introduction


## Description
This course gives an introduction to the design of digital and embedded systems using programmable logic (FPGA technology). This includes hardware description language (VHDL), verification and testing of digital designs, implementation of embedded systems in FPGAs, and the basic properties of Real-time operating systems.

<!--div class="video-container">
<iframe width="560" height="315"  src="https://www.youtube.com/embed/6rAz7lMBCqg" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen alt="test" position="aboslute" ></iframe>
</div-->


````{admonition} Here's your admonition alksdjføalkdjføaldkjføalkjdfølkajs adf asdf  asdfkljø adsfa asdfasdflkj adfaf asdfasfd?f
:class: dropdown

Here's the admonition content

```{dropdown} Answer:
And here's my dropdown content
```

````


**Learning by doing!**

You will learn these skills and concepts through hands-on experience – building a system to collect and present data from a sensor. 

```{figure} ../graphics/mermaid_top_level_system.pdf
---
width: 600px
align: center
name: fig:mermaid_top_level_system
---
The embedded system will be implemented on an FPGA and will be used to control the readout of data from the sensor to the PC.
```

While the main focus of you work will be to design, implement, and verify the embedded system on an FPGA, this will also require you to gain experience in other highly relevant areas such as: 
 - reading datasheets to understand how to interface the sensor,
 - writing basic Python-scripts to retrieve and present the data from the embedded system,
 - getting acquainted with the relevant design and simulation tools, and
 - using Git and Github to track and manage your work – also known as version control or source control.

The purpose of the work is to give you the necessary skills and experience that will be needed if you would develop a similar sensor readout system for e.g., your Master's thesis project or any other project. 

In this course your specific task will be to build a system to capture data from a 3-axis accelerometer ({cite}`adxl345`) , namely to measure the acceleration along the x-,y-, and z-axis of the hardware carrying the sensor, and to plot these value live on your PC. The 

The system shall work as shown in the video/figure below. 



You will be guided through this work through a set assignments that will introduce the required concepts and tools needed to successfully build and demonstrate the final system. These assignments will be complemented by relevant background material either as reading material or recorded topical videos.


The required work will be divided into 4 modules:
- Module 1: VHDL
- Module 2: The processor system
- Module 3: RTOS
- Module 4: Project


Required prerequisite knowledge: ??


You are in principle free to choose the type of sensor to work with, 

```{figure} ../images/de10-lite_layout_top.jpg 
---
width: 600px
align: center
name: fig:assignment-de10-lite
---
DE10-Lite board.
```




<!-- 
You will work with the course content through a set of assignments and an embedded systems project. Supplementary material will be provided either as recorded topical videos or reading material on this webpage or from relevant text books and articles.

We will be using a combination of Canvas and Github.uio.no (Links to an external site.) for the organisation of course material.   You will need to login to Github.uio.no (Links to an external site.) with your UiO username.   Canvas will be your central starting point for navigating through the course material. 

I will try to create a path to guide you through the course and material by using the modules feature in Canvas combined. Some material will be available directly in Canvas and some material will be provided as links to external sites or documents. -->


