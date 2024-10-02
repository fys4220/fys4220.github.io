(embedded-hal)=
# Hardware Abstraction Layer
In computers, a hardware abstraction layer (HAL) is a layer that allows the computer's operating system to interact with a hardware device at a general or abstract level rather than at a detailed hardware level. This layer, implemented in software, allows for device-indepencent programming by providing standard calls to hardware. {numref}`fig:embedded-hal` shows a simplified diagram for the abstraction levels of an embedded system. 

```{figure} ../images/embedded_hal.png
---
width: 60%
align: center
name: fig:embedded-hal
---
Conceptual overview of the abstraction layers for a computer system.
```

At the lowest level are functions that are implemented in hardware. For the project assignment in FYS4220 this corresponds to the UART module and how this module manipulates the UART lines (TX, RX) to communicate with another device, that is the UART communication protocol. 

The UART module is controlled from the CPU by reading and writing to a set of instruction and data registers. At the sofware level a set of device drivers are specialised to communicate with the various hardware modules through these registers. These device drivers need to have knowledge about how these registers can be manipulated to control the associated hardware functions. Integrated as part of the hardware abstraction layer, the purpose is to hide this detailed hardware information, and instead provide standardized calls for the user application. The user can then focus on the functionality of the software application rather than the physical communication with the hardware. This increases the portability of the software to different hardware platforms as long as an appropriate hardware abstraction layer and device drivders are avaible. Depending the use case, an operating system is sometimes also added to provide additional features such as for example task management and scheduling. For embedded systems, this is often a real-time operating system (RTOS).

When developing software for embedded systems, the hardware abstraction layer and RTOS are often bundled together in a board support package (BSP) that is provided for a specific hardware platform. Board support packages are typically customizable, allowing the user to specify which drivers and and routines to be included. This choice can impact the memory footprint of the system. Depending on the avaible memory for a specific hardware system, the hardware abstraction layer can be stripped down to a bare minimum, including only the necessary drivers for that specific application.

## Supporting videos:


The following video gives an introduction to the hardware abstraction layer.

<div class="video-container">
<iframe width="806" height="605" src="https://www.youtube.com/embed/6gqU9S0u3dk" title="embedded hal" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[[Slides]](https://www.uio.no/studier/emner/matnat/fys/FYS4220/h22/lecture-slides/embedded_hal.pdf)

