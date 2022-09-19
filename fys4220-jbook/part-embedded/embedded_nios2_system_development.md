(embedded-nios2-system-development)=
# Nios II system development

Developing a microcontroller system for an FPGA can usually be divided into to main parts:

- Hardware generation process
    - Build and configure the microcontroller system
    - Translate the system description into VHDL
- Software generation process
    - Generate a board support package (based on the hardware )
    - Write and compile software application

For a general introduction and overview of the development flow watch the video below.

<div class="video-container">
<iframe width="806" height="605" src="https://www.youtube.com/embed/_z5mYM8FKTE" title="embedded nios sw development" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[[Slides]](https://www.uio.no/studier/emner/matnat/fys/FYS4220/h21/lecture-slides/embedded_niosii_sw_dev.pdf)

The video above shows some of the graphical user interface for the Software Build Tools. However, when developing the board support package and software for the main project in this course, we will used the equivalent command lines tools. This is also demonstrate in the {ref}`exercises-nios2-example`.
A short video providing information about how to use these command line tools is available below. It also shows how to configure the FPGA and download the application software to the Nios II system. 


<div class="video-container">
<iframe width="806" height="504" src="https://www.youtube.com/embed/YVdebfC1uJ8" title="FYS4220 Creating the Nios II BSP and software application from the command line" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>


